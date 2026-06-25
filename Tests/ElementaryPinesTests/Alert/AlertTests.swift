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

    func testInfoAlert() throws {
        let expected = try String(
            contentsOf: fixtureURL("alert-info.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesAlert(.info) {
                h5 { "Title" }
                p { "Body" }
            },
            expected
        )
    }

    func testSuccessAlert() throws {
        let expected = try String(
            contentsOf: fixtureURL("alert-success.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesAlert(.success) {
                h5 { "Title" }
                p { "Body" }
            },
            expected
        )
    }

    func testWarningAlert() throws {
        let expected = try String(
            contentsOf: fixtureURL("alert-warning.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesAlert(.warning) {
                h5 { "Title" }
                p { "Body" }
            },
            expected
        )
    }

    func testDangerAlert() throws {
        let expected = try String(
            contentsOf: fixtureURL("alert-danger.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesAlert(.danger) {
                h5 { "Title" }
                p { "Body" }
            },
            expected
        )
    }

    func testAlertCustomIcon() throws {
        let expected = try String(
            contentsOf: fixtureURL("alert-custom-icon.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesAlert(.info, icon: .custom(.warning)) {
                h5 { "Title" }
                p { "Body" }
            },
            expected
        )
    }

    func testAlertNoIcon() throws {
        let expected = try String(
            contentsOf: fixtureURL("alert-no-icon.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesAlert(.info, icon: .none) {
                h5 { "Title" }
                p { "Body" }
            },
            expected
        )
    }
}
