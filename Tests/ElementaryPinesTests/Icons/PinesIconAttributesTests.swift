import Elementary
import ElementaryPines
import TestUtilities
import XCTest

/// Snapshot tests for the `attributes:` parameter on `pinesIcon`. Verifies
/// that user-supplied HTMLAttribute values are merged onto the rendered
/// `<svg>` — classes are appended to the default size/color class, and
/// other attributes (Alpine directives, data attributes, etc.) pass
/// through.
final class PinesIconAttributesTests: XCTestCase {
    func testIconWithExtraClass() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesIcon-attributeClass.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesIcon(.check, size: .sm, attributes: [.class("ml-2")]),
            expected
        )
    }

    func testIconWithCustomAttribute() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesIcon-attributeCustom.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesIcon(
                .check,
                attributes: [HTMLAttribute(name: "x-show", value: "isVisible")]
            ),
            expected
        )
    }

    func testIconWithMultipleAttributes() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesIcon-attributeMulti.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesIcon(
                .check,
                size: .sm,
                attributes: [
                    .class("ml-2"),
                    HTMLAttribute(name: "x-show", value: "isVisible"),
                ]
            ),
            expected
        )
    }
}
