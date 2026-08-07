import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class PopoverTests: XCTestCase {
    func testPopoverBasic() throws {
        let expected = try String(
            contentsOf: fixtureURL("popover-basic.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesPopover {
                pinesIcon(.settings, size: .sm)
            } content: {
                p(.fontWeight(.medium)) { "Dimensions" }
                p(.fontSize(.sm), .opacity(.value(60))) { "Set the dimensions for the layer." }
            },
            expected
        )
    }

    func testPopoverTopNoArrow() throws {
        let expected = try String(
            contentsOf: fixtureURL("popover-top-no-arrow.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesPopover(position: .top, arrow: false) {
                pinesIcon(.info, size: .sm)
            } content: {
                p { "Help" }
            },
            expected
        )
    }

    func testPopoverCustomWidthAndAttributes() throws {
        let expected = try String(
            contentsOf: fixtureURL("popover-width-attributes.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesPopover(width: .size(96), attributes: [HTMLAttribute<HTMLTag.div>(name: "data-testid", value: "popover")]) {
                span { "Trigger" }
            } content: {
                p { "Content" }
            },
            expected
        )
    }

    func testPopoverWithColor() throws {
        let expected = try String(
            contentsOf: fixtureURL("popover-color.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesPopover(color: .blue) {
                pinesIcon(.user, size: .sm)
            } content: {
                p { "Account" }
            },
            expected
        )
    }
}
