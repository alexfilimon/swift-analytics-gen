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
        .library(name: "Parsers", targets: ["Parsers"]),
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
            dependencies: ["Models", "Core", "GoogleTokenProvider", "GoogleService", "Parsers", "Commander", "PathKit", "Stencil", "Yams", "Rainbow"]),
        .target(
            name: "Parsers",
            dependencies: ["Models", "Core", "GoogleTokenProvider", "GoogleService"]),
        .target(
            name: "GoogleService",
            dependencies: ["Models", "Core", "GoogleTokenProvider"]),
        .target(
            name: "GoogleTokenProvider",
            dependencies: ["Models", "Core", "PathKit", "Swifter"]),
        .target(
            name: "Core",
            dependencies: ["Models", "PathKit"]),
        .target(
            name: "Models",
            dependencies: []),
        .testTarget(
            name: "AnalyticsGenTests",
            dependencies: ["AnalyticsGen"]),
    ]
)
