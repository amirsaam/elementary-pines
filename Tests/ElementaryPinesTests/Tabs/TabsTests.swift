import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class TabsTests: XCTestCase {
    func testTabsTwoTabs() throws {
        let expected = try String(
            contentsOf: fixtureURL("tabs-two.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesTabs(tabs: [
                PinesTab(title: "Overview") { p { "Overview content" } },
                PinesTab(title: "Details") { p { "Details content" } },
            ]),
            expected
        )
    }

    func testTabsThreeTabs() throws {
        let expected = try String(
            contentsOf: fixtureURL("tabs-three.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesTabs(tabs: [
                PinesTab(title: "General") { p { "General settings" } },
                PinesTab(title: "Advanced") { p { "Advanced settings" } },
                PinesTab(title: "About") { p { "About this app" } },
            ]),
            expected
        )
    }
}
