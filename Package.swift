// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CLIFoundation",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "CLIFoundation", targets: ["CLIFoundation"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", branch: "main"),
        .package(url: "https://github.com/apple/swift-format", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "CLIFoundation",
            dependencies: []
		),
        .testTarget(
            name: "CLIFoundationTests",
            dependencies: ["CLIFoundation"]
		),
    ]
)
