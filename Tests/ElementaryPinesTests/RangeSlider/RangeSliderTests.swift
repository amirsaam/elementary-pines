import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class RangeSliderTests: XCTestCase {
    func testRangeSliderDefault() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRangeSlider-default.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRangeSlider(name: "volume", id: "volume"),
            expected
        )
    }

    func testRangeSliderWithColor() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRangeSlider-color-green.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRangeSlider(color: .green, name: "price", id: "price"),
            expected
        )
    }

    func testRangeSliderWithMinMaxValue() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRangeSlider-minmax.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRangeSlider(name: "range", id: "range", min: 0, max: 500, value: 100),
            expected
        )
    }

    func testRangeSliderDisabled() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRangeSlider-disabled.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRangeSlider(name: "volume", id: "volume", disabled: true),
            expected
        )
    }

    func testRangeSliderAllParams() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRangeSlider-allParams.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRangeSlider(
                color: .purple,
                name: "rating",
                id: "rating",
                min: 10,
                max: 200,
                value: 50,
                step: "5",
                disabled: true
            ),
            expected
        )
    }

    func testRangeSliderWithAttributes() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRangeSlider-attributes.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRangeSlider(
                name: "volume",
                id: "volume",
                attributes: [.class("custom-range")]
            ),
            expected
        )
    }
}
