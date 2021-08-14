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
        .library(name: "Core", targets: ["Core"])
    ],
    dependencies: [
        .package(url: "https://github.com/alexfilimon/SwiftConnection", from: "1.0.4"),
        .package(url: "https://github.com/alexfilimon/GoogleTokenProvider", from: "1.0.4"),

        .package(url: "https://github.com/kylef/PathKit.git", from: "0.9.1"),
        .package(url: "https://github.com/kylef/Stencil.git", from: "0.13.1"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "2.0.0"),
        .package(url: "https://github.com/httpswift/swifter.git", .upToNextMajor(from: "1.4.7")),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.3"),
        .package(url: "https://github.com/kylef/Spectre.git", from: "0.9.0"),
        .package(url: "https://github.com/apple/swift-tools-support-core", from: "0.2.3"),
    ],
    targets: [
        .target(
            name: "AnalyticsGen",
            dependencies: ["Core",
                           "PathKit", "ArgumentParser", "SwiftToolsSupport-auto"]),
        .target(
            name: "Core",
            dependencies: ["NetworkService",
                           "PathKit", "Yams", "Stencil"]),
        .target(
            name: "NetworkService",
            dependencies: ["SwiftConnection", "GoogleTokenProvider",
                           "PathKit"]),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core",
                           "Spectre"]),
    ]
)
