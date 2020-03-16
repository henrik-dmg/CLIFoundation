# CLIFoundation

A collection of helper methods and types to make creating CLI in Swift a breeze.

## Text

`CLIFoundation` supports text styling with these methods:

```swift
return "This what we want to print to the terminal"
	.addingTerminalColor(.red)
	.addingTerminalBackgroundColor(.yellow)
	.addingTerminalTextDecoration(.bold)
```

or through a combined convenience method:

```swift
return "This what we want to print to the terminal"
	.addingTerminalStyling(color: .red, backgroundColor.yellow, decoration: .bold)
```

### Roadmap

`CLIFoundation` only includes text styling for now, but I'm planning on adding support for executing shell commands in the future. Until then, happy coding!