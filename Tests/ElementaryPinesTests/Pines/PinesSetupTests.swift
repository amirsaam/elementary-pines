import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class PinesSetupTests: XCTestCase {
    func testSetupPinesDefault() throws {
        let expected = try String(
            contentsOf: fixtureURL("setup-pines-default.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(setupPines(), expected)
    }

    func testSetupPinesCustomTheme() throws {
        let expected = try String(
            contentsOf: fixtureURL("setup-pines-custom.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            setupPines(accent: .green, bgLight: .neutral.shade(100), bgDark: .neutral.shade(950)),
            expected
        )
    }
}
