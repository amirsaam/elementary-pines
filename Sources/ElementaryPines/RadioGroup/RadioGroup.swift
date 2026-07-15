import Elementary
import ElementaryAlpine
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
///     <template x-for="(option, index) in radioGroupOptions" :key="index">
///         <label @click="radioGroupSelectedValue=option.value" class="flex items-start p-5 space-x-3 ...">
///             <input type="radio" name="..." :value="option.value" class="text-gray-900 ...">
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

    var inputClasses = "text-gray-900 translate-y-px focus:ring-gray-700"
    if disabled {
        inputClasses += " disabled:opacity-50 disabled:cursor-not-allowed"
    }

    let html = div(.class("space-y-3"), .x.data(xDataString)) {
        template(.x.loop("(option, index) in radioGroupOptions"), .x.bind("key", "index")) {
            let clickHandler: [HTMLAttribute<HTMLTag.label>] =
                disabled
                ? []
                : [.x.on("click", "if(!option.disabled){ radioGroupSelectedValue=option.value }")]
            let labelClasses: [HTMLAttribute<HTMLTag.label>] =
                disabled
                ? []
                : [.x.bindClass("{ 'opacity-50 pointer-events-none': option.disabled }")]
            label(
                attributes: clickHandler + labelClasses + [
                    .class(
                        "flex items-start p-5 space-x-3 bg-white border rounded-md shadow-sm hover:bg-gray-50 border-neutral-200/70"
                    )
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
                        .class(inputClasses),
                    ] + disabledAttribute
                input(attributes: inputAttributes)
                span(.class("relative flex flex-col text-left space-y-1.5 leading-none")) {
                    span(.x.text("option.title"), .class("font-semibold")) { "" }
                    span(.x.text("option.description"), .class("text-sm opacity-50")) { "" }
                }
            }
        }
    }
    return HTMLRaw(html.render())
}
