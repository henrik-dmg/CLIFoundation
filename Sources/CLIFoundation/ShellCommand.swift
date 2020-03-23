import Foundation

public struct ShellCommand {

    let command: String

    public init(_ string: String) {
        self.command = string
    }

    public func appending(flag: String, shouldAppend: Bool = true) -> ShellCommand {
        guard shouldAppend else {
            return self
        }

        return flag.count == 1
            ? ShellCommand(command + " -\(flag)")
            : ShellCommand(command + " --\(flag)")
    }

    public func appending(argument: String?) -> ShellCommand {
        ShellCommand([command, argument].compactMap({ $0 }).joined(separator: " "))
    }

    public func appending(option: String, value: Any?) -> ShellCommand {
        guard let value = value else {
            return self
        }

        return option.count == 1
            ? ShellCommand(command + " -\(option) \(value)")
            : ShellCommand(command + " --\(option) \(value)")
    }

}
