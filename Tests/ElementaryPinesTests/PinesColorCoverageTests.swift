import Elementary
import ElementaryPines
import XCTest

final class PinesColorCoverageTests: XCTestCase {
    func testEveryNamedShadeBelongsToItsPinesColor() {
        for color in PinesColor.allCases {
            for shade in PinesColor.Shade.allCases {
                let value = color.shade(shade)
                XCTAssertEqual(value.palette, color.rawValue)
                XCTAssertEqual(value.shade, shade.rawValue)
            }
        }
    }

    func testEveryExplicitAccentReachesColorBearingComponents() {
        for color in PinesColor.allCases where color != .neutral {
            let renderedComponents: [String: String] = [
                "button": button { "Save" }.pinesButtonStyle(.solid, color: color).render(),
                "badge": span { "New" }.pinesBadgeStyle(.light, color: color).render(),
                "progress": pinesProgress(50, color: color).render(),
                "icon": pinesIcon(.check, color: color).render(),
                "input": pinesInput(color: color).render(),
                "textarea": pinesTextarea(color: color).render(),
                "checkbox": pinesCheckbox(labelText: "Accept", color: color, id: "accept").render(),
                "switch": pinesSwitch(labelText: "Wi-Fi", color: color, name: "wifi", id: "wifi").render(),
                "range slider": pinesRangeSlider(color: color, name: "volume", id: "volume").render(),
                "rating": pinesRating(color: color).render(),
                "dropdown": pinesDropdown(color: color, trigger: { span { "Menu" } }, items: { [] }).render(),
                "popover": pinesPopover(color: color, trigger: { span { "Open" } }, content: { span { "Content" } }).render(),
                "menu bar": pinesMenuBar(
                    color: color,
                    menus: [.init(title: "File", items: [.item(.init(title: "Open"))])]
                ).render(),
                "modal": pinesModal(color: color, trigger: { span { "Open" } }, content: { span { "Content" } }).render(),
                "slide-over": pinesSlideOver(color: color, trigger: { span { "Open" } }, content: { span { "Content" } }).render(),
                "command": pinesCommand(color: color, items: [.init(title: "Search", value: "search")]).render(),
            ]

            for (component, html) in renderedComponents {
                XCTAssertTrue(
                    html.contains(color.rawValue),
                    "Expected \(component) to contain the explicit \(color.rawValue) accent."
                )
            }
        }
    }
}
