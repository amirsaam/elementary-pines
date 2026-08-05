import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class ToastTests: XCTestCase {
    func testToastDefaultRender() throws {
        let expected = try String(
            contentsOf: fixtureURL("toast-default.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesToast(),
            expected
        )
    }
}
