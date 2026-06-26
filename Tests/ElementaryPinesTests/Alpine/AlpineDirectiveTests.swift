import Elementary
import ElementaryPines
import TestUtilities
import XCTest

/// Verifies that Alpine directives (`x-text`, `x-model`, `x-on:`, `x-data`,
/// `x-show`, `$store`, `$el`, etc.) survive Elementary's renderer when
/// applied to elements inside Pines components. These are snapshot tests
/// against the rendered HTML.
///
/// Three patterns are supported:
/// 1. **Modifier-style elements** (`.pinesButtonStyle`, `.pinesBadgeStyle`) —
///    chain attributes on the element before the modifier is applied.
/// 2. **Child elements** inside any content builder — pass `HTMLAttribute`s
///    to the variadic init of the element.
/// 3. **Wrapping divs** around free functions (`pinesCard`, `pinesAlert`,
///    `pinesProgress`) — these return opaque `some HTML`, so the only way
///    to attach directives to the outer element is to wrap it.
///
/// Note: a custom `x.text(_:)`, `x.model(_:)` etc. shortcut namespace on
/// `HTMLAttribute` would shorten the call site. Not currently provided.
final class AlpineDirectiveTests: XCTestCase {
    func testXTextInAlert() throws {
        // x-text on a child of pinesAlert — Alpine replaces the text
        // content with the value of the `title` JavaScript expression at
        // runtime. The x-text attribute must survive the render. The
        // variant overload auto-inserts the icon, so the content omits
        // an explicit pinesIcon (which would duplicate).
        let expected = try String(
            contentsOf: fixtureURL("alpine-x-text.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesAlert(.info) {
                h5(HTMLAttribute(name: "x-text", value: "title")) { "Title" }
                p(HTMLAttribute(name: "x-text", value: "body")) { "Body" }
            },
            expected
        )
    }

    func testXModelOnInput() throws {
        // x-model two-way binding on an <input>. Verifies a void element
        // (input) accepts a variadic list of attributes.
        let expected = try String(
            contentsOf: fixtureURL("alpine-x-model.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            div {
                input(
                    .type(.text),
                    HTMLAttribute(name: "x-model", value: "search"),
                    .class("border rounded px-2 py-1")
                )
            },
            expected
        )
    }

    func testXOnClickOnButton() throws {
        // x-on:click is the standard Alpine event binding. Verifies that a
        // user-supplied attribute on the <button> is preserved by
        // .pinesButtonStyle (the modifier only manipulates the class attr).
        let expected = try String(
            contentsOf: fixtureURL("alpine-x-on-click.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            button(
                .type(.button),
                HTMLAttribute(name: "x-on:click", value: "count++")
            ) { "Increment" }
            .pinesButtonStyle(.solid, color: .blue),
            expected
        )
    }

    func testXDataWithProgress() throws {
        // Dynamic value pattern: wrap pinesProgress in a parent that owns
        // the reactive Alpine state. The x-data scope isn't actually
        // reactive on its own — but the directive survives rendering, so a
        // user can build a `x-effect` or `x-text` on the bar's width
        // elsewhere to bind to `progress`.
        let expected = try String(
            contentsOf: fixtureURL("alpine-x-data.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            div(HTMLAttribute(name: "x-data", value: "{ progress: 0 }")) {
                pinesProgress(0)
            },
            expected
        )
    }

    func testXTextInCard() throws {
        // x-text on a child of pinesCard — verifies the pattern works inside
        // a card's body div (different HTML structure than alert: no
        // [&>svg] selectors, body wrapped in p-7).
        let expected = try String(
            contentsOf: fixtureURL("alpine-x-text-in-card.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCard {
                h3(HTMLAttribute(name: "x-text", value: "title")) { "Title" }
                p(HTMLAttribute(name: "x-text", value: "body")) { "Body" }
            },
            expected
        )
    }

    func testXOnClickOnBadge() throws {
        // x-on:click on a <span> before .pinesBadgeStyle is applied —
        // verifies the modifier-preserves-attrs pattern works on a different
        // element type (span, not button).
        let expected = try String(
            contentsOf: fixtureURL("alpine-x-on-click-on-badge.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            span(
                HTMLAttribute(name: "x-on:click", value: "open = !open")
            ) { "Toggle" }
            .pinesBadgeStyle(.solid, color: .red),
            expected
        )
    }
}
