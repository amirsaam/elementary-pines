import Elementary

/// Wraps the given content in a Pines-styled alert container with a
/// severity-specific color scheme and an auto-inserted icon.
///
/// The variant applies a colored border, text, and icon color to the alert.
/// The `icon:` parameter controls icon insertion:
/// - `.auto` (default): inserts the variant's default icon
///   (info→`.info`, success→`.check`, warning→`.warning`, danger→`.x`).
/// - `.none`: omits the icon entirely.
/// - `.custom(path:)`: renders a user-provided SVG file via
///   `<img src="path" class="w-4 h-4">`.
///
/// The icon (if any) is rendered as the first child of the alert, so the
/// base `[&>svg]` selectors position it in the top-left corner.
///
/// **Generated HTML (`.info` + `.auto`):**
/// ```html
/// <div class="relative w-full rounded-lg border bg-white p-4
///            [&>svg]:absolute [&>svg]:text-foreground [&>svg]:left-4 [&>svg]:top-4
///            [&>svg+div]:translate-y-[-3px] [&:has(svg)]:pl-11 text-neutral-900
///            border-blue-500 text-blue-700 [&>svg]:text-blue-500">
///     <svg ...><!-- pinesIcon(.info, size: .sm) --></svg>
///     <!-- user content -->
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesAlert(.info) {
///     h5 { "Heads up" }
///     div(.class("text-sm opacity-70")) { "This is informational." }
/// }
///
/// pinesAlert(.danger, icon: .custom("/icons/spinner.svg")) {
///     h5 { "Loading" }
///     p { "Please wait." }
/// }
///
/// pinesAlert(.success, icon: .none) {
///     h5 { "Saved" }
///     p { "Your changes have been saved." }
/// }
/// ```
public func pinesAlert<Content: HTML>(
    _ variant: PinesAlertVariant,
    icon: PinesAlertIcon = .auto,
    @HTMLBuilder content: () -> Content
) -> some HTML {
    let baseClasses =
        "relative w-full rounded-lg border bg-white p-4 [&>svg]:absolute [&>svg]:text-foreground [&>svg]:left-4 [&>svg]:top-4 [&>svg+div]:translate-y-[-3px] [&:has(svg)]:pl-11 text-neutral-900"

    return div(.class(baseClasses + variant.classesSuffix)) {
        switch icon {
        case .none:
            content()
        case .auto:
            pinesIcon(variant.defaultIcon, size: .sm)
            content()
        case .custom(let path):
            img(.src(path), .class("w-4 h-4"))
            content()
        }
    }
}
