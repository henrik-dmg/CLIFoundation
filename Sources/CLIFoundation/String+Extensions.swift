import Foundation

public extension String {

    /// Adds the ANSII codes for the specified color to the beginning of the string and
    /// the reset code at the end to avoid coloring of the next output string in some terminals
    /// - Parameter color: The ANSII color that should be used to format the string
    /// - Returns: A new `String` instance formatted to render in the specified color in terminals
    func addingTerminalColor(_ color: Terminal.TextColor) -> String {
        return color.rawValue + self + Terminal.TextColor.default.rawValue
    }

    /// Adds the ANSII codes for the specified backgroundcolor to the beginning of the string and
    /// the reset code at the end to avoid coloring of the next output string in some terminals
    /// - Parameter color: The ANSII backgroundcolor that should be used to format the string
    /// - Returns: A new `String` instance formatted to render with the specified background color in terminals
    func addingTerminalBackgroundColor(_ color: Terminal.BackgroundColor) -> String {
        return color.rawValue + self + Terminal.BackgroundColor.default.rawValue
    }

    /// Adds the ANSII codes for the specified text decoration to the beginning of the string and
    /// the reset code at the end to avoid coloring of the next output string in some terminals
    /// - Parameter decoration: The ANSII text decoration that should be used to format the string
    /// - Returns: A new `String` instance formatted to render with the specified text decoration in terminals
    func addingTerminalTextDecoration(_ decoration: Terminal.TextDecoration) -> String {
        return decoration.rawValue + self + Terminal.TextColor.default.rawValue
    }

    /// <#Description#>
    /// - Parameters:
    ///   - color: <#color description#>
    ///   - backgroundColor: <#backgroundColor description#>
    ///   - decoration: <#decoration description#>
    /// - Returns: <#description#>
    func addingTerminalStyling(
        color: Terminal.TextColor? = nil,
        backgroundColor: Terminal.BackgroundColor? = nil,
        decoration: Terminal.TextDecoration? = nil) -> String
    {
        var outputString = self
        color.flatMap { outputString = $0.rawValue + outputString + Terminal.TextColor.default.rawValue }
        backgroundColor.flatMap { outputString = $0.rawValue + outputString + Terminal.BackgroundColor.default.rawValue }
        decoration.flatMap { outputString = $0.rawValue + outputString + Terminal.TextColor.default.rawValue }

        return outputString
    }

}
