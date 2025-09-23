// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UXTrackerSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "UXTrackerSDK",
            targets: ["UXTrackerSDK"]
        ),
    ],
    targets: [
        .target(
            name: "UXTrackerSDK",
            path: "Sources/uxtracker-sdk-ios"  // explicitly point to your folder
        ),
        .testTarget(
            name: "UXTrackerSDKTests",
            dependencies: ["UXTrackerSDK"],
            path: "Tests"
        ),
    ]
)
