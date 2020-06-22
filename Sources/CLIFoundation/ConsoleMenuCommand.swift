import Foundation

public struct ConsoleMenuCommand {

    public let title: String
    public let selectionHandler: () -> Void

    public init(title: String, selectionHandler: @escaping () -> Void) {
        self.title = title
        self.selectionHandler = selectionHandler
    }

}
