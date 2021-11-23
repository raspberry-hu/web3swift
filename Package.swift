// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


#if os(macOS)
let excludeFiles = [
    "./Browser/BrowserViewController.swift", // Because of inheriting iOS only class failed to build on macOS.
]
#elseif os(iOS)
let excludeFiles: String = []
#endif

let package = Package(
    name: "Web3swift",
    platforms: [
        .macOS(.v10_12), .iOS(.v11),
    ],
    products: [
        .library(name: "web3swift", targets: ["web3swift"]),
    ],
    
    dependencies: [
        .package(url: "https://github.com/attaswift/BigInt.git", from: "5.3.0"),
        .package(url: "https://github.com/mxcl/PromiseKit.git", from: "6.16.2"),
        .package(url: "https://github.com/daltoniam/Starscream.git", from: "4.0.4"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.4.2"),
    ],
    targets: [
        .target(name: "secp256k1"),
        .target(
            name: "web3swift",
            dependencies: ["BigInt", "secp256k1", "PromiseKit", "Starscream", "CryptoSwift"],
            exclude: excludeFiles,
            resources: [
                .copy("./Browser/browser.js"),
                .copy("./Browser/browser.min.js"),
                .copy("./Browser/wk.bridge.min.js")
            ]
        ),
        .testTarget(
            name: "web3swiftTests",
            dependencies: ["web3swift"]),
    ]
)
