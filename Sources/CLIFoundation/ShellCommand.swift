import Foundation

/// Type that can be used to construct safely formated shell commands
public struct ShellCommand {

    /// The raw command that will be passed to bash
    public let rawCommand: String

    /// Initializes a new `ShellCommand` instance
    /// - Parameter string: The base command
    public init(_ string: String) {
        self.rawCommand = string
    }

    /// Appends a new flag to the existing command.
    /// - Parameters:
    ///   - flag: The flag that will be appended.If it's a short flag one dash will be used, otherwise two will be used
    ///   - shouldAppend: A Bool indicating the flag should actually be appended or not
    /// - Returns: A new `ShellCommand` instance
    public func appending(flag: String, shouldAppend: Bool = true) -> ShellCommand {
        guard shouldAppend else {
            return self
        }

        return flag.count == 1
            ? ShellCommand(rawCommand + " -\(flag)")
            : ShellCommand(rawCommand + " --\(flag)")
    }

    /// Appends a new argument to the existing command.
    /// - Parameter argument: The argument that will be appended
    /// - Returns: A new `ShellCommand` instance. If the argument is `nil`, the same command as before will returned
    public func appending(argument: String?) -> ShellCommand {
        ShellCommand([rawCommand, argument].compactMap({ $0 }).joined(separator: " "))
    }

    /// Appends a new option (key-value pair) to the existing command.
    /// - Parameters:
    ///   - option: The option flag. If it's a short flag one dash will be used, otherwise two will be used
    ///   - value: The value that should be associated with the provided flag
    /// - Returns: A new `ShellCommand` instance. If the provided value is `nil`, the same command as before will returned
    public func appending(option: String, value: Any?) -> ShellCommand {
        guard let value = value else {
            return self
        }

        return option.count == 1
            ? ShellCommand(rawCommand + " -\(option) \(value)")
            : ShellCommand(rawCommand + " --\(option) \(value)")
    }

}
