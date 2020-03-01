// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AnalyticsGen",
    platforms: [
        .macOS(.v10_12)
    ],
    products: [
        .executable(name: "AnalyticsGen", targets: ["AnalyticsGen"]),
        .library(name: "GoogleService", targets: ["GoogleService"]),
        .library(name: "GoogleTokenProvider", targets: ["GoogleTokenProvider"]),
        .library(name: "Core", targets: ["Core"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/Commander.git", from: "0.9.1"),
        .package(url: "https://github.com/kylef/PathKit.git", from: "0.9.1"),
        .package(url: "https://github.com/kylef/Stencil.git", from: "0.13.1"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "2.0.0"),
        .package(url: "https://github.com/httpswift/swifter.git", .upToNextMajor(from: "1.4.7")),
        .package(url: "https://github.com/onevcat/Rainbow", from: "3.0.0")
    ],
    targets: [
        .target(
            name: "AnalyticsGen",
            dependencies: ["Core", "GoogleTokenProvider", "GoogleService", "Commander", "PathKit", "Stencil", "Yams", "Rainbow"]),
        .target(
            name: "GoogleService",
            dependencies: ["Core", "GoogleTokenProvider"]),
        .target(
            name: "GoogleTokenProvider",
            dependencies: ["Core", "PathKit", "Swifter"]),
        .target(
            name: "Core",
            dependencies: ["PathKit"]),
        .testTarget(
            name: "AnalyticsGenTests",
            dependencies: ["AnalyticsGen"]),
    ]
)
