import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class BadgeStyleModifierTests: XCTestCase {
    func testSolidNeutral() throws {
        let expected = try String(
            contentsOf: fixtureURL("badge-solid-neutral.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            span { "Badge" }.pinesBadgeStyle(.solid),
            expected
        )
    }

    func testSolidBlue() throws {
        let expected = try String(
            contentsOf: fixtureURL("badge-solid-blue.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            span { "Badge" }.pinesBadgeStyle(.solid, color: .blue),
            expected
        )
    }

    func testLightBlue() throws {
        let expected = try String(
            contentsOf: fixtureURL("badge-light-blue.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            span { "New" }.pinesBadgeStyle(.light, color: .blue),
            expected
        )
    }

    func testOutlineRed() throws {
        let expected = try String(
            contentsOf: fixtureURL("badge-outline-red.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            span { "Hot" }.pinesBadgeStyle(.outline, color: .red),
            expected
        )
    }

    func testDotGreen() throws {
        let expected = try String(
            contentsOf: fixtureURL("badge-dot-green.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            span {
                span(.class("block w-1.5 h-1.5 -ml-0.5 mr-1 bg-green-500 rounded-full")) {}
                span { "Online" }
            }
            .pinesBadgeStyle(.dot, color: .green),
            expected
        )
    }

    func testIconNeutral() throws {
        let expected = try String(
            contentsOf: fixtureURL("badge-icon-neutral.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            span {
                SVG.svg(
                    attributes: [
                        .class("w-3.5 h-3.5"),
                        SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
                        SVGAttribute(name: "viewBox", value: "0 0 24 24"),
                        SVGAttribute(name: "fill", value: "currentColor"),
                    ]
                ) {
                    SVG.path(.d("M12 2L2 22h20L12 2z"))
                }
                span { "Active" }
            }
            .pinesBadgeStyle(.icon, color: .neutral),
            expected
        )
    }
}
