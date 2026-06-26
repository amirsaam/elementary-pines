import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class QuoteTests: XCTestCase {
    func testBasicQuote() throws {
        let expected = try String(
            contentsOf: fixtureURL("quote-basic.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesQuote {
                blockquote {
                    p(.class("text-lg italic")) { "“This is a great quote.”" }
                }
                figcaption(.class("mt-4 text-sm text-neutral-500")) { "— Author Name" }
            },
            expected
        )
    }

    func testQuoteWithAvatar() throws {
        let expected = try String(
            contentsOf: fixtureURL("quote-with-avatar.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesQuote(.withAvatar, avatar: "avatar.jpg") {
                blockquote {
                    p(.class("text-lg italic")) { "“This is a great quote.”" }
                }
                figcaption(.class("mt-2 text-sm text-neutral-500")) {
                    span(.class("font-semibold text-neutral-900")) { "Author Name" }
                    ", Role"
                }
            },
            expected
        )
    }
}
