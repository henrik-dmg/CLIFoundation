import Foundation

/// A type that can be used to launch bash commands
public struct Shell {

    /// A type that holds information about the output of an executed bash command
    public struct Result {

        /// The code returned by bash
        public let returnCode: Int32
        /// Data that was written to the specified output
        public let output: [String]
        /// Data that was written to the specified error output
        public let errorOutput: [String]

        init(returnCode: Int32, output: [String], errorOutput: [String]) {
            self.returnCode = returnCode
            self.output = output
            self.errorOutput = errorOutput
        }

    }

    /// Launches a shell command using bash
    /// - Parameters:
    ///   - command: The command to run
    ///   - expectedReturnCode: The expected return code
    ///   - process: Which process to use to perform the command (default: A new one)
    ///   - outputHandle: Any `FileHandle` that any output (STDOUT) should be redirected to (at the moment this is only supported on macOS)
    ///   - errorHandle: Any `FileHandle` that any error output (STDERR) should be redirected to (at the moment this is only supported on macOS)
    /// - Throws: In case the command could not be run or the expected return code did not match the resulting one
    /// - Returns: The output, error output and return code of the running command
    @discardableResult public static func execute(
        _ command: String,
        expectedReturnCode: Int32? = nil,
        process: Process = .init(),
        outputHandle: FileHandle? = nil,
        errorHandle: FileHandle? = nil) throws -> Result
    {
        try process.launchBash(with: command, expectedReturnCode: expectedReturnCode, outputHandle: outputHandle, errorHandle: errorHandle)
    }

    /// Launches a shell command using bash
    /// - Parameters:
    ///   - command: The `ShellCommand` instance that will be used to run the command
    ///   - expectedReturnCode: The expected return code
    ///   - process: Which process to use to perform the command (default: A new one)
    ///   - outputHandle: Any `FileHandle` that any output (STDOUT) should be redirected to (at the moment this is only supported on macOS)
    ///   - errorHandle: Any `FileHandle` that any error output (STDERR) should be redirected to (at the moment this is only supported on macOS)
    /// - Throws: In case the command could not be run or the expected return code did not match the resulting one
    /// - Returns: The output, error output and return code of the running command
    @discardableResult public static func execute(
        _ command: Command,
        expectedReturnCode: Int32? = nil,
        process: Process = .init(),
        outputHandle: FileHandle? = nil,
        errorHandle: FileHandle? = nil) throws -> Result
    {
        try process.launchBash(with: command.rawCommand, expectedReturnCode: expectedReturnCode, outputHandle: outputHandle, errorHandle: errorHandle)
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
