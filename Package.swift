// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Swift-CRC32C",
    products: [
        .library(
            name: "Swift-CRC32C",
            targets: ["Swift-CRC32C"]),
    ],
    targets: [
        .target(
            name: "Swift-CRC32C",
            dependencies: ["CIntelCRC"]),
        .target(name: "CIntelCRC",
                dependencies: [],
                cSettings: [
                    .unsafeFlags(["-msse4.2"]),
                ]),
        .testTarget(
            name: "Swift-CRC32CTests",
            dependencies: ["Swift-CRC32C"]),
    ]
)
