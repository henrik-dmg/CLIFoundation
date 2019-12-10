import Foundation

public extension NSError {
    convenience init(code: Int = 1, reason: String) {
        self.init(domain: "com.henrikpanhans.CLIFoundation", code: code, userInfo: [NSLocalizedFailureErrorKey: reason])
    }
}
