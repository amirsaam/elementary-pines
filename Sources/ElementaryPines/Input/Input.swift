import Elementary
import ElementaryTailwind

/// Renders a styled text input element matching the Pines UI input design.
///
/// The class string matches the original `pines/elements/text-input.html`
/// layout. The `color` parameter changes only the focus ring; the field
/// border and placeholder remain neutral. The element itself holds no Alpine.js
/// state — pass `x-data`/`x-model` on the call site (e.g. via
/// `elementary-alpine`) for dynamic behavior.
///
/// Layout:
/// ```html
/// <input type="text" placeholder="Name"
///        class="flex w-full h-10 px-3 py-2 text-sm bg-background border rounded-md
///               border-border ring-offset-background
///               placeholder:text-muted-foreground
///               focus:border-border focus:outline-hidden focus:ring-2
///               focus:ring-offset-2 focus:ring-ring
///               disabled:opacity-50 disabled:cursor-not-allowed" />
/// ```
///
/// **Example:**
/// ```swift
/// pinesInput(placeholder: "Name")
///
/// pinesInput(type: "email", placeholder: "Email", color: .blue)
///
/// pinesInput(type: "text", placeholder: "Search", name: "q")
/// ```
///
/// - Parameters:
///   - type: The HTML input type (`"text"`, `"email"`, `"password"`, etc.).
///     Defaults to `"text"`.
///   - color: Optional color for the focus ring (accent/400 shade).
///     When `nil`, uses semantic field tokens from `setupPines()`.
///   - placeholder: Optional placeholder text.
///   - name: Optional `name` attribute for form submission.
///   - value: Optional initial value.
///   - id: Optional `id` attribute (for label association via `for=`).
///   - disabled: When `true`, renders the `disabled` attribute.
///   - attributes: Extra HTML attributes merged into the input element.
public func pinesInput(
    type: String = "text",
    color: PinesColor? = nil,
    placeholder: String? = nil,
    name: String? = nil,
    value: String? = nil,
    id: String? = nil,
    disabled: Bool = false,
    attributes: [HTMLAttribute<HTMLTag.input>] = []
) -> some HTML {
    let borderColor = PinesColor.neutral.shade(.light)
    let resolvedColor = color ?? .neutral
    let focusRingColor = resolvedColor.shade(.accent)

    var inputAttributes: [HTMLAttribute<HTMLTag.input>] =
        [
            HTMLAttribute(name: "type", value: type),
            .display(.flex),
            .width(.full),
            .height(.size(10)),
            .paddingX(.size(3)),
            .paddingY(.size(2)),
            .fontSize(.sm),
            .class(PinesTheme.background),
            .borderWidth(.bare),
            .borderRadius(.md),
        ]
        + pinesTextFieldAttributes(
            borderColor: borderColor,
            placeholderColor: PinesColor.neutral.shade(.base),
            focusRingColor: focusRingColor,
            surface: color == nil,
            darkBorderColor: PinesColor.neutral.shade(.deep)
        )
    if let placeholder { inputAttributes.append(.placeholder(placeholder)) }
    if let name { inputAttributes.append(.name(name)) }
    if let value { inputAttributes.append(.value(value)) }
    if let id { inputAttributes.append(.id(id)) }
    if disabled { inputAttributes.append(.disabled) }

    return input(attributes: inputAttributes + attributes)
}
