import Elementary
import ElementaryTailwind

/// Renders a styled `<textarea>` element matching the Pines UI textarea design.
///
/// The class string matches the original `pines/elements/textarea.html`
/// layout. The `color` parameter swaps the neutral border/placeholder/ring
/// classes for the color's 300/400 shade pair. The element itself holds
/// no Alpine.js state — pass `x-data`/`x-model` on the call site (e.g. via
/// `elementary-alpine`) for dynamic behavior.
///
/// Layout:
/// ```html
/// <textarea placeholder="Type your message here."
///          class="flex w-full h-auto min-h-[80px] px-3 py-2 text-sm bg-white
///                 border rounded-md border-neutral-300 placeholder:text-neutral-400
///                 focus:border-neutral-300 focus:outline-hidden focus:ring-2
///                 focus:ring-offset-2 focus:ring-neutral-400
///                 disabled:opacity-50 disabled:cursor-not-allowed"></textarea>
/// ```
///
/// **Example:**
/// ```swift
/// pinesTextarea(placeholder: "Type your message here.")
///
/// pinesTextarea(placeholder: "Bio", color: .blue)
///
/// pinesTextarea(placeholder: "Comment", name: "comment", rows: 4)
/// ```
///
/// - Parameters:
///   - color: Optional color for border, placeholder, and focus ring
///     (300/400 shade pair). When `nil`, uses neutral-300/400 (the
///     original Pines default).
///   - placeholder: Optional placeholder text.
///   - name: Optional `name` attribute for form submission.
///   - id: Optional `id` attribute (for label association via `for=`).
///   - rows: Optional `rows` attribute (visible row count).
///   - disabled: When `true`, renders the `disabled` attribute.
///   - attributes: Extra HTML attributes merged into the textarea element.
public func pinesTextarea(
    color: PinesColor? = nil,
    placeholder: String? = nil,
    name: String? = nil,
    id: String? = nil,
    rows: Int? = nil,
    disabled: Bool = false,
    attributes: [HTMLAttribute<HTMLTag.textarea>] = []
) -> some HTML {
    let resolvedColor = color ?? .neutral
    let borderColor = resolvedColor.shade(.light)
    let placeholderColor = resolvedColor.shade(.accent)
    let focusRingColor = resolvedColor.shade(.accent)

    var textareaAttributes: [HTMLAttribute<HTMLTag.textarea>] =
        [
            .display(.flex),
            .width(.full),
            .height(.auto),
            .minHeight(.arbitrary("80px")),
            .paddingX(.size(3)),
            .paddingY(.size(2)),
            .fontSize(.sm),
            .backgroundColor(.white),
            .borderWidth(.bare),
            .borderRadius(.md),
        ]
        + pinesTextFieldAttributes(
            borderColor: borderColor,
            placeholderColor: placeholderColor,
            focusRingColor: focusRingColor,
            includeRingOffset: false
        )
    if let placeholder { textareaAttributes.append(.placeholder(placeholder)) }
    if let name { textareaAttributes.append(.name(name)) }
    if let id { textareaAttributes.append(.id(id)) }
    if let rows { textareaAttributes.append(HTMLAttribute(name: "rows", value: String(rows))) }
    if disabled { textareaAttributes.append(.disabled) }

    return textarea(attributes: textareaAttributes + attributes) {}
}
