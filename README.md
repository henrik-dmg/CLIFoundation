# CLIFoundation

A collection of helper methods and types to make creating CLI in Swift a breeze.

## Shell

With `CLIFoundation` you can easily launch bash commands in Swift. You can either run a command directly or construct a `ShellCommand` to get a safe command that will be formatted correctly automatically

Raw Command:

```swift
try Shell.execute("git -C some/repo/path commit -m \"Some commit message\" --no-verify")
```

Using `ShellCommand`:

```swift
let command = ShellCommand("git")
	.appending(option: "C", value: "some/repo/path")
	.appending(argument: "commit")
	.appending(option: "m", value: "\"Some commit message\"")
	.appending(flag: "no-verify")
try Shell.execute(command)
```

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
	.addingTerminalStyling(color: .red, backgroundColor: .yellow, decoration: .bold)
```



## Contribution

I don't have a contribution and all that fancy stuff so if you want to implement changes or add new stuff, feel free to do so and just assign me the PR. Happy coding! :-)