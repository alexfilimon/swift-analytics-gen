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
        .library(name: "NetworkService", targets: ["NetworkService"]),
        .library(name: "GoogleTokenProvider", targets: ["GoogleTokenProvider"]),
        .library(name: "Core", targets: ["Core"]),
        .library(name: "Connection", targets: ["Connection"]),
        .library(name: "FileService", targets: ["FileService"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/PathKit.git", from: "0.9.1"),
        .package(url: "https://github.com/kylef/Stencil.git", from: "0.13.1"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "2.0.0"),
        .package(url: "https://github.com/httpswift/swifter.git", .upToNextMajor(from: "1.4.7")),
        .package(url: "https://github.com/onevcat/Rainbow", from: "3.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.2"),
        .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.5.0"),
        .package(url: "https://github.com/kylef/Spectre.git", from: "0.9.0")
    ],
    targets: [
        .target(
            name: "AnalyticsGen",
            dependencies: ["Core",
                           "PathKit","Rainbow", "ArgumentParser", "SPMUtility"]),
        .target(
            name: "Core",
            dependencies: ["NetworkService",
                           "PathKit", "Yams", "Stencil"]),
        .target(
            name: "NetworkService",
            dependencies: ["Connection", "GoogleTokenProvider",
                           "PathKit"]),
        .target(
            name: "GoogleTokenProvider",
            dependencies: ["Connection", "FileService",
                           "PathKit", "Swifter"]),
        .target(
            name: "FileService",
            dependencies: ["PathKit"]),
        .target(
            name: "Connection",
            dependencies: []),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core",
                           "Spectre"]),
    ]
)
