// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "flutter_openwrap_sdk",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "flutter-openwrap-sdk", targets: ["flutter_openwrap_sdk"])
    ],
    dependencies: [
        .package(url: "https://github.com/PubMatic/OpenWrapSDK-Swift-Package.git", exact: "4.12.0"),
    ],
    targets: [
        .target(
            name: "flutter_openwrap_sdk",
            dependencies: [
                .product(name: "OpenWrapSDK", package: "OpenWrapSDK-Swift-Package"),
            ]
        )
    ]
)
