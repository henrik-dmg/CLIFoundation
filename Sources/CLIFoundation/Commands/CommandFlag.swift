import Foundation

/// A command component that is represents a flag, e.g. `--verbose`
public struct CommandFlag: CommandComponent {

    let name: String
    let shouldAppend: Bool
    let forceShortFlag: Bool

    public var stringRepresentation: String? {
        guard shouldAppend else {
            return nil
        }
        let useOneDash = name.count == 1 || forceShortFlag
        return useOneDash ? "-\(name)" : "--\(name)"
    }

    /// Initialises a new `CommandFlag` instance
    /// - Parameters:
    ///   - name: The name of the flag. You don't need to inlcude dashes here, they will be added automatically
    ///   - shouldAppend: An optional boolean that you can use to control whether the flag should be used or not. Default is `true`.
    ///   - forceShortFlag: An optional bool that you can use to force a short flag like `-verbose` (instead of `--verbose`)
    public init(_ name: String, shouldAppend: Bool = true, forceShortFlag: Bool = false) {
        self.name = name.components(separatedBy: "-").compactMap { $0.isEmpty ? nil : $0 }.joined(separator: "-")
        self.shouldAppend = shouldAppend
        self.forceShortFlag = forceShortFlag
    }

}
