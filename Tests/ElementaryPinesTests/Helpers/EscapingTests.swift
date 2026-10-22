import XCTest
@testable import ElementaryPines

final class EscapingTests: XCTestCase {
    func testPlain() {
        XCTAssertEqual(pinesJavaScriptStringLiteral("hello"), "'hello'")
    }

    func testSingleQuote() {
        XCTAssertEqual(pinesJavaScriptStringLiteral("a'b"), "'a\\'b'")
    }

    func testBackslash() {
        XCTAssertEqual(pinesJavaScriptStringLiteral("a\\b"), "'a\\\\b'")
    }

    func testControlChars() {
        XCTAssertEqual(pinesJavaScriptStringLiteral("a\nb"), "'a\\nb'")
        XCTAssertEqual(pinesJavaScriptStringLiteral("a\rb"), "'a\\rb'")
        XCTAssertEqual(pinesJavaScriptStringLiteral("a\tb"), "'a\\tb'")
    }

    func testUnicodeSeparators() {
        XCTAssertEqual(pinesJavaScriptStringLiteral("a\u{2028}b"), "'a\\u2028b'")
        XCTAssertEqual(pinesJavaScriptStringLiteral("a\u{2029}b"), "'a\\u2029b'")
    }

    func testCombo() {
        XCTAssertEqual(pinesJavaScriptStringLiteral("it's\nok"), "'it\\'s\\nok'")
    }
}
