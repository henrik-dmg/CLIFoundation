import XCTest
@testable import CLIFoundation

final class CLIFoundationTests: XCTestCase {

    func testMenu() {
        let commandOne = ConsoleMenuCommand(title: "Some Command") {
            print("Test")
        }

        let commandTwo = ConsoleMenuCommand(title: "Some other Command") {
            print("More tests")
        }

        let menu = ConsoleMenu(title: "Some fancy menu", commands: [commandOne, commandTwo])
        //menu.present()
    }
    
}
