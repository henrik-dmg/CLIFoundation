import Foundation

@resultBuilder public struct CommandBuilder {

	public static func buildBlock(_ components: CommandComponent...) -> [CommandComponent] {
		components
	}

	public static func buildEither(first component: [CommandComponent]) -> [CommandComponent] {
		component
	}

	public static func buildEither(second component: [CommandComponent]) -> [CommandComponent] {
		component
	}

	public static func buildArray(_ components: [[CommandComponent]]) -> [CommandComponent] {
		components.hp_reduce([CommandComponent]()) { result, element in
			result.append(contentsOf: element)
		}
	}

	public static func buildOptional(_ component: [CommandComponent]?) -> [CommandComponent] {
		component ?? []
	}

}

/// Protocol to wrap components that can be used with the CommandBuilder (`CommandArgument`, `CommandOption` or `CommandFlag`)
public protocol CommandComponent {

	/// The raw `String` representation of the component
	var stringRepresentation: String? { get }

}

extension Array: CommandComponent where Element == CommandComponent {

	public var stringRepresentation: String? {
		self.compactMap { $0.stringRepresentation }.joined(separator: " ")
	}

}
