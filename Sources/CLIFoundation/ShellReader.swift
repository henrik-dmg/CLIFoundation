import Foundation

public struct ShellReader {

	public static func readString(prompt: String) -> String {
		print(prompt)
		return readLine(strippingNewline: true) ?? ""
	}

	public static func readInt(prompt: String) -> Int {
		let string = readString(prompt: prompt)
		return Int(string) ?? readInt(prompt: prompt)
	}

	public static func readPassword(prompt: String) -> String? {
		var buf = [CChar](repeating: 0, count: 8192)
		guard
			let passphrase = readpassphrase(prompt, &buf, buf.count, 0),
			let passphraseString = String(validatingUTF8: passphrase)
		else {
			return nil
		}
		return passphraseString
	}

}
