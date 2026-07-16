import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class InputTests: XCTestCase {
    func testBasicInput() throws {
        let expected = try String(
            contentsOf: fixtureURL("input-basic.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesInput(placeholder: "Name"),
            expected
        )
    }

    func testInputWithColor() throws {
        let expected = try String(
            contentsOf: fixtureURL("input-color-blue.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesInput(type: "email", color: .blue, placeholder: "Email"),
            expected
        )
    }

    func testInputDisabled() throws {
        let expected = try String(
            contentsOf: fixtureURL("input-disabled.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesInput(placeholder: "Disabled", disabled: true),
            expected
        )
    }

    func testInputWithFormAttributes() throws {
        let expected = try String(
            contentsOf: fixtureURL("input-form-attrs.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesInput(
                type: "text",
                placeholder: "Search...",
                name: "q",
                value: "pine",
                id: "search"
            ),
            expected
        )
    }

    func testInputWithAttributes() throws {
        let expected = try String(
            contentsOf: fixtureURL("input-attributes.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesInput(placeholder: "Name", attributes: [.class("custom-class")]),
            expected
        )
    }
}
