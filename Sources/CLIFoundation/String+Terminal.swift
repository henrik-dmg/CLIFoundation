import Foundation

public extension String {

    /// Adds the ANSII codes for the specified color to the beginning of the string and
    /// the reset code at the end to avoid coloring of the next output string in some terminals
    func addingTerminalColor(_ color: Terminal.TextColor) -> String {
        return color.rawValue + self + Terminal.TextColor.default.rawValue
    }

    /// Adds the ANSII codes for the specified color to the beginning of the string and
    /// the reset code at the end to avoid coloring of the next output string in some terminals
    func addingTerminalBackgroundColor(_ color: Terminal.BackgroundColor) -> String {
        return color.rawValue + self + Terminal.BackgroundColor.default.rawValue
    }

    /// Adds the ANSII codes for the specified text decoration to the beginning of the string and
    /// the reset code at the end to avoid coloring of the next output string in some terminals
    func addingTerminalTextDecoration(_ decoration: Terminal.TextDecoration) -> String {
        return decoration.rawValue + self + Terminal.TextColor.default.rawValue
    }

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
