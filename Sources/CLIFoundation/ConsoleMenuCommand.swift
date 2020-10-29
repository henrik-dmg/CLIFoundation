import Foundation

public struct ConsoleMenuCommand {

    public let title: String
    public let selectionHandler: () throws -> Void

    public init(title: String, selectionHandler: @escaping () throws -> Void) {
        self.title = title
        self.selectionHandler = selectionHandler
    }

}
