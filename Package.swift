// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "AXKit",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "AXKit",
            targets: ["AXKit"]
        )
    ],
    targets: [
        .target(
            name: "AXKit"
        ),
        .testTarget(
            name: "AXKitTests",
            dependencies: ["AXKit"]
        )
    ]
)
