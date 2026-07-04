import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class BannerTests: XCTestCase {
    func testBasicBanner() throws {
        let expected = try String(
            contentsOf: fixtureURL("banner-basic.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesBanner {
                p { "Cookie notice." }
            },
            expected
        )
    }

    func testBannerWithIcon() throws {
        let expected = try String(
            contentsOf: fixtureURL("banner-with-icon.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesBanner(icon: .kind(.info)) {
                p { "New version available." }
            },
            expected
        )
    }

    func testDismissibleBanner() throws {
        let expected = try String(
            contentsOf: fixtureURL("banner-dismissible.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesBanner(dismissible: true) {
                p { "Cookie notice." }
            },
            expected
        )
    }

    func testFullBanner() throws {
        let expected = try String(
            contentsOf: fixtureURL("banner-full.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesBanner(icon: .kind(.warning), dismissible: true) {
                p { "Your session is about to expire." }
            },
            expected
        )
    }

    func testBannerWithCustomIcon() throws {
        let expected = try String(
            contentsOf: fixtureURL("banner-custom-icon.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesBanner(icon: .custom(path: "/icons/my.svg")) {
                p { "New version available." }
            },
            expected
        )
    }
}
