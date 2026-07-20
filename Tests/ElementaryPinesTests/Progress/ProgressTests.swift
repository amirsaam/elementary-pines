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
            pinesProgress(),
            expected
        )
    }

    func testProgressAnimatedGreen() throws {
        let expected = try String(
            contentsOf: fixtureURL("progress-animated-green.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesProgress(color: .green),
            expected
        )
    }

    func testProgressStaticValue() throws {
        let expected = try String(
            contentsOf: fixtureURL("progress-static-value.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesProgress(45),
            expected
        )
    }

    func testProgressCustomValue() throws {
        let expected = try String(
            contentsOf: fixtureURL("progress-custom-value.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesProgress(1, of: 4),
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

    func testProgressClampedTo100() throws {
        let expected = try String(
            contentsOf: fixtureURL("progress-clamped.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesProgress(150),
            expected
        )
    }

    func testProgressSizeSmall() throws {
        let expected = try String(
            contentsOf: fixtureURL("progress-size-sm.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesProgress(30, size: .sm),
            expected
        )
    }

    func testProgressSizeLarge() throws {
        let expected = try String(
            contentsOf: fixtureURL("progress-size-lg.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesProgress(60, size: .lg),
            expected
        )
    }
}
