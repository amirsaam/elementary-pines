import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class pinesIconTests: XCTestCase {
    func testDefault() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesIcon-default.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(pinesIcon(.check), expected)
    }

    func testSizeLg() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesIcon-sizeLg.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(pinesIcon(.check, size: .lg), expected)
    }

    func testColorGreen() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesIcon-colorGreen.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(pinesIcon(.check, color: .green), expected)
    }

    func testSizeLgColorBlue() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesIcon-sizeLgColorBlue.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(pinesIcon(.check, size: .lg, color: .blue), expected)
    }

    func testAllIconsRender() {
        for icon in PinesIconKind.allCases {
            let html = pinesIcon(icon).render()
            XCTAssertTrue(html.contains("<svg"))
            XCTAssertTrue(html.contains("<path"))
            XCTAssertTrue(html.contains("d=\""), "missing path d attribute for \(icon)")
        }
    }
}
