import Elementary
import ElementaryAlpine
import ElementaryTailwind

/// Renders a styled toggle switch matching the Pines UI switch design.
///
/// The component is a custom toggle switch backed by Alpine.js. It renders a
/// hidden checkbox input, a button track with a sliding knob, and a label.
///
/// **Generated HTML:**
/// ```html
/// <div class="flex items-center justify-center space-x-2" x-data="{ switchOn: false }">
///     <input id="..." type="checkbox" name="..." class="hidden" x-bind:checked="switchOn">
///     <button x-ref="switchButton" type="button" x-on:click="switchOn = !switchOn"
///             x-bind:class="{ 'bg-blue-600' : switchOn, 'bg-neutral-200' : !switchOn }"
///             class="relative inline-flex h-6 py-0.5 ml-4 focus:outline-hidden rounded-full w-10" x-cloak>
///         <span class="w-5 h-5 duration-200 ease-in-out bg-white rounded-full shadow-md"
///               x-bind:class="{ 'translate-x-[18px]' : switchOn, 'translate-x-0.5' : !switchOn }"></span>
///     </button>
///     <label x-on:click="$refs.switchButton.click(); $refs.switchButton.focus()"
///            x-bind:id="$id('switch')"
///            x-bind:class="{ 'text-blue-600' : switchOn, 'text-gray-400' : !switchOn }"
///            class="select-none text-sm" x-cloak>Label</label>
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
    let xData = "{ switchOn: \(checked) }"

    let knobTranslateOn: String
    let labelTextClasses: String
    let resolvedColor = color ?? .blue
    switch size {
    case .default:
        knobTranslateOn = twValue(.translate(.x("[18px]")))
        labelTextClasses = twValue(.textColor(resolvedColor.shade(.strong)))
    case .small:
        knobTranslateOn = twValue(.translate(.x("[10px]")))
        labelTextClasses = twValue(.textColor(resolvedColor.shade(.dark)))
    }

    let isSmall = size == .small

    let buttonBgClass = pinesAlpineBindClass([
        (twValue(.backgroundColor(resolvedColor.shade(.strong))), "switchOn"),
        (twValue(.backgroundColor(PinesColor.neutral.shade(.subtle))), "!switchOn"),
    ])

    let labelColorClass = pinesAlpineBindClass([
        (labelTextClasses, "switchOn"),
        (twValue(.textColor(PinesColor.gray.shade(.accent))), "!switchOn"),
    ])

    let knobPositionClass = pinesAlpineBindClass([
        (knobTranslateOn, "switchOn"),
        (twValue(.translate(.x("0.5"))), "!switchOn"),
    ])

    let inputCheckedAttr: [HTMLAttribute<HTMLTag.input>] = checked ? [.checked] : []
    let inputDisabledAttr: [HTMLAttribute<HTMLTag.input>] = disabled ? [HTMLAttribute(name: "disabled", value: nil)] : []

    var labelAttrs: [HTMLAttribute<HTMLTag.label>] = [
        .x.on("click", "$refs.switchButton.click(); $refs.switchButton.focus()"),
        .x.bind("id", "$id('switch')"),
        .x.bindClass(labelColorClass),
        .userSelect(.none),
        .x.cloak,
    ]
    if isSmall {
        labelAttrs.append(.fontSize(.xs))
        labelAttrs.append(.fontWeight(.medium))
    } else {
        labelAttrs.append(.fontSize(.sm))
    }

    var buttonAttributes: [HTMLAttribute<HTMLTag.button>] = [
        .x.ref("switchButton"),
        HTMLAttribute(name: "type", value: "button"),
        .x.on("click", "switchOn = !switchOn"),
        .x.bindClass(buttonBgClass),
        .position(.relative),
        .display(.inlineFlex),
        .height(isSmall ? .size(4) : .size(6)),
        .paddingY(.size(0.5)),
        .marginLeft(.size(4)),
        .outlineStyle(.hidden, variants: [.focus]),
        .borderRadius(.full),
        .width(isSmall ? .size(6) : .size(10)),
        .x.cloak,
    ]
    if disabled { buttonAttributes.append(.disabled) }

    let html = div(.display(.flex), .items(.center), .justify(.center), .spaceX(.size(2)), .x.data(xData)) {
        input(
            attributes: [
                .id(id),
                HTMLAttribute(name: "type", value: "checkbox"),
                .name(name),
                .display(.hidden),
                .x.bind("checked", "switchOn"),
            ] + inputCheckedAttr + inputDisabledAttr + attributes
        )

        button(attributes: buttonAttributes) {
            span(
                .width(isSmall ? .size(3) : .size(5)),
                .height(isSmall ? .size(3) : .size(5)),
                .transitionDuration(.ms(200)),
                .transitionTimingFunction(.easeInOut),
                .backgroundColor(.white),
                .borderRadius(.full),
                .boxShadow(.md),
                .x.bindClass(knobPositionClass)
            ) {
                ""
            }
        }

        label(attributes: labelAttrs) {
            labelText
        }
    }
    return HTMLRaw(html.render())
}
