// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-crc32c",
    products: [
        .library(
            name: "CRC32C",
            targets: ["CRC32C"]),
        .executable(name: "GenerateLookupTable",
                    targets: ["GenerateLookupTable"]),
        .executable(name: "crc32c",
                    targets: ["crc32c-tool"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.15.0"),
    ],
    targets: [
        .target(
            name: "CRC32C",
            dependencies: ["CIntelCRC"],
            swiftSettings: [
            .define("USE_HARDWARE")
        ]),
        .target(name: "CRC32CNIOSupport",
                dependencies: ["CRC32C",
                               .product(name: "NIO", package: "swift-nio")]),
        .target(name: "CIntelCRC"),
        .testTarget(
            name: "CRC32CTests",
            dependencies: ["CRC32C"]),
        .testTarget(
            name: "CRC32CNIOSupportTests",
            dependencies: ["CRC32CNIOSupport",
                           .product(name: "NIO", package: "swift-nio")]),
        .target(name: "GenerateLookupTable"),
        .target(name: "crc32c-tool",
                dependencies:["CRC32C",
                              .product(name: "NIO", package: "swift-nio")])
    ]
)
