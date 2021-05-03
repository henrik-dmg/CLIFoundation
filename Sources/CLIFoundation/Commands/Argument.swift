import Foundation

/// A command component that serves as an argument, e.g. a file path that's passed directly to an executable
public struct Argument: CommandComponent {

	let name: String?

	public var stringRepresentation: String? {
		name
	}

	/// Initialises a new `Argument` instance
	/// - Parameter name: the argument
	public init(_ name: String?) {
		self.name = name
	}

}
