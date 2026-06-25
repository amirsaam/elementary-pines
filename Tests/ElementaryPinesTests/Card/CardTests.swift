import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class CardTests: XCTestCase {
    func testCanonicalCard() throws {
        let expected = try String(
            contentsOf: fixtureURL("card-canonical.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCard {
                div(.class("relative")) {
                    img(.src("https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=2370"), .class("w-full h-auto"))
                }
                div(.class("p-7")) {
                    h2 { "Product Name" }
                    p { "Description" }
                    button { "View Product" }
                }
            },
            expected
        )
    }

    func testSimpleCard() throws {
        let expected = try String(
            contentsOf: fixtureURL("card-simple.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCard {
                p { "Just a paragraph" }
            },
            expected
        )
    }

    func testImageCard() throws {
        let expected = try String(
            contentsOf: fixtureURL("card-image.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCard(.image, image: "photo.jpg") {
                h3 { "Title" }
                p { "Body" }
            },
            expected
        )
    }

    func testHorizontalCard() throws {
        let expected = try String(
            contentsOf: fixtureURL("card-horizontal.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCard(.horizontal, image: "photo.jpg") {
                h3 { "Title" }
                p { "Body" }
            },
            expected
        )
    }

    func testStatCard() throws {
        let expected = try String(
            contentsOf: fixtureURL("card-stat.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCard(.stat) {
                p(.class("text-3xl font-bold")) { "1,234" }
                p(.class("text-sm text-neutral-500")) { "Total users" }
            },
            expected
        )
    }
}
