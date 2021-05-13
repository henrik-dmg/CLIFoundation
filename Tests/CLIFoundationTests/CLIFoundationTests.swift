import XCTest
@testable import CLIFoundation

final class CLIFoundationTests: XCTestCase {

	func testBuilder() {
		let command = Command("git") {
			CommandOption("C", value: "some/repo/path")
			CommandArgument("commit")
			CommandOption("m", value: "\"Some commit message\"")
			CommandFlag("no-verify")
		}

		XCTAssertEqual(command.rawCommand, "git -C some/repo/path commit -m \"Some commit message\" --no-verify")
	}

	func testOldCommand() {
		let command = Command("git")
			.appendingOption("C", value: "some/repo/path")
			.appendingArgument("commit")
			.appendingOption("m", value: "\"Some commit message\"")
			.appendingFlag("no-verify", shouldAppend: true)

		XCTAssertEqual(command.rawCommand, "git -C some/repo/path commit -m \"Some commit message\" --no-verify")
	}
    
}
