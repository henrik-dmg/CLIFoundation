import Foundation

extension NSError {

    /// Initializes a new `NSError` and injects the specified description into the `userInfo` dictionary
    /// - Parameters:
    ///   - domain: The error domain
    ///   - code: The code of the occured error
    ///   - description: A textual description of the occured error
    convenience init(domain: String = "dev.panhans.CLIFoundation", code: Int = 1, description: String) {
        self.init(
            domain: domain,
            code: code,
            userInfo: [NSLocalizedFailureErrorKey: description])
    }

    /// Formats the `localizedDescription` property to be displayed in a terminal
    /// - Parameter boldText: Indicates whether or not the text should be displayed in bold or not
    /// - Returns: A terminal formatted `String`
    func makeTerminalFormatted(boldText: Bool = false) -> String {
        "[ERROR]"
            .addingTerminalStyling(color: .red)
            .appending(" \(localizedDescription)")
            .addingTerminalStyling(decoration: boldText ? .bold : nil)
    }

    /// Formats and prints the `localizedDescription` property and exits with the associated error code
    /// - Parameter boldText: Indicates whether or not the text should be displayed in bold or not
    func printAndExit(boldText: Bool = false) -> Never {
        print(makeTerminalFormatted(boldText: boldText))
        exit(Int32(code))
    }

}
