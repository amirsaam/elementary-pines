import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class DropdownTests: XCTestCase {
    func testDropdownBasic() throws {
        let expected = try String(
            contentsOf: fixtureURL("dropdown-basic.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesDropdown {
                img(.src("avatar.jpg"), .width(.size(8)), .height(.size(8)), .borderRadius(.full))
            } items: {
                [
                    pinesDropdownItem(.init(title: "Profile", icon: .user, shortcut: "⇧⌘P")),
                    pinesDropdownItem(.init(title: "Billing", icon: .billing, shortcut: "⌘B")),
                    pinesDropdownSeparator(),
                    pinesDropdownItem(.init(title: "Log out", icon: .lock)),
                ]
            },
            expected
        )
    }

    func testDropdownHrefAndDisabled() throws {
        let expected = try String(
            contentsOf: fixtureURL("dropdown-href.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesDropdown {
                span { "Actions" }
            } items: {
                [
                    pinesDropdownItem(.init(title: "Profile", href: "/profile")),
                    pinesDropdownItem(.init(title: "API", disabled: true)),
                    pinesDropdownItem(.init(title: "Settings", action: "openSettings()")),
                ]
            },
            expected
        )
    }

    func testDropdownCustomTrigger() throws {
        let expected = try String(
            contentsOf: fixtureURL("dropdown-trigger.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesDropdown {
                pinesIcon(.settings, size: .sm)
                span(.marginLeft(.size(2))) { "Options" }
                pinesIcon(.chevronDown, size: .sm, attributes: [.marginLeft(.size(2))])
            } items: {
                [
                    pinesDropdownItem(.init(title: "New", icon: .plus)),
                    pinesDropdownItem(.init(title: "Delete", icon: .trash)),
                ]
            },
            expected
        )
    }

    func testDropdownWithColor() throws {
        let expected = try String(
            contentsOf: fixtureURL("dropdown-color.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesDropdown(color: .blue) {
                span { "Blue Menu" }
            } items: {
                [
                    pinesDropdownItem(.init(title: "Profile", icon: .user)),
                    pinesDropdownItem(.init(title: "Settings", icon: .settings)),
                ]
            },
            expected
        )
    }

    func testDropdownPositionAndWidth() throws {
        let expected = try String(
            contentsOf: fixtureURL("dropdown-position-width.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesDropdown(position: .belowEnd, width: .size(72)) {
                span { "Actions" }
            } items: {
                [
                    pinesDropdownItem(.init(title: "New", icon: .plus))
                ]
            },
            expected
        )
    }

    func testDropdownCloseOnSelectAndDanger() throws {
        let expected = try String(
            contentsOf: fixtureURL("dropdown-close-danger.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesDropdown {
                span { "Actions" }
            } items: {
                [
                    pinesDropdownItem(.init(title: "Copy", action: "copy()", closeOnSelect: false)),
                    pinesDropdownItem(.init(title: "Delete", icon: .trash, action: "delete()", danger: true)),
                ]
            },
            expected
        )
    }

    func testDropdownRootAttributes() throws {
        let expected = try String(
            contentsOf: fixtureURL("dropdown-attributes.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesDropdown(attributes: [HTMLAttribute<HTMLTag.div>(name: "data-testid", value: "dropdown")]) {
                span { "Actions" }
            } items: {
                [
                    pinesDropdownItem(.init(title: "Profile"))
                ]
            },
            expected
        )
    }
}
