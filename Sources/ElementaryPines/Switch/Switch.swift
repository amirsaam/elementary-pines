import Elementary
import ElementaryAlpine

/// Renders a styled toggle switch matching the Pines UI switch design.
///
/// The component is a custom toggle switch backed by Alpine.js. It renders a
/// hidden checkbox input, a button track with a sliding knob, and a label.
///
/// **Generated HTML:**
/// ```html
/// <div class="flex items-center justify-center space-x-2" x-data="{ switchOn: false }">
///     <input id="..." type="checkbox" name="..." class="hidden" x-bind:checked="switchOn">
///     <button type="button" x-ref="switchButton" @click="switchOn = !switchOn"
///             x-bind:class="{ 'bg-blue-600' : switchOn, 'bg-neutral-200' : !switchOn }"
///             class="relative inline-flex h-6 py-0.5 ml-4 focus:outline-none rounded-full w-10" x-cloak>
///         <span class="w-5 h-5 duration-200 ease-in-out bg-white rounded-full shadow-md"
///               x-bind:class="{ 'translate-x-[18px]' : switchOn, 'translate-x-0.5' : !switchOn }"></span>
///     </button>
///     <label @click="$refs.switchButton.click(); $refs.switchButton.focus()"
///            x-bind:id="$id('switch')"
///            x-bind:class="{ 'text-blue-600' : switchOn, 'text-gray-400' : !switchOn }"
///            class="text-sm select-none" x-cloak>Label</label>
/// </div>
/// ```
///
/// **Examples:**
/// ```swift
/// pinesSwitch(labelText: "Airplane Mode", name: "airplane", id: "airplane")
///
/// pinesSwitch(labelText: "Wi-Fi", name: "wifi", id: "wifi", color: .green, checked: true)
///
/// pinesSwitch(labelText: "Bluetooth", name: "bluetooth", id: "bluetooth", size: .small)
/// ```
///
/// - Parameters:
///   - labelText: The text displayed next to the switch.
///   - color: The accent color of the switch when on. Defaults to blue.
///   - size: The size of the switch. Defaults to `.default`.
///   - name: The name of the checkbox input.
///   - id: The id of the checkbox input.
///   - checked: Whether the switch is initially on. Defaults to `false`.
///   - disabled: Whether the switch is disabled. Defaults to `false`.
///   - attributes: Extra HTML attributes merged into the hidden checkbox input.
public func pinesSwitch(
    labelText: String,
    color: PinesColor? = nil,
    size: PinesSwitchSize = .default,
    name: String,
    id: String,
    checked: Bool = false,
    disabled: Bool = false,
    attributes: [HTMLAttribute<HTMLTag.input>] = []
) -> some HTML {
    let accentColor = color?.rawValue ?? "blue"
    let xData = "{ switchOn: \(checked) }"

    let (
        trackClasses,
        knobClasses,
        knobTranslateOn,
        labelTextClasses,
        labelSizeClasses
    ) =
        switch size {
        case .default:
            (
                "relative inline-flex h-6 py-0.5 ml-4 focus:outline-none rounded-full w-10",
                "w-5 h-5 duration-200 ease-in-out bg-white rounded-full shadow-md",
                "translate-x-[18px]",
                "text-\(accentColor)-600",
                "text-sm select-none"
            )
        case .small:
            (
                "relative inline-flex h-4 py-0.5 ml-4 rounded-full focus:outline-none w-6",
                "w-3 h-3 duration-200 ease-in-out bg-white rounded-full shadow-md",
                "translate-x-[10px]",
                "text-\(accentColor)-900",
                "text-xs font-medium select-none"
            )
        }

    let buttonBgOn = "bg-\(accentColor)-600"
    let buttonBgOff = "bg-neutral-200"
    let buttonBgClass = HTMLAttributeValue.Alpine.BindClass(
        rawValue: "{ '\(buttonBgOn)' : switchOn, '\(buttonBgOff)' : !switchOn }"
    )

    let labelColorClass = HTMLAttributeValue.Alpine.BindClass(
        rawValue: "{ '\(labelTextClasses)' : switchOn, 'text-gray-400' : !switchOn }"
    )

    let knobPositionClass = HTMLAttributeValue.Alpine.BindClass(
        rawValue: "{ '\(knobTranslateOn)' : switchOn, 'translate-x-0.5' : !switchOn }"
    )

    let inputCheckedAttr: [HTMLAttribute<HTMLTag.input>] = checked ? [.checked] : []
    let inputDisabledAttr: [HTMLAttribute<HTMLTag.input>] = disabled ? [HTMLAttribute(name: "disabled", value: nil)] : []

    let html = div(.class("flex items-center justify-center space-x-2"), .x.data(xData)) {
        input(
            attributes: [
                .id(id),
                HTMLAttribute(name: "type", value: "checkbox"),
                .name(name),
                .class("hidden"),
                .x.bind("checked", "switchOn"),
            ] + inputCheckedAttr + inputDisabledAttr + attributes
        )

        button(
            .x.ref("switchButton"),
            HTMLAttribute(name: "type", value: "button"),
            .x.on("click", "switchOn = !switchOn"),
            .x.bindClass(buttonBgClass),
            .class(trackClasses),
            .x.cloak
        ) {
            span(.class(knobClasses), .x.bindClass(knobPositionClass)) {
                ""
            }
        }

        label(
            .x.on("click", "$refs.switchButton.click(); $refs.switchButton.focus()"),
            .x.bind("id", "$id('switch')"),
            .x.bindClass(labelColorClass),
            .class(labelSizeClasses),
            .x.cloak
        ) {
            labelText
        }
    }
    return HTMLRaw(html.render())
}
