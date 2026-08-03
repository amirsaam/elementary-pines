import Elementary
import ElementaryTailwind

/// Wraps the given content in a Pines-styled alert container with a
/// severity-specific color scheme and an auto-inserted icon.
///
/// The variant applies a solid colored background with white text to the
/// alert container. The `icon:` parameter controls icon insertion:
/// - `.auto` (default): inserts the variant's default icon
///   (info→`.info`, success→`.check`, warning→`.warning`, danger→`.x`).
/// - `.none`: omits the icon entirely.
/// - `.custom(path:)`: renders a user-provided SVG file via
///   `<img src="path" class="w-5 h-5 -translate-y-0.5">`.
///
/// The icon (if any) is rendered as the first child of the alert, so the
/// base `[&>svg]`/`[&>img]` selectors position it in the top-left corner.
///
/// **Generated HTML (`.info` + `.auto`):**
/// ```html
/// <div class="relative w-full rounded-lg border bg-white p-4
///            [&>svg]:absolute [&>img]:absolute [&>svg]:text-foreground
///            [&>svg]:left-4 [&>img]:left-4 [&>svg]:top-4 [&>img]:top-4
///            [&>svg+div]:translate-y-[-3px] [&>img+div]:translate-y-[-3px]
///            [&:has(svg),&:has(img)]:pl-11 text-neutral-900
///            border-transparent bg-blue-600 text-white">
///     <svg ... class="w-5 h-5 -translate-y-0.5"><!-- pinesIcon(.info, size: .md) --></svg>
///     <!-- user content -->
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesAlert(.info) {
///     h5 { "Heads up" }
///     div(.fontSize(.sm), .opacity(.value(70))) { "This is informational." }
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
    @ContentBuilder content: () -> Content
) -> some HTML {
    div(
        attributes: pinesAlertBaseAttributes + variant.attributes
    ) {
        switch icon {
        case .none:
            content()
        case .auto:
            pinesIcon(
                variant.defaultIcon,
                size: .md,
                attributes: [
                    SVGAttribute<SVGTag.svg>(
                        name: "class",
                        value: "-translate-y-0.5",
                        mergedBy: .appending(separatedBy: " ")
                    )
                ]
            )
            content()
        case .custom(let path):
            img(
                .src(path),
                .width(.size(5)),
                .height(.size(5)),
                .translate(.y("0.5"), negative: true)
            )
            content()
        }
    }
}
