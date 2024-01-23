// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(OSX)
let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.1.0"),
]
#else
let dependencies: [Package.Dependency] = []
#endif

let package = Package(
    name: "CLIFoundation",
    products: [
        .library(name: "CLIFoundation", targets: ["CLIFoundation"])
    ],
    dependencies: dependencies,
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
