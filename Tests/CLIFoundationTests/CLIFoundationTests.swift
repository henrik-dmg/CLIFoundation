import XCTest
@testable import CLIFoundation

final class CLIFoundationTests: XCTestCase {

	func testBuilder() {
		let command = Command("jazzy") {
			Argument("some-argument")
			Flag("test-flag")
		}

		XCTAssertEqual(command.rawCommand, "jazzy some-argument --test-flag")
	}
    
}
