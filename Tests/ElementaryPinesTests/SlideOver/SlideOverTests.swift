import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class SlideOverTests: XCTestCase {
    func testSlideOverBasic() throws {
        let expected = try String(contentsOf: fixtureURL("slide-over-basic.html", file: #filePath), encoding: .utf8)
        let html = pinesSlideOver(title: "Settings") {
            p(.fontWeight(.medium)) { "Open settings" }
        } content: {
            p(.fontSize(.sm), .opacity(.value(60))) { "Configure your workspace." }
        }
        HTMLAssertEqual(html, expected)
    }

    func testSlideOverNoTitle() throws {
        let expected = try String(contentsOf: fixtureURL("slide-over-no-title.html", file: #filePath), encoding: .utf8)
        let html = pinesSlideOver {
            p { "Open" }
        } content: {
            p { "Body content" }
        }
        HTMLAssertEqual(html, expected)
    }

    func testSlideOverWithColor() throws {
        let expected = try String(contentsOf: fixtureURL("slide-over-color.html", file: #filePath), encoding: .utf8)
        let html = pinesSlideOver(title: "Notifications", color: .blue) {
            p { "Open notifications" }
        } content: {
            p { "You have 3 new messages." }
        }
        HTMLAssertEqual(html, expected)
    }

    func testSlideOverWithAttributes() throws {
        let expected = try String(contentsOf: fixtureURL("slide-over-attributes.html", file: #filePath), encoding: .utf8)
        let html = pinesSlideOver(
            title: "Help",
            attributes: [HTMLAttribute<HTMLTag.div>(name: "data-testid", value: "slide-over")]
        ) {
            p { "Get help" }
        } content: {
            p { "Read the documentation." }
        }
        HTMLAssertEqual(html, expected)
    }

    func testSlideOverSizeHalf() throws {
        let expected = try String(contentsOf: fixtureURL("slide-over-half.html", file: #filePath), encoding: .utf8)
        let html = pinesSlideOver(size: .half, title: "Half") {
            p { "Open half" }
        } content: {
            p { "A half-width drawer." }
        }
        HTMLAssertEqual(html, expected)
    }

    func testSlideOverSizeFull() throws {
        let expected = try String(contentsOf: fixtureURL("slide-over-full.html", file: #filePath), encoding: .utf8)
        let html = pinesSlideOver(size: .full, title: "Full") {
            p { "Open full" }
        } content: {
            p { "A full-width drawer." }
        }
        HTMLAssertEqual(html, expected)
    }
}
