import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class SelectTests: XCTestCase {
    func testBasicSelect() throws {
        let expected = try String(
            contentsOf: fixtureURL("select-basic.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesSelect(items: [
                .init(title: "Milk", value: "milk"),
                .init(title: "Eggs", value: "eggs"),
            ]),
            expected
        )
    }

    func testSelectWithDisabledItem() throws {
        let expected = try String(
            contentsOf: fixtureURL("select-disabled.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesSelect(items: [
                .init(title: "Milk", value: "milk"),
                .init(title: "Cheese", value: "cheese", disabled: true),
            ]),
            expected
        )
    }

    func testSelectWithPlaceholder() throws {
        let expected = try String(
            contentsOf: fixtureURL("select-placeholder.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesSelect(
                items: [
                    .init(title: "Apple", value: "apple")
                ],
                placeholder: "Choose a fruit"
            ),
            expected
        )
    }

    func testSelectWithWidth() throws {
        let expected = try String(
            contentsOf: fixtureURL("select-width.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesSelect(
                items: [
                    .init(title: "One", value: "1")
                ],
                width: "w-96"
            ),
            expected
        )
    }
}
