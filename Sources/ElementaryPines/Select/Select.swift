import Elementary
import ElementaryAlpine
import ElementaryTailwind
import Foundation

/// Renders a styled custom select element matching the Pines UI select design.
///
/// The component is a fully custom button + dropdown — it replaces the
/// native `<select>` element. It depends on Alpine.js for state and
/// behavior: the `x-data` attribute carries the full state shape (open,
/// selected, items, keydown, position), and five `@keydown.*` handlers
/// drive keyboard interaction. Pass items as `[PinesSelectItem]`, which
/// are JSON-encoded into the `selectableItems` array.
///
/// **Example:**
/// ```swift
/// pinesSelect(items: [
///     .init(title: "Milk", value: "milk"),
///     .init(title: "Eggs", value: "eggs"),
///     .init(title: "Cheese", value: "cheese", disabled: true),
/// ])
///
/// pinesSelect(items: items, placeholder: "Choose a fruit", width: .size(72))
/// ```
///
/// - Parameters:
///   - items: The list of selectable items. Defaults to empty.
///   - placeholder: Placeholder text shown when nothing is selected.
///     Defaults to `"Select Item"`.
///   - width: Tailwind width token for the select. Defaults to `.size(64)`.
public func pinesSelect(
    items: [PinesSelectItem] = [],
    placeholder: String = "Select Item",
    width: TWTWidth = .size(64)
) -> some HTML {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.sortedKeys]
    let itemsLiteral =
        String(
            data: (try? encoder.encode(items)) ?? Data(),
            encoding: .utf8
        ) ?? "[]"

    let xData = PinesSelectState.xData(itemsLiteral: itemsLiteral)

    let xInitScript = PinesSelectState.xInit

    return div(
        .position(.relative),
        .width(width),
        .x.data(xData),
        .x.setup(xInitScript),
        .x.on("keydown", "if(selectOpen){ selectOpen=false; }", modifiers: [.escape]),
        .x.on(
            "keydown",
            "if(selectOpen){ selectableItemActiveNext(); } else { selectOpen=true; } event.preventDefault();",
            modifiers: [.down]
        ),
        .x.on(
            "keydown",
            "if(selectOpen){ selectableItemActivePrevious(); } else { selectOpen=true; } event.preventDefault();",
            modifiers: [.up]
        ),
        .x.on("keydown", "selectedItem=selectableItemActive; selectOpen=false;", modifiers: [.enter]),
        .x.on("keydown", "selectKeydown($event);"),
        .x.on("resize", "selectPositionUpdate()", modifiers: [.window])
    ) {
        button(
            .x.ref("selectButton"),
            .type(.button),
            .x.on("click", "selectOpen=!selectOpen"),
            .x.bindClass(
                pinesAlpineBindClass([
                    (
                        twValue(
                            .ringWidth(.size(2), variants: [.focus]),
                            .ringOffsetWidth(.size(2), variants: [.focus]),
                            .ringColor(PinesColor.neutral.shade(.accent), variants: [.focus])
                        ),
                        "!selectOpen"
                    )
                ])
            ),
            .position(.relative),
            .minHeight(.arbitrary("38px")),
            .display(.flex),
            .items(.center),
            .justify(.between),
            .width(.full),
            .paddingY(.size(2)),
            .paddingLeft(.size(3)),
            .paddingRight(.size(10)),
            .textAlign(.left),
            .backgroundColor(.white),
            .borderWidth(.bare),
            .borderRadius(.md),
            .boxShadow(.xs),
            .cursor(.default),
            .borderColor(PinesColor.neutral.shade(.subtle), opacity: 70),
            .outlineStyle(.hidden, variants: [.focus]),
            .fontSize(.sm)
        ) {
            span(
                .x.text("selectedItem ? selectedItem.title : \(pinesJavaScriptStringLiteral(placeholder))"),
                .textOverflow(.truncate)
            ) {
                placeholder
            }
            span(
                .position(.absolute),
                .insetY(.zero),
                .insetRight(.zero),
                .display(.flex),
                .items(.center),
                .paddingRight(.size(2)),
                .pointerEvents(.none)
            ) {
                pinesIcon(.chevronDown)
            }
        }
        ul(
            .x.show("selectOpen"),
            .x.ref("selectableItemsList"),
            .x.on("click", "selectOpen = false", modifiers: [.outside]),
            .x.transitionEnter(twValue(.transition(.all), .transitionTimingFunction(.easeOut), .transitionDuration(.ms(50)))),
            .x.transitionEnterStart(twValue(.opacity(.value(0)), .translate(.y("1"), negative: true))),
            .x.transitionEnterEnd(twValue(.opacity(.value(100)))),
            .x.bindClass(
                pinesAlpineBindClass([
                    (
                        twValue(.insetBottom(.zero), .marginBottom(.size(10))),
                        "selectDropdownPosition == 'top'"
                    ),
                    (
                        twValue(.insetTop(.zero), .marginTop(.size(10))),
                        "selectDropdownPosition == 'bottom'"
                    ),
                ])
            ),
            .x.cloak,
            .position(.absolute),
            .width(.full),
            .paddingY(.size(1)),
            .marginTop(.size(1)),
            .overflow(.auto),
            .fontSize(.sm),
            .backgroundColor(.white),
            .borderRadius(.md),
            .boxShadow(.md),
            .maxHeight(.size(56)),
            .ringWidth(.size(1)),
            .ringColor(.black, opacity: 5),
            .outlineStyle(.hidden, variants: [.focus])
        ) {
            template(.x.loop("item in selectableItems"), .x.bind("key", "item.value")) {
                li(
                    .x.on("click", "selectedItem=item; selectOpen=false; $refs.selectButton.focus();"),
                    .x.bind("id", "item.value + '-' + selectId"),
                    .x.bind("data-disabled", "item.disabled"),
                    .x.bindClass(
                        pinesAlpineBindClass([
                            (
                                twValue(
                                    .backgroundColor(PinesColor.neutral.shade(.tint2)),
                                    .textColor(PinesColor.gray.shade(.dark))
                                ),
                                "selectableItemIsActive(item)"
                            ),
                            ("", "!selectableItemIsActive(item)"),
                        ])
                    ),
                    .x.on("mousemove", "selectableItemActive=item"),
                    .position(.relative),
                    .display(.flex),
                    .items(.center),
                    .height(.full),
                    .paddingY(.size(2)),
                    .paddingLeft(.size(8)),
                    .textColor(PinesColor.gray.shade(.bold)),
                    .cursor(.default),
                    .userSelect(.none),
                    .opacity(.value(50), variants: [.arbitrary("data-[disabled]")]),
                    .pointerEvents(.none, variants: [.arbitrary("data-[disabled]")])
                ) {
                    SVG.svg(
                        SVGAttribute(name: "x-show", value: "selectedItem.value==item.value"),
                        SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
                        SVGAttribute(name: "fill", value: "none"),
                        SVGAttribute(name: "viewBox", value: "0 0 20 20"),
                        SVGAttribute(name: "stroke", value: "currentColor"),
                        SVGAttribute(name: "stroke-width", value: "2"),
                        SVGAttribute(name: "class", value: "absolute left-0 ml-2 w-4 h-4 text-neutral-400")
                    ) {
                        SVG.polyline(
                            .points("20 6 9 17 4 12"),
                            .strokeLinecap(.round),
                            .strokeLinejoin(.round)
                        )
                    }
                    span(.display(.block), .fontWeight(.medium), .textOverflow(.truncate), .x.text("item.title")) {
                        ""
                    }
                }
            }
        }
    }
}
