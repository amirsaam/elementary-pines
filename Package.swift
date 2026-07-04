// swift-tools-version: 6.0
import PackageDescription

let featureFlags: [SwiftSetting] = [
    .enableExperimentalFeature("StrictConcurrency=complete"),
    .enableUpcomingFeature("ExistentialAny"),
]

let package = Package(
    name: "elementary-pines",
    platforms: [
        .macOS(.v14),
        .iOS(.v15),
        .tvOS(.v17),
        .watchOS(.v10),
    ],
    products: [
        .library(name: "ElementaryPines", targets: ["ElementaryPines"])
    ],
    dependencies: [
        .package(url: "https://github.com/elementary-swift/elementary.git", from: "0.7.0")
    ],
    targets: [
        .target(
            name: "ElementaryPines",
            dependencies: [
                .product(name: "Elementary", package: "elementary")
            ],
            path: "Sources/ElementaryPines",
            swiftSettings: featureFlags
        ),
        .target(
            name: "TestUtilities",
            dependencies: [
                .product(name: "Elementary", package: "elementary")
            ],
            path: "Tests/TestUtilities",
            swiftSettings: featureFlags
        ),
        .testTarget(
            name: "ElementaryPinesTests",
            dependencies: [
                .target(name: "ElementaryPines"),
                .target(name: "TestUtilities"),
            ],
            exclude: [
                "Button/SnapshotFixtures",
                "Badge/SnapshotFixtures",
                "Card/SnapshotFixtures",
                "Icons/SnapshotFixtures",
                "Alert/SnapshotFixtures",
                "Progress/SnapshotFixtures",
                "Alpine/SnapshotFixtures",
                "Quote/SnapshotFixtures",
                "Breadcrumb/SnapshotFixtures",
                "Banner/SnapshotFixtures",
                "Input/SnapshotFixtures",
                "Textarea/SnapshotFixtures",
            ],
            swiftSettings: featureFlags
        ),
    ]
)
