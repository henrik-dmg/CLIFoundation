// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CLIFoundation",
    products: [
        .library(name: "CLIFoundation", targets: ["CLIFoundation"])
    ],
    targets: [
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
