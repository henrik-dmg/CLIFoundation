import XCTest
@testable import CLIFoundation

final class CLIFoundationTests: XCTestCase {

	func testBuilder() {
		let command = Command("git") {
			Option("C", value: "some/repo/path")
			Argument("commit")
			Option("m", value: "\"Some commit message\"")
			Flag("no-verify")
		}

		XCTAssertEqual(command.rawCommand, "git -C some/repo/path commit -m \"Some commit message\" --no-verify")
	}

	func testOldCommand() {
		let command = Command("git")
			.appendingOption("C", value: "some/repo/path")
			.appendingArgument("commit")
			.appendingOption("m", value: "\"Some commit message\"")
			.appendingFlag("no-verify", shouldAppend: false)

		XCTAssertEqual(command.rawCommand, "git -C some/repo/path commit -m \"Some commit message\" --no-verify")
	}
    
}
