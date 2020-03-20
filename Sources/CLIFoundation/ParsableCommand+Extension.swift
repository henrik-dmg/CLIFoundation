import ArgumentParser
import Foundation

public extension ParsableCommand {

    static func hp_main(_ arguments: [String]? = nil) -> Never {
        do {
            let command = try parseAsRoot(arguments)
            try command.run()
            exit()
        } catch let error as NSError {
            print(error.makeTerminalFormatted())
            Darwin.exit(Int32(error.code))
        }
    }

}
