import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class DatePickerTests: XCTestCase {
    func testBasicDatePicker() throws {
        let expected = try String(
            contentsOf: fixtureURL("datepicker-basic.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesDatePicker(),
            expected
        )
    }

    func testDatePickerWithCustomLabel() throws {
        let expected = try String(
            contentsOf: fixtureURL("datepicker-custom-label.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesDatePicker(labelText: "Birthday"),
            expected
        )
    }

    func testDatePickerWithFormat() throws {
        let expected = try String(
            contentsOf: fixtureURL("datepicker-format.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesDatePicker(format: .mmDdYyyy),
            expected
        )
    }

    func testDatePickerDisabled() throws {
        let expected = try String(
            contentsOf: fixtureURL("datepicker-disabled.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesDatePicker(disabled: true),
            expected
        )
    }
}
