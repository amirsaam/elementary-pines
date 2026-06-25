import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class ProgressTests: XCTestCase {
    func testDefaultProgress() throws {
        let expected = try String(
            contentsOf: fixtureURL("progress-default.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesProgress(45),
            expected
        )
    }

    func testProgressColorGreen() throws {
        let expected = try String(
            contentsOf: fixtureURL("progress-color-green.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesProgress(75, color: .green),
            expected
        )
    }

    func testProgressSizeLg() throws {
        let expected = try String(
            contentsOf: fixtureURL("progress-size-lg.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesProgress(30, color: .red, size: .lg),
            expected
        )
    }

    func testProgressCustomValue() throws {
        let expected = try String(
            contentsOf: fixtureURL("progress-custom-value.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesProgress(9, of: 20),
            expected
        )
    }
}
