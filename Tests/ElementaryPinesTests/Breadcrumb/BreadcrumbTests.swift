import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class BreadcrumbTests: XCTestCase {
    /// Shared site map used by the helper tests below.
    private let siteMap: [PinesSiteMapEntry] = [
        .init(path: "/", label: "Home"),
        .init(path: "/docs", label: "Docs"),
        .init(path: "/docs/getting-started", label: "Getting Started"),
        .init(path: "/docs/getting-started/installation", label: "Installation"),
    ]

    func testBasicBreadcrumbs() throws {
        // Mirrors the official Pines example: home icon crumb, two link
        // crumbs with SVG chevron separators, and an active current crumb.
        let expected = try String(
            contentsOf: fixtureURL("breadcrumb-basic.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesBreadcrumb([
                .link("Cart", href: "/cart"),
                .link("Checkout", href: "/checkout"),
                .link("Payment", href: "/payment"),
                .current("Delivery Address"),
            ]),
            expected
        )
    }

    func testSingleItemBreadcrumb() throws {
        // Single current item: no home icon, no separators.
        let expected = try String(
            contentsOf: fixtureURL("breadcrumb-single.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesBreadcrumb([.current("Home")]),
            expected
        )
    }

    func testSlashSeparators() throws {
        let expected = try String(
            contentsOf: fixtureURL("breadcrumb-slash.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesBreadcrumb([
                .link("Cart", href: "/cart"),
                .link("Checkout", href: "/checkout"),
                .link("Payment", href: "/payment"),
                .current("Delivery Address"),
            ], separator: .slash),
            expected
        )
    }

    func testNoHomeIcon() throws {
        let expected = try String(
            contentsOf: fixtureURL("breadcrumb-no-home-icon.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesBreadcrumb([
                .link("Cart", href: "/cart"),
                .link("Checkout", href: "/checkout"),
                .link("Payment", href: "/payment"),
                .current("Delivery Address"),
            ], homeIcon: .none),
            expected
        )
    }

    func testArrowSeparators() throws {
        let expected = try String(
            contentsOf: fixtureURL("breadcrumb-arrow.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesBreadcrumb([
                .link("Cart", href: "/cart"),
                .link("Checkout", href: "/checkout"),
                .link("Payment", href: "/payment"),
                .current("Delivery Address"),
            ], separator: .arrow),
            expected
        )
    }

    // MARK: - `pinesBreadcrumbItems(for:in:root:)` helper

    func testBreadcrumbItemsFromSiteMap() {
        let items = pinesBreadcrumbItems(
            for: "/docs/getting-started",
            in: siteMap
        )
        XCTAssertEqual(items.count, 3)
        // Root
        guard case .link("Home", let rootHref) = items[0] else {
            return XCTFail("expected root .link, got \(items[0])")
        }
        XCTAssertEqual(rootHref, "/")
        // Middle
        guard case .link("Docs", let docsHref) = items[1] else {
            return XCTFail("expected Docs .link, got \(items[1])")
        }
        XCTAssertEqual(docsHref, "/docs")
        // Current
        guard case .current("Getting Started") = items[2] else {
            return XCTFail("expected .current(\"Getting Started\"), got \(items[2])")
        }
    }

    func testBreadcrumbItemsAtLeafInSiteMap() {
        // The current path exactly matches a site map entry.
        let items = pinesBreadcrumbItems(
            for: "/docs/getting-started/installation",
            in: siteMap
        )
        XCTAssertEqual(items.count, 4)
        XCTAssertEqual(items.map(text(of:)), ["Home", "Docs", "Getting Started", "Installation"])
        XCTAssertTrue(items.last?.isCurrent ?? false)
    }

    func testBreadcrumbItemsAtUnknownLeaf() {
        // The current path doesn't match any site map entry — the helper
        // derives a label from the last URL segment.
        let items = pinesBreadcrumbItems(
            for: "/docs/getting-started/dynamic-123",
            in: siteMap
        )
        XCTAssertEqual(items.count, 4)
        XCTAssertEqual(items.map(text(of:)), ["Home", "Docs", "Getting Started", "dynamic-123"])
    }

    func testBreadcrumbItemsAtRoot() {
        let items = pinesBreadcrumbItems(for: "/", in: siteMap)
        XCTAssertEqual(items.count, 1)
        guard case .current("Home") = items[0] else {
            return XCTFail("expected .current(\"Home\"), got \(items[0])")
        }
    }

    /// Extracts `.text` from an item regardless of `.link` vs `.current`.
    private func text(of item: PinesBreadcrumbItem) -> String {
        switch item {
        case .link(let t, _): return t
        case .current(let t): return t
        }
    }
}
