import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class TooltipTests: XCTestCase {
    func testTooltipDefault() throws {
        let expected = try String(
            contentsOf: fixtureURL("tooltip-default.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesTooltip(text: "This is a tooltip") {
                button { "Hover me" }
            },
            expected
        )
    }

    func testTooltipLeftNoArrow() throws {
        let expected = try String(
            contentsOf: fixtureURL("tooltip-left-no-arrow.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesTooltip(text: "On the left", position: .left, arrow: false) {
                button { "Hover me" }
            },
            expected
        )
    }

    func testTooltipWithCustomContent() throws {
        let expected = try String(
            contentsOf: fixtureURL("tooltip-custom-content.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesTooltip(text: "More info") {
                div(.display(.flex), .items(.center), .gap(.size(2))) {
                    span { "Hover" }
                }
            },
            expected
        )
    }
}
