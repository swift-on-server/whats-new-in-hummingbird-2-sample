// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "whats-new-in-hummingbird-2-sample",
    platforms: [
        .macOS(.v14),
    ],
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.0.0-alpha.3"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Hummingbird", package: "hummingbird"),
            ]
        ),
        .testTarget(
            name: "AppTests",
            dependencies: [
                .target(name: "App"),
                .product(name: "HummingbirdXCT", package: "hummingbird"),
            ]
        ),
    ]
)
