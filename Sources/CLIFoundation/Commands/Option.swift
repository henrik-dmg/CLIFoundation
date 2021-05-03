import Foundation

/// A command component that is represents an option, e.g. `--theme full-width`
public struct Option: CommandComponent {

	let name: String
	let value: Any?
	let forceShortOption: Bool

	public var stringRepresentation: String? {
		guard let value = value else {
			return nil
		}
		let useOneDash = name.count == 1 || forceShortOption
		return useOneDash ? "-\(name) \(value)" : "--\(name) \(value)"
	}

	/// Initialises a new `Flag` instance
	/// - Parameters:
	///   - name: The name of the flag. You don't need to inlcude dashes here, they will be added automatically
	///   - value: The value of the flag. If the value is `nil`, the option will be ignored
	///   - isShortOption: An optional bool that you can use to force one dash instead of two, like `-theme full-width` (instead of `--theme full-width`)
	public init(_ name: String, value: Any?, forceShortOption: Bool = false) {
		self.name = name
		self.value = value
		self.forceShortOption = forceShortOption
	}

}
