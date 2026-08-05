import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class CheckboxTests: XCTestCase {

    private let customLabelClasses =
        "peer-checked:[&_svg]:scale-100 [&_svg]:scale-0 "
        + "peer-checked:[&_.custom-checkbox]:border-blue-500 "
        + "peer-checked:[&_.custom-checkbox]:bg-blue-500 "
        + "text-sm font-medium text-neutral-600 "
        + "flex items-center space-x-2"

    func testDefault() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesCheckbox-default.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCheckbox(labelText: "Remember me", name: "remember", id: "remember"),
            expected
        )
    }

    func testDefaultCheckedColor() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesCheckbox-defaultCheckedColor.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCheckbox(labelText: "Active", color: .blue, checked: true, name: "active", id: "active"),
            expected
        )
    }

    func testDefaultDisabled() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesCheckbox-defaultDisabled.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCheckbox(labelText: "Archived", disabled: true, name: "archived", id: "archived"),
            expected
        )
    }

    func testDefaultRequired() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesCheckbox-defaultRequired.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCheckbox(labelText: "Required", required: true, name: "required", id: "required"),
            expected
        )
    }

    func testDefaultWithAttributes() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesCheckbox-defaultWithAttributes.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCheckbox(labelText: "Test", name: "test", id: "test") {
                [.x.model("checked")]
            },
            expected
        )
    }

    func testCard() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesCheckbox-card.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCheckbox(name: "lib", id: "lib") {
                div(.display(.flex), .items(.center), .spaceX(.size(5))) {
                    div(.display(.flex), .flexDirection(.column), .justify(.start)) {
                        div(.width(.full), .fontSize(.lg), .fontWeight(.semibold)) { "AlpineJS" }
                        div(.width(.full), .fontSize(.sm), .opacity(.value(60))) { "Lightweight JS framework" }
                    }
                }
            },
            expected
        )
    }

    func testCardCheckedColor() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesCheckbox-cardCheckedColor.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCheckbox(color: .green, checked: true, name: "card-checked", id: "card-checked") {
                div(.display(.flex), .items(.center), .spaceX(.size(5))) {
                    div(.display(.flex), .flexDirection(.column), .justify(.start)) {
                        div(.width(.full), .fontSize(.lg), .fontWeight(.semibold)) { "AlpineJS" }
                        div(.width(.full), .fontSize(.sm), .opacity(.value(60))) { "Lightweight JS framework" }
                    }
                }
            },
            expected
        )
    }

    func testCardDisabled() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesCheckbox-cardDisabled.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCheckbox(disabled: true, name: "card-disabled", id: "card-disabled") {
                div(.display(.flex), .items(.center), .spaceX(.size(5))) {
                    div(.display(.flex), .flexDirection(.column), .justify(.start)) {
                        div(.width(.full), .fontSize(.lg), .fontWeight(.semibold)) { "AlpineJS" }
                        div(.width(.full), .fontSize(.sm), .opacity(.value(60))) { "Lightweight JS framework" }
                    }
                }
            },
            expected
        )
    }

    func testCardWithAttributes() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesCheckbox-cardWithAttributes.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCheckbox(name: "card-attr", id: "card-attr") {
                [.x.model("selected")]
            } content: {
                div(.display(.flex), .items(.center), .spaceX(.size(5))) {
                    div(.display(.flex), .flexDirection(.column), .justify(.start)) {
                        div(.width(.full), .fontSize(.lg), .fontWeight(.semibold)) { "AlpineJS" }
                        div(.width(.full), .fontSize(.sm), .opacity(.value(60))) { "Lightweight JS framework" }
                    }
                }
            },
            expected
        )
    }

    func testCustom() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesCheckbox-custom.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCheckbox(name: "x", id: "x", labelClasses: customLabelClasses) {
                span(
                    .display(.flex),
                    .items(.center),
                    .justify(.center),
                    .width(.size(5)),
                    .height(.size(5)),
                    .borderWidth(.size(2)),
                    .borderRadius(.sm),
                    .class("custom-checkbox"),
                    .textColor(PinesColor.neutral.shade(.dark))
                ) {
                    SVG.svg(
                        attributes: [
                            SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
                            SVGAttribute(name: "fill", value: "none"),
                            SVGAttribute(name: "viewBox", value: "0 0 24 24"),
                            SVGAttribute(name: "stroke-width", value: "3"),
                            SVGAttribute(name: "stroke", value: "currentColor"),
                            SVGAttribute(name: "class", value: "w-3 h-3 text-white duration-300 ease-out"),
                        ]
                    ) {
                        SVG.path(
                            .d("M4.5 12.75l6 6 9-13.5"),
                            .strokeLinecap(.round),
                            .strokeLinejoin(.round)
                        )
                    }
                }
                span { "Custom Checkbox" }
            },
            expected
        )
    }

    func testCustomCheckedColor() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesCheckbox-customCheckedColor.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCheckbox(color: .red, checked: true, name: "custom-checked", id: "custom-checked", labelClasses: customLabelClasses) {
                span(
                    .display(.flex),
                    .items(.center),
                    .justify(.center),
                    .width(.size(5)),
                    .height(.size(5)),
                    .borderWidth(.size(2)),
                    .borderRadius(.sm),
                    .class("custom-checkbox"),
                    .textColor(PinesColor.neutral.shade(.dark))
                ) {
                    SVG.svg(
                        attributes: [
                            SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
                            SVGAttribute(name: "fill", value: "none"),
                            SVGAttribute(name: "viewBox", value: "0 0 24 24"),
                            SVGAttribute(name: "stroke-width", value: "3"),
                            SVGAttribute(name: "stroke", value: "currentColor"),
                            SVGAttribute(name: "class", value: "w-3 h-3 text-white duration-300 ease-out"),
                        ]
                    ) {
                        SVG.path(
                            .d("M4.5 12.75l6 6 9-13.5"),
                            .strokeLinecap(.round),
                            .strokeLinejoin(.round)
                        )
                    }
                }
                span { "Custom Checkbox" }
            },
            expected
        )
    }

    func testCustomDisabled() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesCheckbox-customDisabled.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCheckbox(disabled: true, name: "custom-disabled", id: "custom-disabled", labelClasses: customLabelClasses) {
                span(
                    .display(.flex),
                    .items(.center),
                    .justify(.center),
                    .width(.size(5)),
                    .height(.size(5)),
                    .borderWidth(.size(2)),
                    .borderRadius(.sm),
                    .class("custom-checkbox"),
                    .textColor(PinesColor.neutral.shade(.dark))
                ) {
                    SVG.svg(
                        attributes: [
                            SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
                            SVGAttribute(name: "fill", value: "none"),
                            SVGAttribute(name: "viewBox", value: "0 0 24 24"),
                            SVGAttribute(name: "stroke-width", value: "3"),
                            SVGAttribute(name: "stroke", value: "currentColor"),
                            SVGAttribute(name: "class", value: "w-3 h-3 text-white duration-300 ease-out"),
                        ]
                    ) {
                        SVG.path(
                            .d("M4.5 12.75l6 6 9-13.5"),
                            .strokeLinecap(.round),
                            .strokeLinejoin(.round)
                        )
                    }
                }
                span { "Custom Checkbox" }
            },
            expected
        )
    }

    func testCustomWithAttributes() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesCheckbox-customWithAttributes.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesCheckbox(name: "custom-attr", id: "custom-attr", labelClasses: customLabelClasses) {
                [.x.model("custom")]
            } content: {
                span(
                    .display(.flex),
                    .items(.center),
                    .justify(.center),
                    .width(.size(5)),
                    .height(.size(5)),
                    .borderWidth(.size(2)),
                    .borderRadius(.sm),
                    .class("custom-checkbox"),
                    .textColor(PinesColor.neutral.shade(.dark))
                ) {
                    SVG.svg(
                        attributes: [
                            SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
                            SVGAttribute(name: "fill", value: "none"),
                            SVGAttribute(name: "viewBox", value: "0 0 24 24"),
                            SVGAttribute(name: "stroke-width", value: "3"),
                            SVGAttribute(name: "stroke", value: "currentColor"),
                            SVGAttribute(name: "class", value: "w-3 h-3 text-white duration-300 ease-out"),
                        ]
                    ) {
                        SVG.path(
                            .d("M4.5 12.75l6 6 9-13.5"),
                            .strokeLinecap(.round),
                            .strokeLinejoin(.round)
                        )
                    }
                }
                span { "Custom Checkbox" }
            },
            expected
        )
    }
}
