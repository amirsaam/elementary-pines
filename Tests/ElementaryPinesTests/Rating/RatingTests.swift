import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class RatingTests: XCTestCase {
    func testRatingDefault() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRating-default.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRating(),
            expected
        )
    }

    func testRatingWithValue() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRating-value.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRating(value: 3),
            expected
        )
    }

    func testRatingCustomStars() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRating-customStars.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRating(maxStars: 10),
            expected
        )
    }

    func testRatingCustomColor() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRating-color.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRating(color: .pink),
            expected
        )
    }

    func testRatingDisabled() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRating-disabled.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRating(disabled: true),
            expected
        )
    }

    func testRatingCompactReset() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRating-compactReset.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRating(compactReset: true),
            expected
        )
    }

    func testRatingFilledEmpty() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRating-filledEmpty.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRating(emptyStyle: .filled),
            expected
        )
    }

    func testRatingHeartPinkCompactReset() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRating-heartPinkCompactReset.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRating(icon: .heart, color: .pink, compactReset: true),
            expected
        )
    }
}
