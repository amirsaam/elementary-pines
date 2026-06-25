import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class AlertTests: XCTestCase {
    func testBasicAlert() throws {
        let expected = try String(
            contentsOf: fixtureURL("alert-basic.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesAlert {
                pinesIcon(.info, size: .sm)
                h5 { "Alert Message Headline" }
                div(.class("text-sm opacity-70")) { "This is the subtext for your alert message." }
            },
            expected
        )
    }
}
