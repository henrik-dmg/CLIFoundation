import Foundation

public struct ConsoleMenu {

    let title: String
    let commands: [ConsoleMenuCommand]

    public init(title: String, commands: [ConsoleMenuCommand]) {
        self.title = title
        self.commands = commands
    }

    public func present() {
        let menuString = buildMenuString()
        print(menuString)
        var option = -1
        while !commands.indices.contains(option - 1) {
            option = ShellReader.readInt(prompt: "Please choose an option:")
        }
        commands[option - 1].selectionHandler()
    }

    private func buildMenuString() -> String {
        var menuString = "\(title)\n\n"
        commands.enumerated().forEach {
            switch $0.offset {
            case 0...8:
                menuString += "  "
            case 9...98:
                menuString += " "
            default:
                break
            }

            menuString += "\($0.offset + 1). \($0.element.title)\n"
        }

        return menuString
    }

}

public struct ShellReader {

    static func readString(prompt: String) -> String {
        print(prompt)
        return readLine(strippingNewline: true) ?? ""
    }

    static func readInt(prompt: String) -> Int {
        let string = readString(prompt: prompt)
        return Int(string) ?? readInt(prompt: prompt)
    }

    static func readPassword(prompt: String) -> String? {
        var buf = [CChar](repeating: 0, count: 8192)
        guard
            let passphrase = readpassphrase(prompt, &buf, buf.count, 0),
            let passphraseString = String(validatingUTF8: passphrase)
        else {
            return nil
        }
        return passphraseString
    }

}
