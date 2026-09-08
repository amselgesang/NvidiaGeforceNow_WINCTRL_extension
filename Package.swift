// swift-tools-version: 5.9
import PackageDescription
let package = Package(
    name: "NVSBridge",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(name: "NVSBridge", path: "Sources/NVSBridge"),
        .testTarget(name: "NVSBridgeTests", dependencies: ["NVSBridge"], path: "Tests/NVSBridgeTests"),
    ]
)
