import Foundation

public extension Error {

    func makeTerminalFormatted(boldText: Bool = false) -> String {
        let errorString = "Error: \(localizedDescription)"
        return errorString.addingTerminalStyling(color: .red, decoration: boldText ? .bold : nil)
    }

}
