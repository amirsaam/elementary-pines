import Elementary
import ElementaryAlpine
import ElementaryTailwind
import Foundation

/// Renders a styled radio group matching the Pines UI radio group design.
///
/// The component renders a list of selectable cards backed by Alpine.js.
/// Each option is rendered from the JSON-encoded `radioGroupOptions` array
/// using an `x-for` template loop. Clicking a card sets
/// `radioGroupSelectedValue` to the option's `value`, and the underlying
/// `<input type="radio">` carries `x-bind:value="option.value"`.
///
/// **Generated HTML:**
/// ```html
/// <div class="space-y-3" x-data="{ radioGroupSelectedValue: null, radioGroupOptions: [...] }">
///     <template x-for="(option, index) in radioGroupOptions" x-bind:key="index">
///         <label x-on:click="if(!option.disabled){ radioGroupSelectedValue=option.value }"
///                x-bind:class="{ 'opacity-50 pointer-events-none' : option.disabled }"
///                class="flex items-start p-5 space-x-3 bg-white border rounded-md shadow-xs hover:bg-gray-50 border-neutral-200/70">
///             <input type="radio" name="..." x-bind:value="option.value"
///                    class="text-gray-900 translate-y-px focus:ring-gray-700"
///                    x-bind:disabled="option.disabled">
///             <span class="relative flex flex-col text-left space-y-1.5 leading-none">
///                 <span x-text="option.title" class="font-semibold"></span>
///                 <span x-text="option.description" class="text-sm opacity-50"></span>
///             </span>
///         </label>
///     </template>
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesRadioGroup(options: [
///     .init(title: "Small", value: "sm"),
///     .init(title: "Medium", value: "md"),
///     .init(title: "Large", value: "lg", description: "Not available in store"),
/// ], name: "size")
/// ```
///
/// - Parameters:
///   - options: The list of radio group options.
///   - name: The name shared by all radio inputs in the group.
///   - disabled: Whether every radio input is disabled. Defaults to `false`.
public func pinesRadioGroup(
    options: [PinesRadioGroupOption],
    name: String,
    disabled: Bool = false
) -> some HTML {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.sortedKeys]
    let optionsLiteral =
        String(
            data: (try? encoder.encode(options)) ?? Data(),
            encoding: .utf8
        ) ?? "[]"

    let xDataString = #"{"radioGroupSelectedValue":null,"radioGroupOptions":\#(optionsLiteral)}"#

    var inputAttrs: [HTMLAttribute<HTMLTag.input>] = [
        .textColor(PinesColor.gray.shade(.dark)),
        .translate(.y("px")),
        .ringColor(PinesColor.gray.shade(.bold), variants: [.focus]),
    ]
    if disabled {
        inputAttrs.append(contentsOf: [
            .opacity(.value(50), variants: [.disabled]),
            .cursor(.notAllowed, variants: [.disabled]),
        ])
    }

    let html = div(.spaceY(.size(3)), .x.data(xDataString)) {
        template(.x.loop("(option, index) in radioGroupOptions"), .x.bind("key", "index")) {
            let clickHandler: [HTMLAttribute<HTMLTag.label>] =
                disabled
                ? []
                : [.x.on("click", "if(!option.disabled){ radioGroupSelectedValue=option.value }")]
            let labelClasses: [HTMLAttribute<HTMLTag.label>] =
                disabled
                ? []
                : [
                    .x.bindClass(
                        pinesAlpineBindClass([
                            (twValue(.opacity(.value(50)), .pointerEvents(.none)), "option.disabled")
                        ])
                    )
                ]
            label(
                attributes: clickHandler + labelClasses + [
                    .display(.flex), .items(.start), .padding(.size(5)),
                    .spaceX(.size(3)),
                    .backgroundColor(.white),
                    .borderWidth(.bare), .borderRadius(.md), .boxShadow(.xs),
                    .backgroundColor(PinesColor.gray.shade(.tint1), variants: [.hover]),
                    .borderColor(PinesColor.neutral.shade(.subtle), opacity: 70),
                ]
            ) {
                let disabledAttribute: [HTMLAttribute<HTMLTag.input>] =
                    disabled
                    ? [HTMLAttribute(name: "disabled", value: nil)]
                    : [.x.bind("disabled", "option.disabled")]
                let inputAttributes: [HTMLAttribute<HTMLTag.input>] =
                    [
                        .type(.radio),
                        .name(name),
                        .x.bind("value", "option.value"),
                    ] + inputAttrs + disabledAttribute
                input(attributes: inputAttributes)
                span(
                    .position(.relative),
                    .display(.flex),
                    .flexDirection(.column),
                    .textAlign(.left),
                    .spaceY(.size(1.5)),
                    .lineHeight(.none)
                ) {
                    span(
                        .x.text("option.title"),
                        .fontWeight(.semibold)
                    ) { "" }
                    span(
                        .x.text("option.description"),
                        .fontSize(.sm),
                        .opacity(.value(50))
                    ) { "" }
                }
            }
        }
    }
    return HTMLRaw(html.render())
}
