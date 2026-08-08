import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class CommandTests: XCTestCase {
    func testCommandBasic() throws {
        let expected = try String(contentsOf: fixtureURL("command-basic.html", file: #filePath), encoding: .utf8)
        let html = pinesCommand(items: [
            .init(title: "Calendar", value: "calendar", icon: .calendar, category: "Suggestions"),
            .init(title: "Search Emoji", value: "emoji", icon: .search, category: "Suggestions"),
            .init(title: "Calculator", value: "calculator", icon: .plus, category: "Suggestions"),
            .init(title: "Profile", value: "profile", icon: .user, shortcut: "⌘P", category: "Settings"),
            .init(title: "Billing", value: "billing", icon: .billing, shortcut: "⌘B", category: "Settings"),
            .init(title: "Settings", value: "settings", icon: .settings, shortcut: "⌘S", category: "Settings"),
        ])
        HTMLAssertEqual(html, expected)
    }

    func testCommandWithActionAndDisabled() throws {
        let expected = try String(contentsOf: fixtureURL("command-action-disabled.html", file: #filePath), encoding: .utf8)
        let html = pinesCommand(
            items: [
                .init(title: "Copy", value: "copy", icon: .copy, category: "Actions", action: "copy()"),
                .init(title: "Delete", value: "delete", icon: .trash, category: "Danger", disabled: true, action: "remove()"),
            ],
            placeholder: "Search commands..."
        )
        HTMLAssertEqual(html, expected)
    }

    func testCommandWithColor() throws {
        let expected = try String(contentsOf: fixtureURL("command-color.html", file: #filePath), encoding: .utf8)
        let html = pinesCommand(
            color: .blue,
            items: [
                .init(title: "Profile", value: "profile", icon: .user, category: "Settings"),
                .init(title: "Settings", value: "settings", icon: .settings, category: "Settings"),
            ]
        )
        HTMLAssertEqual(html, expected)
    }

    func testCommandWithAttributes() throws {
        let expected = try String(contentsOf: fixtureURL("command-attributes.html", file: #filePath), encoding: .utf8)
        let html = pinesCommand(
            items: [
                .init(title: "New", value: "new", icon: .plus)
            ],
            attributes: [HTMLAttribute<HTMLTag.div>(name: "data-testid", value: "command")]
        )
        HTMLAssertEqual(html, expected)
    }
}
