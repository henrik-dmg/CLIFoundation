//
//  File.swift
//  
//
//  Created by Henrik Panhans on 20.03.20.
//

import Foundation

public struct Shell {

    public struct Result {

        public let returnCode: Int32
        public let output: [String]
        public let errorOutput: [String]

        init(returnCode: Int32, output: [String], errorOutput: [String]) {
            self.returnCode = returnCode
            self.output = output
            self.errorOutput = errorOutput
        }

    }

    public static func execute(
        _ command: String,
        expectedReturnCode: Int32? = nil,
        process: Process = .init(),
        outputHandle: FileHandle? = nil,
        errorHandle: FileHandle? = nil) throws -> Result
    {
        try process.launchBash(with: command, expectedReturnCode: expectedReturnCode, outputHandle: outputHandle, errorHandle: errorHandle)
    }

    public static func execute(
        _ command: ShellCommand,
        expectedReturnCode: Int32? = nil,
        process: Process = .init(),
        outputHandle: FileHandle? = nil,
        errorHandle: FileHandle? = nil) throws -> Result
    {
        try process.launchBash(with: command.command, expectedReturnCode: expectedReturnCode, outputHandle: outputHandle, errorHandle: errorHandle)
    }

}

// MARK: - Private
private extension Process {
    @discardableResult func launchBash(with command: String, expectedReturnCode: Int32? = nil, outputHandle: FileHandle? = nil, errorHandle: FileHandle? = nil) throws -> Shell.Result {
        launchPath = "/bin/bash"
        arguments = ["-c", command]

        // Because FileHandle's readabilityHandler might be called from a
        // different queue from the calling queue, avoid a data race by
        // protecting reads and writes to outputData and errorData on
        // a single dispatch queue.
        let outputQueue = DispatchQueue(label: "bash-output-queue")

        var outputData = Data()
        var errorData = Data()

        let outputPipe = Pipe()
        standardOutput = outputPipe

        let errorPipe = Pipe()
        standardError = errorPipe

        #if !os(Linux)
        outputPipe.fileHandleForReading.readabilityHandler = { handler in
            let data = handler.availableData
            outputQueue.async {
                outputData.append(data)
                outputHandle?.write(data)
            }
        }

        errorPipe.fileHandleForReading.readabilityHandler = { handler in
            let data = handler.availableData
            outputQueue.async {
                errorData.append(data)
                errorHandle?.write(data)
            }
        }
        #endif

        launch()

        #if os(Linux)
        outputQueue.sync {
            outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
        }
        #endif

        waitUntilExit()

        if let handle = outputHandle, !handle.isStandard {
            handle.closeFile()
        }

        if let handle = errorHandle, !handle.isStandard {
            handle.closeFile()
        }

        #if !os(Linux)
        outputPipe.fileHandleForReading.readabilityHandler = nil
        errorPipe.fileHandleForReading.readabilityHandler = nil
        #endif

        // Block until all writes have occurred to outputData and errorData,
        // and then read the data back out.
        return try outputQueue.sync {
            if let expectedCode = expectedReturnCode, terminationStatus != expectedCode {
                throw NSError(code: Int(terminationStatus), description: errorData.shellOutput())
            }

            return Shell.Result(
                returnCode: terminationStatus,
                output: outputData.shellOutput().components(separatedBy: .newlines),
                errorOutput: errorData.shellOutput().components(separatedBy: .newlines))
        }
    }
}

private extension FileHandle {

    var isStandard: Bool {
        return self === FileHandle.standardOutput ||
            self === FileHandle.standardError ||
            self === FileHandle.standardInput
    }

}

private extension Data {

    func shellOutput() -> String {
        guard let output = String(data: self, encoding: .utf8) else {
            return ""
        }

        guard !output.hasSuffix("\n") else {
            let endIndex = output.index(before: output.endIndex)
            return String(output[..<endIndex])
        }

        return output
    }

}

extension String {

    var escapingSpaces: String {
        return replacingOccurrences(of: " ", with: "\\ ")
    }

    func appending(argument: String) -> String {
        return "\(self) \"\(argument)\""
    }

    func appending(arguments: [String]) -> String {
        return appending(argument: arguments.joined(separator: "\" \""))
    }

    mutating func append(argument: String) {
        self = appending(argument: argument)
    }

    mutating func append(arguments: [String]) {
        self = appending(arguments: arguments)
    }

}
