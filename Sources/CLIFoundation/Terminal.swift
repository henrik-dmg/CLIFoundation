import Foundation

/// A container struct for text styling in a terminal
public struct Terminal {

    /// Enum for text color ANSII codes
    public enum TextColor: String {
        /// The default color
        case `default` = "\u{001B}[0m"
        /// Black color
        case black = "\u{001B}[30m"
        /// Red color
        case red = "\u{001B}[31m"
        /// Green color
        case green = "\u{001B}[32m"
        /// Yellow color
        case yellow = "\u{001B}[33m"
        /// Blue color
        case blue = "\u{001B}[34m"
        /// Magenta color
        case magenta = "\u{001B}[35m"
        /// Cyan color
        case cyan = "\u{001B}[36m"
        /// White color
        case white = "\u{001B}[37m"
        /// Bright black color
        case brightBlack = "\u{001B}[30;1m"
        /// Bright red color
        case brightRed = "\u{001B}[31;1m"
        /// Bright green color
        case brightGreen = "\u{001B}[32;1m"
        /// Bright yellow color
        case brightYellow = "\u{001B}[33;1m"
        /// Bright blue color
        case brightBlue = "\u{001B}[34;1m"
        /// Bright magenta color
        case brightMagenta = "\u{001B}[35;1m"
        /// Bright cyan color
        case brightCyan = "\u{001B}[36;1m"
        /// Bright white color
        case brightWhite = "\u{001B}[37;1m"
    }

    /// Enum for text background color ANSII codes
    public enum BackgroundColor: String {
        /// The default color
        case `default` = "\u{001B}[0m"
        /// Black color
        case black = "\u{001B}[40m"
        /// Red color
        case red = "\u{001B}[41m"
        /// Green color
        case green = "\u{001B}[42m"
        /// Yellow color
        case yellow = "\u{001B}[43m"
        /// Blue color
        case blue = "\u{001B}[44m"
        /// Magenta color
        case magenta = "\u{001B}[45m"
        /// Cyan color
        case cyan = "\u{001B}[46m"
        /// White color
        case white = "\u{001B}[47m"
        /// Bright black color
        case brightBlack = "\u{001B}[40;1m"
        /// Bright red color
        case brightRed = "\u{001B}[41;1m"
        /// Bright green color
        case brightGreen = "\u{001B}[42;1m"
        /// Bright yellow color
        case brightYellow = "\u{001B}[43;1m"
        /// Bright blue color
        case brightBlue = "\u{001B}[44;1m"
        /// Bright magenta color
        case brightMagenta = "\u{001B}[45;1m"
        /// Bright cyan color
        case brightCyan = "\u{001B}[46;1m"
        /// Bright white color
        case brightWhite = "\u{001B}[47;1m"
    }

    /// Enum for text decoration ANSII codes
    public enum TextDecoration: String {
        /// Bold text
        case bold = "\u{001B}[1m"
        /// Underlined text
        case underline = "\u{001B}[4m"
        /// Um
        case reversed = "\u{001B}[7m"
    }

}
