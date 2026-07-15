import Elementary
import ElementaryAlpine
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
/// pinesSelect(items: items, placeholder: "Choose a fruit", width: "w-72")
/// ```
///
/// - Parameters:
///   - items: The list of selectable items. Defaults to empty.
///   - placeholder: Placeholder text shown when nothing is selected.
///     Defaults to `"Select Item"`.
///   - width: Tailwind width class for the select. Defaults to `"w-64"`.
public func pinesSelect(
    items: [PinesSelectItem] = [],
    placeholder: String = "Select Item",
    width: String = "w-64"
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
        .class("relative \(width)"),
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
        .x.on("keydown", "selectKeydown($event);")
    ) {
        button(
            .x.ref("selectButton"),
            .x.on("click", "selectOpen=!selectOpen"),
            .x.bindClass("{ 'focus:ring-2 focus:ring-offset-2 focus:ring-neutral-400' : !selectOpen }"),
            .class(
                "relative min-h-[38px] flex items-center justify-between w-full py-2 pl-3 pr-10 text-left bg-white border rounded-md shadow-sm cursor-default border-neutral-200/70 focus:outline-none text-sm"
            )
        ) {
            span(.x.text("selectedItem ? selectedItem.title : '\(placeholder)'"), .class("truncate")) {
                placeholder
            }
            span(.class("absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none")) {
                pinesIcon(.chevronDown)
            }
        }
        ul(
            .x.show("selectOpen"),
            .x.ref("selectableItemsList"),
            .x.on("click", "selectOpen = false", modifiers: [.outside]),
            .x.transitionEnter("transition ease-out duration-50"),
            .x.transitionEnterStart("opacity-0 -translate-y-1"),
            .x.transitionEnterEnd("opacity-100"),
            .x.bindClass("{ 'bottom-0 mb-10' : selectDropdownPosition == 'top', 'top-0 mt-10' : selectDropdownPosition == 'bottom' }"),
            .x.cloak,
            .class(
                "absolute w-full py-1 mt-1 overflow-auto text-sm bg-white rounded-md shadow-md max-h-56 ring-1 ring-black ring-opacity-5 focus:outline-none"
            )
        ) {
            template(.x.loop("item in selectableItems"), .x.bind("key", "item.value")) {
                li(
                    .x.on("click", "selectedItem=item; selectOpen=false; $refs.selectButton.focus();"),
                    .x.bind("id", "item.value + '-' + selectId"),
                    .x.bind("data-disabled", "item.disabled"),
                    .x.bindClass("{ 'bg-neutral-100 text-gray-900' : selectableItemIsActive(item), '' : !selectableItemIsActive(item) }"),
                    .x.on("mousemove", "selectableItemActive=item"),
                    .class(
                        "relative flex items-center h-full py-2 pl-8 text-gray-700 cursor-default select-none data-[disabled]:opacity-50 data-[disabled]:pointer-events-none"
                    )
                ) {
                    pinesIcon(
                        .check,
                        size: .sm,
                        attributes: [
                            .x.show("selectedItem.value==item.value"),
                            .class("absolute left-0 ml-2 text-neutral-400"),
                        ]
                    )
                    span(.class("block font-medium truncate"), .x.text("item.title")) {
                        ""
                    }
                }
            }
        }
    }
}
