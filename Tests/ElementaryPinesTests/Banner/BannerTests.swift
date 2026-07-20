import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class BannerTests: XCTestCase {
    /// The official primary top-of-page example, with all defaults.
    func testBasicBanner() throws {
        let expected = try String(
            contentsOf: fixtureURL("banner-basic.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesBanner(
                label: "New Feature",
                message: "Click here to learn about our latest feature",
                href: "#"
            ),
            expected
        )
    }

    func testBannerWithoutIcon() throws {
        let expected = try String(
            contentsOf: fixtureURL("banner-no-icon.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesBanner(
                label: "New Feature",
                message: "Click here to learn about our latest feature",
                href: "#",
                icon: nil
            ),
            expected
        )
    }

    func testBannerWithIcon() throws {
        let expected = try String(
            contentsOf: fixtureURL("banner-with-icon.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesBanner(
                label: "New Feature",
                message: "Click here to learn about our latest feature",
                href: "#",
                icon: .kind(.info)
            ),
            expected
        )
    }

    func testBannerWithCustomIcon() throws {
        let expected = try String(
            contentsOf: fixtureURL("banner-custom-icon.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesBanner(
                label: "New Feature",
                message: "Click here to learn about our latest feature",
                href: "#",
                icon: .custom(path: "/icons/my.svg")
            ),
            expected
        )
    }

    func testNonDismissibleBanner() throws {
        let expected = try String(
            contentsOf: fixtureURL("banner-not-dismissible.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesBanner(
                label: "New Feature",
                message: "Click here to learn about our latest feature",
                href: "#",
                dismissible: false
            ),
            expected
        )
    }

    /// The official bottom-of-page example (black banner).
    func testBottomBanner() throws {
        let expected = try String(
            contentsOf: fixtureURL("banner-bottom.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesBanner(
                label: "New Feature",
                message: "Click here to learn about our latest feature",
                href: "#",
                position: .bottom
            ),
            expected
        )
    }
}
