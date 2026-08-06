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
        .package(url: "https://github.com/amirsaam/elementary-alpine.git", from: "0.4.000"),
        .package(url: "https://github.com/amirsaam/elementary-tailwind.git", from: "0.3.700"),
    ],
    targets: [
        .target(
            name: "ElementaryPines",
            dependencies: [
                .product(name: "ElementaryAlpine", package: "elementary-alpine"),
                .product(name: "ElementaryTailwind", package: "elementary-tailwind"),
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
                "Accordion/SnapshotFixtures",
                "Alert/SnapshotFixtures",
                "Alpine/SnapshotFixtures",
                "Badge/SnapshotFixtures",
                "Banner/SnapshotFixtures",
                "Breadcrumb/SnapshotFixtures",
                "Button/SnapshotFixtures",
                "Card/SnapshotFixtures",
                "Checkbox/SnapshotFixtures",
                "DatePicker/SnapshotFixtures",
                "Dropdown/SnapshotFixtures",
                "Icons/SnapshotFixtures",
                "Input/SnapshotFixtures",
                "Progress/SnapshotFixtures",
                "Quote/SnapshotFixtures",
                "RadioGroup/SnapshotFixtures",
                "RangeSlider/SnapshotFixtures",
                "Rating/SnapshotFixtures",
                "Select/SnapshotFixtures",
                "Switch/SnapshotFixtures",
                "Tabs/SnapshotFixtures",
                "Textarea/SnapshotFixtures",
                "Toast/SnapshotFixtures",
                "Tooltip/SnapshotFixtures",
            ],
            swiftSettings: featureFlags
        ),
    ]
)
