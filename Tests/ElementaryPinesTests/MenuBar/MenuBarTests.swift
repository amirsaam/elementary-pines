import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class MenuBarTests: XCTestCase {
    func testMenuBarBasic() throws {
        let expected = try String(
            contentsOf: fixtureURL("menu-bar-basic.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesMenuBar(menus: [
                .init(
                    title: "File",
                    items: [
                        .item(.init(title: "New Tab", shortcut: "⌘T", action: "newTab()")),
                        .separator,
                        .item(.init(title: "Print", shortcut: "⌘P")),
                    ]
                ),
                .init(
                    title: "Edit",
                    items: [
                        .item(.init(title: "Undo", shortcut: "⌘Z")),
                        .item(.init(title: "Redo", shortcut: "⇧⌘Z")),
                        .separator,
                        .item(.init(title: "Cut")),
                        .item(.init(title: "Copy")),
                        .item(.init(title: "Paste")),
                    ]
                ),
            ]),
            expected
        )
    }

    func testMenuBarDisabled() throws {
        let expected = try String(
            contentsOf: fixtureURL("menu-bar-disabled.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesMenuBar(menus: [
                .init(
                    title: "View",
                    items: [
                        .item(.init(title: "Reload", shortcut: "⌘R")),
                        .item(.init(title: "Force Reload", shortcut: "⇧⌘R", disabled: true)),
                    ]
                )
            ]),
            expected
        )
    }

    func testMenuBarWithColor() throws {
        let expected = try String(
            contentsOf: fixtureURL("menu-bar-color.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesMenuBar(
                color: .blue,
                menus: [
                    .init(
                        title: "File",
                        items: [
                            .item(.init(title: "New Tab", shortcut: "⌘T"))
                        ]
                    )
                ]
            ),
            expected
        )
    }

    func testMenuBarAttributes() throws {
        let expected = try String(
            contentsOf: fixtureURL("menu-bar-attributes.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesMenuBar(
                attributes: [HTMLAttribute<HTMLTag.div>(name: "data-testid", value: "menubar")],
                menus: [
                    .init(
                        title: "File",
                        items: [
                            .item(.init(title: "New Window", shortcut: "⌘N"))
                        ]
                    )
                ]
            ),
            expected
        )
    }
}
