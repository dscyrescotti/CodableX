// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CodableX",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_11),
        .tvOS(.v9),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "CodableX",
            targets: ["CodableX"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CodableX",
            dependencies: []),
        .testTarget(
            name: "CodableXTests",
            dependencies: ["CodableX"]),
    ],
    swiftLanguageVersions: [.v5]
)
