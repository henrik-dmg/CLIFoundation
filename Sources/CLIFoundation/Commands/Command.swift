import Foundation

@available(*, deprecated, renamed: "Command")
public typealias ShellCommand = Command

/// Type that can be used to construct safely formated shell commands
public struct Command {

    /// The raw command that will be passed to bash
    public let rawCommand: String

    /// Initializes a new `ShellCommand` instance
    /// - Parameter baseCommand: The base command
    public init(_ baseCommand: String) {
        self.rawCommand = baseCommand
    }

    /// Initializes a new `ShellCommand` instance
    /// - Parameters:
    /// 	- baseCommand: The base command
    /// 	- builder: The component builder closure used to construct the full command
    public init(_ baseCommand: String, @CommandBuilder _ builder: () -> [CommandComponent?]) {
        let components = builder().compactMap { $0?.stringRepresentation }
        let rawCommand = ([baseCommand] + components).joined(separator: " ")
        self.init(rawCommand)
    }

    /// Appends a new flag to the existing command.
    /// - Parameters:
    ///   - flag: The flag that will be appended.If it's a short flag one dash will be used, otherwise two will be used
    ///   - shouldAppend: A Bool indicating the flag should actually be appended or not
    /// - Returns: A new `ShellCommand` instance
    @available(*, deprecated, renamed: "appendingFlag(_:shouldAppend:)")
    public func appending(flag: String, shouldAppend: Bool = true) -> Command {
        appendingFlag(flag, shouldAppend: shouldAppend)
    }

    /// Appends a new flag to the existing command.
    /// - Parameters:
    ///   - flag: The flag that will be appended.If it's a short flag one dash will be used, otherwise two will be used
    ///   - shouldAppend: A Bool indicating the flag should actually be appended or not
    /// - Returns: A new `ShellCommand` instance
    public func appendingFlag(_ flag: String, shouldAppend: Bool = true) -> Command {
        guard shouldAppend else {
            return self
        }

        return flag.count == 1
            ? Command(rawCommand + " -\(flag)")
            : Command(rawCommand + " --\(flag)")
    }

    /// Appends a new argument to the existing command.
    /// - Parameter argument: The argument that will be appended
    /// - Returns: A new `ShellCommand` instance. If the argument is `nil`, the same command as before will returned
    @available(*, deprecated, renamed: "appendingArgument(_:)")
    public func appending(argument: String?) -> Command {
        appendingArgument(argument)
    }

    /// Appends a new argument to the existing command.
    /// - Parameter argument: The argument that will be appended
    /// - Returns: A new `ShellCommand` instance. If the argument is `nil`, the same command as before will returned
    public func appendingArgument(_ argument: String?) -> Command {
        Command([rawCommand, argument].compactMap({ $0 }).joined(separator: " "))
    }

    /// Appends a new option (key-value pair) to the existing command.
    /// - Parameters:
    ///   - option: The option flag. If it's a short flag one dash will be used, otherwise two will be used
    ///   - value: The value that should be associated with the provided flag
    /// - Returns: A new `ShellCommand` instance. If the provided value is `nil`, the same command as before will returned
    @available(*, deprecated, renamed: "appendingOption(_:value:)")
    public func appending(option: String, value: Any?) -> Command {
        appendingOption(option, value: value)
    }

    /// Appends a new option (key-value pair) to the existing command.
    /// - Parameters:
    ///   - option: The option flag. If it's a short flag one dash will be used, otherwise two will be used
    ///   - value: The value that should be associated with the provided flag
    /// - Returns: A new `ShellCommand` instance. If the provided value is `nil`, the same command as before will returned
    public func appendingOption(_ option: String, value: Any?) -> Command {
        guard let value = value else {
            return self
        }

        return option.count == 1
            ? Command(rawCommand + " -\(option) \(value)")
            : Command(rawCommand + " --\(option) \(value)")
    }

}
