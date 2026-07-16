import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class SwitchTests: XCTestCase {
    func testDefault() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesSwitch-default.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesSwitch(labelText: "Enable Feature", name: "feature", id: "feature"),
            expected
        )
    }

    func testColor() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesSwitch-color.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesSwitch(labelText: "Wi-Fi", color: .green, name: "wifi", id: "wifi"),
            expected
        )
    }

    func testSmall() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesSwitch-small.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesSwitch(labelText: "Small", size: .small, name: "small", id: "small"),
            expected
        )
    }

    func testChecked() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesSwitch-checked.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesSwitch(labelText: "Airplane Mode", name: "airplane", id: "airplane", checked: true),
            expected
        )
    }

    func testDisabled() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesSwitch-disabled.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesSwitch(labelText: "Disabled", name: "disabled", id: "disabled", disabled: true),
            expected
        )
    }

    func testSwitchWithAttributes() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesSwitch-attributes.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesSwitch(
                labelText: "Enable Feature",
                name: "feature",
                id: "feature",
                attributes: [.class("custom-class")]
            ),
            expected
        )
    }
}
