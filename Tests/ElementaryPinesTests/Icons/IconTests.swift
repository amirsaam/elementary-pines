import Elementary
import ElementaryPines
import TestUtilities
import XCTest

/// Snapshot tests for `pinesIcon(_:size:color:)`. Each test renders one
/// variation and compares against the expected HTML in `SnapshotFixtures/`.
final class IconTests: XCTestCase {
    func testDefaultIcon() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesIcon-default.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesIcon(.check),
            expected
        )
    }

    func testIconSizeLg() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesIcon-sizeLg.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesIcon(.check, size: .lg),
            expected
        )
    }

    func testIconColorGreen() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesIcon-colorGreen.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesIcon(.check, color: .green),
            expected
        )
    }

    func testIconSizeLgColorBlue() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesIcon-sizeLgColorBlue.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesIcon(.check, size: .lg, color: .blue),
            expected
        )
    }
}
