import Foundation

public enum TextColor: String {
    case `default` = "\u{001B}[0m"
    case black = "\u{001B}[30m"
    case red = "\u{001B}[31m"
    case green = "\u{001B}[32m"
    case yellow = "\u{001B}[33m"
    case blue = "\u{001B}[34m"
    case magenta = "\u{001B}[35m"
    case cyan = "\u{001B}[36m"
    case white = "\u{001B}[37m"
    case brightBlack = "\u{001B}[30;1m"
    case brightRed = "\u{001B}[31;1m"
    case brightGreen = "\u{001B}[32;1m"
    case brightYellow = "\u{001B}[33;1m"
    case brightBlue = "\u{001B}[34;1m"
    case brightMagenta = "\u{001B}[35;1m"
    case brightCyan = "\u{001B}[36;1m"
    case brightWhite = "\u{001B}[37;1m"
}

public enum BackgroundColor: String {
    case `default` = "\u{001B}[0m"
    case black = "\u{001B}[40m"
    case red = "\u{001B}[41m"
    case green = "\u{001B}[42m"
    case yellow = "\u{001B}[43m"
    case blue = "\u{001B}[44m"
    case magenta = "\u{001B}[45m"
    case cyan = "\u{001B}[46m"
    case white = "\u{001B}[47m"
    case brightBlack = "\u{001B}[40;1m"
    case brightRed = "\u{001B}[41;1m"
    case brightGreen = "\u{001B}[42;1m"
    case brightYellow = "\u{001B}[43;1m"
    case brightBlue = "\u{001B}[44;1m"
    case brightMagenta = "\u{001B}[45;1m"
    case brightCyan = "\u{001B}[46;1m"
    case brightWhite = "\u{001B}[47;1m"
}

public enum TextDecoration: String {
    case bold = "\u{001B}[1m"
    case underline = "\u{001B}[4m"
    case reversed = "\u{001B}[7m"
}

public extension String {
    func with(_ color: TextColor) -> String {
        return color.rawValue + self + TextColor.default.rawValue
    }

    func withBg(_ color: BackgroundColor) -> String {
        return color.rawValue + self + BackgroundColor.default.rawValue
    }

    func with(_ decoration: TextDecoration) -> String {
        return decoration.rawValue + self + TextColor.default.rawValue
    }
}
