// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Modules",
            targets: [
                "Core",
                "Home",
                "TitlePreview",
                "ProfilePicker",
                "TitlePlayer",
                "UpcomingSoon",
                "TopSearches"
            ]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", .branch("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Core",
            dependencies: []),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]),
        .target(
            name: "CoreUI",
            dependencies: ["Core", "SDWebImage"]),
        .target(
            name: "Networking",
            dependencies: ["Core"]),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]),
        .target(
            name: "Home",
            dependencies: ["Core", "CoreUI", "Networking", "SDWebImage"]),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"]),
        .target(
            name: "TitlePreview",
            dependencies: ["Core"]),
        .testTarget(
            name: "TitlePreviewTests",
            dependencies: ["TitlePreview"]),
        .target(
            name: "ProfilePicker",
            dependencies: ["Core"]),
        .testTarget(
            name: "ProfilePickerTests",
            dependencies: ["ProfilePicker"]),
        .target(
            name: "TitlePlayer",
            dependencies: ["Core"]),
        .testTarget(
            name: "TitlePlayerTests",
            dependencies: ["TitlePlayer"]),
        .target(
            name: "UpcomingSoon",
            dependencies: ["Core", "CoreUI", "SDWebImage"]),
        .testTarget(
            name: "UpcomingSoonTests",
            dependencies: ["UpcomingSoon"]),
        .target(
            name: "TopSearches",
            dependencies: ["Core", "CoreUI"]),
        .testTarget(
            name: "TopSearchesTests",
            dependencies: ["TopSearches"]),
    ]
)
