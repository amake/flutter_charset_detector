// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "flutter_charset_detector_darwin",
    platforms: [
        .iOS("13.0"),
        .macOS("10.15"),
    ],
    products: [
        .library(name: "flutter-charset-detector-darwin", targets: ["flutter_charset_detector_darwin"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        .package(url: "https://github.com/amake/UniversalDetector2.git", exact: "2.0.2"),
    ],
    targets: [
        .target(
            name: "flutter_charset_detector_darwin",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "UniversalDetector2", package: "UniversalDetector2"),
            ]
        )
    ]
)
