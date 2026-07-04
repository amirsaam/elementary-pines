import Elementary

/// Renders a styled text input element matching the Pines UI input design.
///
/// The class string matches the original `pines/elements/text-input.html`
/// layout. The `color` parameter swaps the neutral border/ring classes for
/// the color's 300/400 shade pair. The element itself holds no Alpine.js
/// state — pass `x-data`/`x-model` on the call site (e.g. via
/// `elementary-alpinejs`) for dynamic behavior.
///
/// Layout:
/// ```html
/// <input type="text" placeholder="Name"
///        class="flex w-full h-10 px-3 py-2 text-sm bg-white border rounded-md
///               border-neutral-300 ring-offset-background
///               placeholder:text-neutral-500
///               focus:border-neutral-300 focus:outline-none focus:ring-2
///               focus:ring-offset-2 focus:ring-neutral-400
///               disabled:cursor-not-allowed disabled:opacity-50" />
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
///   - placeholder: Optional placeholder text.
///   - color: Optional color for border and focus ring (300/400 shades).
///     When `nil`, uses neutral-300/400 (the original Pines default).
///   - name: Optional `name` attribute for form submission.
///   - value: Optional initial value.
///   - id: Optional `id` attribute (for label association via `for=`).
///   - disabled: When `true`, renders the `disabled` attribute.
public func pinesInput(
    type: String = "text",
    placeholder: String? = nil,
    color: PinesColor? = nil,
    name: String? = nil,
    value: String? = nil,
    id: String? = nil,
    disabled: Bool = false
) -> some HTML {
    let borderClass = color.map { "border-\($0.rawValue)-300" } ?? "border-neutral-300"
    let focusBorderClass = color.map { "focus:border-\($0.rawValue)-300" } ?? "focus:border-neutral-300"
    let ringClass = color.map { "focus:ring-\($0.rawValue)-400" } ?? "focus:ring-neutral-400"

    let classes =
        "flex w-full h-10 px-3 py-2 text-sm bg-white border rounded-md "
        + borderClass
        + " ring-offset-background placeholder:text-neutral-500 "
        + focusBorderClass
        + " focus:outline-none focus:ring-2 focus:ring-offset-2 "
        + ringClass
        + " disabled:cursor-not-allowed disabled:opacity-50"

    var attributes: [HTMLAttribute<HTMLTag.input>] = [
        HTMLAttribute(name: "type", value: type),
        .class(classes),
    ]
    if let placeholder { attributes.append(.placeholder(placeholder)) }
    if let name { attributes.append(.name(name)) }
    if let value { attributes.append(.value(value)) }
    if let id { attributes.append(.id(id)) }
    if disabled { attributes.append(.disabled) }

    return input(attributes: attributes)
}
