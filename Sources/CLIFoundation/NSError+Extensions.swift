import Foundation

public extension NSError {

    convenience init(code: Int = 1, description: String) {
        self.init(
            domain: "com.henrikpanhans.CLIFoundation",
            code: code,
            userInfo: [NSLocalizedFailureErrorKey: description])
    }

    func makeTerminalFormatted(boldText: Bool = false) -> String {
        "[ERROR]"
            .addingTerminalStyling(color: .red, decoration: boldText ? .bold : nil)
            .appending(" \(localizedDescription)")
    }

    func printAndExit(boldText: Bool = false) -> Never {
        print(makeTerminalFormatted(boldText: boldText))
        exit(Int32(code))
    }

}
