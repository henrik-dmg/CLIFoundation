import Foundation

extension Sequence {

	func hp_reduce<T>(_ initialResult: T, closure: (inout T, Element) -> Void) -> T {
		var result = initialResult
		forEach {
			closure(&result, $0)
		}
		return result
	}

}
