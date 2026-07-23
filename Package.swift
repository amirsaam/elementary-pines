// swift-tools-version: 6.1
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
        .package(url: "https://github.com/amirsaam/elementary-alpine.git", from: "0.4.000")
    ],
    targets: [
        .target(
            name: "ElementaryPines",
            dependencies: [
                .product(name: "ElementaryAlpine", package: "elementary-alpine")
            ],
            path: "Sources/ElementaryPines",
            swiftSettings: featureFlags
        ),
        .target(
            name: "TestUtilities",
            dependencies: [
                .product(name: "ElementaryAlpine", package: "elementary-alpine")
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
                "Select/SnapshotFixtures",
                "Checkbox/SnapshotFixtures",
                "RadioGroup/SnapshotFixtures",
                "Switch/SnapshotFixtures",
                "RangeSlider/SnapshotFixtures",
                "Rating/SnapshotFixtures",
                "DatePicker/SnapshotFixtures",
            ],
            swiftSettings: featureFlags
        ),
    ]
)
