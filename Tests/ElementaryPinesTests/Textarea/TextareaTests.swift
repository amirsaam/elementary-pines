import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class TextareaTests: XCTestCase {
    func testBasicTextarea() throws {
        let expected = try String(
            contentsOf: fixtureURL("textarea-basic.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesTextarea(placeholder: "Type your message here."),
            expected
        )
    }

    func testTextareaWithColor() throws {
        let expected = try String(
            contentsOf: fixtureURL("textarea-color-blue.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesTextarea(placeholder: "Bio", color: .blue),
            expected
        )
    }

    func testTextareaWithRows() throws {
        let expected = try String(
            contentsOf: fixtureURL("textarea-rows.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesTextarea(placeholder: "Comment", name: "comment", rows: 4),
            expected
        )
    }

    func testTextareaDisabled() throws {
        let expected = try String(
            contentsOf: fixtureURL("textarea-disabled.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesTextarea(placeholder: "Disabled", disabled: true),
            expected
        )
    }
}
