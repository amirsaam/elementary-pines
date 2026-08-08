import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class ModalTests: XCTestCase {
    func testModalBasic() throws {
        let expected = try String(
            contentsOf: fixtureURL("modal-basic.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesModal {
                p(.fontWeight(.medium)) { "Open modal" }
            } content: {
                h3(.fontSize(.lg), .fontWeight(.semibold)) { "Settings" }
                p(.fontSize(.sm), .opacity(.value(60))) { "Configure your workspace." }
            },
            expected
        )
    }

    func testModalWithColor() throws {
        let expected = try String(
            contentsOf: fixtureURL("modal-color.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesModal(color: .blue) {
                p(.fontWeight(.medium)) { "Open" }
            } content: {
                h3(.fontSize(.lg), .fontWeight(.semibold)) { "Account" }
            },
            expected
        )
    }

    func testModalAttributes() throws {
        let expected = try String(
            contentsOf: fixtureURL("modal-attributes.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesModal(
                attributes: [HTMLAttribute<HTMLTag.div>(name: "data-testid", value: "modal")],
                trigger: {
                    p(.fontWeight(.medium)) { "Launch" }
                },
                content: {
                    p { "Hello" }
                }
            ),
            expected
        )
    }
}
