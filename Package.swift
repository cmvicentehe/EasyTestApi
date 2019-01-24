// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "EasyTestAPI",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.1.1"),
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.2"),
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentSQLite", "Vapor", "Leaf"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

