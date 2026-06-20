import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class ButtonStyleModifierTests: XCTestCase {
    func testSolidNeutral() throws {
        let expected = try String(
            contentsOf: fixtureURL("button-solid-neutral.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            button { "Button" }.pinesButtonStyle(.solid),
            expected
        )
    }

    func testSolidBlue() throws {
        let expected = try String(
            contentsOf: fixtureURL("button-solid-blue.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            button { "Save" }.pinesButtonStyle(.solid, color: .blue),
            expected
        )
    }

    func testTonalRed() throws {
        let expected = try String(
            contentsOf: fixtureURL("button-tonal-red.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            button { "Cancel" }.pinesButtonStyle(.tonal, color: .red),
            expected
        )
    }

    func testOutlineYellow() throws {
        let expected = try String(
            contentsOf: fixtureURL("button-outline-yellow.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            button { "Delete" }.pinesButtonStyle(.outline, color: .yellow),
            expected
        )
    }
}
