import Foundation

@resultBuilder public struct CommandBuilder {

    public static func buildBlock(_ components: [CommandComponent]...) -> [CommandComponent] {
        components.flatMap { $0 }
    }

    /// Add support for both single and collections of constraints.
    public static func buildExpression(_ expression: CommandComponent) -> [CommandComponent] {
        [expression]
    }

    public static func buildExpression(_ expression: [CommandComponent]) -> [CommandComponent] {
        expression
    }

    /// Add support for optionals.
    public static func buildOptional(_ components: [CommandComponent]?) -> [CommandComponent] {
        components ?? []
    }

    /// Add support for if statements.
    public static func buildEither(first components: [CommandComponent]) -> [CommandComponent] {
        components
    }

    public static func buildEither(second components: [CommandComponent]) -> [CommandComponent] {
        components
    }

    public static func buildArray(_ components: [[CommandComponent]]) -> [CommandComponent] {
        components.flatMap { $0 }
    }

    public static func buildLimitedAvailability(_ component: [CommandComponent]) -> [CommandComponent] {
        component
    }

}

/// Protocol to wrap components that can be used with the CommandBuilder (`CommandArgument`, `CommandOption` or `CommandFlag`)
public protocol CommandComponent {

	/// The raw `String` representation of the component
	var stringRepresentation: String? { get }

}

extension [CommandComponent]: CommandComponent {

	public var stringRepresentation: String? {
		compactMap { $0.stringRepresentation }.joined(separator: " ")
	}

}
