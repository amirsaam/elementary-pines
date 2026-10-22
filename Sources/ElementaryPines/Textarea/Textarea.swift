import Elementary
import ElementaryTailwind

/// Renders a styled `<textarea>` element matching the Pines UI textarea design.
///
/// The class string matches the original `pines/elements/textarea.html`
/// layout. The `color` parameter changes only the focus ring; the field border
/// and placeholder remain neutral. The element itself holds
/// no Alpine.js state — pass `x-data`/`x-model` on the call site (e.g. via
/// `elementary-alpine`) for dynamic behavior.
///
/// Layout:
/// ```html
/// <textarea placeholder="Type your message here."
///          class="flex w-full h-auto min-h-[80px] px-3 py-2 text-sm bg-background
///                 border rounded-md border-border placeholder:text-muted-foreground
///                 focus:outline-hidden focus:ring-2
///                 focus:ring-offset-2 focus:ring-ring
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
///   - color: Optional color for the focus ring (accent/400 shade). When `nil`, uses semantic field tokens from
///     `setupPines()`.
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
    let borderColor = PinesColor.neutral.shade(.light)
    let placeholderColor = PinesColor.neutral.shade(.base)
    let resolvedColor = color ?? .neutral
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
            .class(PinesTheme.background),
            .borderWidth(.bare),
            .borderRadius(.md),
        ]
        + pinesTextFieldAttributes(
            borderColor: borderColor,
            placeholderColor: placeholderColor,
            focusRingColor: focusRingColor,
            includeRingOffset: true,
            surface: color == nil,
            darkBorderColor: PinesColor.neutral.shade(.deep)
        )
    if let placeholder { textareaAttributes.append(.placeholder(placeholder)) }
    if let name { textareaAttributes.append(.name(name)) }
    if let id { textareaAttributes.append(.id(id)) }
    if let rows { textareaAttributes.append(HTMLAttribute(name: "rows", value: String(rows))) }
    if disabled { textareaAttributes.append(.disabled) }

    return textarea(attributes: textareaAttributes + attributes) {}
}
