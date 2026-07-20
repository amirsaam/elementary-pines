import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class QuoteTests: XCTestCase {
    func testQuoteWithAvatar() throws {
        let expected = try String(
            contentsOf: fixtureURL("quote-with-avatar.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesQuote(
                quote: "Elementary Pines makes server-rendered HTML a joy.",
                author: "Ada Lovelace",
                role: "First Programmer",
                avatar: "ada.jpg"
            ),
            expected
        )
    }

    func testQuoteWithoutAvatar() throws {
        let expected = try String(
            contentsOf: fixtureURL("quote-basic.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesQuote(
                quote: "Elementary Pines makes server-rendered HTML a joy.",
                author: "Ada Lovelace",
                role: "First Programmer"
            ),
            expected
        )
    }
}
