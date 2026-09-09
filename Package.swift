// swift-tools-version: 5.9
import PackageDescription
let package = Package(
    name: "GFNBridge",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(name: "GFNBridge", path: "Sources/GFNBridge"),
        .testTarget(name: "GFNBridgeTests", dependencies: ["GFNBridge"], path: "Tests/GFNBridgeTests"),
    ]
)
