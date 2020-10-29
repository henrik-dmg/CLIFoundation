import Foundation

public struct ConsoleMenu {

    let title: String
    let commands: [ConsoleMenuCommand]

    public init(title: String, commands: [ConsoleMenuCommand]) {
        self.title = title
        self.commands = commands
    }

    public func present() throws {
        let menuString = buildMenuString()
        print(menuString)
        var option = -1
        while !commands.indices.contains(option - 1) {
            option = ShellReader.readInt(prompt: "Please choose an option:")
        }
        try commands[option - 1].selectionHandler()
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
