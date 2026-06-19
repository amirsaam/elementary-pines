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
    products: [],
    dependencies: [],
    targets: [
        .target(
            name: "ElementaryPines",
            path: "Sources/ElementaryPines",
            swiftSettings: featureFlags
        ),
        .testTarget(
            name: "ElementaryPinesTests",
            dependencies: [
                .target(name: "ElementaryPines")
            ],
            swiftSettings: featureFlags
        ),
    ]
)
