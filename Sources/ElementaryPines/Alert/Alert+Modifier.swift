import Elementary
import ElementaryTailwind

/// Wraps the given content in a Pines-styled alert container with a
/// severity-specific color scheme and an auto-inserted icon.
///
/// The variant applies a solid colored background with white text to the
/// alert container. The `icon:` parameter controls icon insertion:
/// - `.auto` (default): inserts the variant's default icon
///   (info→`.info`, success→`.check`, warning→`.warning`, danger→`.x`).
/// - `.none`: omits the icon entirely. An explicit `.none` always wins,
///   even when `pinesIcon:` is also supplied.
/// - `.custom(path:)`: renders a user-provided SVG file via
///   `<img src="path" class="w-4 h-4">`.
///
/// For the `.basic` variant, optional `color:` and `pinesIcon:` parameters
/// allow customizing the color and icon. When `color:` is provided, the
/// alert uses that color's tint/deep shades. When `pinesIcon:` is provided,
/// that icon is rendered instead of the default.
///
/// The icon (if any) is rendered as the first child of the alert, so the
/// base `[&>svg]`/`[&>img]` selectors position it in the top-left corner.
///
/// **Generated HTML (`.info` + `.auto`):**
/// ```html
/// <div class="relative w-full rounded-lg border bg-background p-4
///            [&>svg]:absolute [&>img]:absolute
///            [&>svg]:left-4 [&>img]:left-4 [&>svg]:top-4 [&>img]:top-4
///            [&>svg+div]:translate-y-[-3px] [&>img+div]:translate-y-[-3px]
///            [&:has(svg),&:has(img)]:pl-11 text-foreground
///            border-transparent bg-blue-600 text-white">
///     <svg ... class="w-4 h-4"><!-- pinesIcon(.info, size: .sm) --></svg>
///     <!-- user content -->
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesAlert(.info) {
///     h5(.class("mb-1 font-medium leading-none tracking-tight")) { "Heads up" }
///     div(.fontSize(.sm), .opacity(.value(70))) { "This is informational." }
/// }
///
/// pinesAlert(.danger, icon: .custom("/icons/spinner.svg")) {
///     h5(.class("mb-1 font-medium leading-none tracking-tight")) { "Loading" }
///     p { "Please wait." }
/// }
///
/// pinesAlert(.success, icon: .none) {
///     h5(.class("mb-1 font-medium leading-none tracking-tight")) { "Saved" }
///     p { "Your changes have been saved." }
/// }
///
/// pinesAlert(.basic, color: .blue, pinesIcon: .info) {
///     h5(.class("mb-1 font-medium leading-none tracking-tight")) { "Custom" }
///     p { "A basic alert with custom color and icon." }
/// }
/// ```
public func pinesAlert<Content: HTML>(
    _ variant: PinesAlertVariant,
    icon: PinesAlertIcon = .auto,
    color: PinesColor? = nil,
    pinesIcon: PinesIconKind? = nil,
    @ContentBuilder content: () -> Content
) -> some HTML {
    let resolvedIcon: PinesAlertIcon = {
        if icon == .none {
            return .none
        }
        if variant == .basic, let pinesIcon {
            return .auto
        }
        return icon
    }()

    return div(
        attributes: pinesAlertBaseAttributes + variant.attributes(customColor: color)
    ) {
        switch resolvedIcon {
        case .none:
            content()
        case .auto:
            let iconKind = pinesIcon ?? variant.defaultIcon
            pinesAlertIcon(
                iconKind,
                size: .sm
            )
            content()
        case .custom(let path):
            img(
                .src(path),
                .width(.size(4)),
                .height(.size(4))
            )
            content()
        }
    }
}

// `pinesIcon` is shadowed by the `pinesIcon:` parameter of the overload
// above, so the icon is rendered through this file-scope helper.
private func pinesAlertIcon(_ kind: PinesIconKind, size: PinesIconSize) -> some HTML {
    pinesIcon(kind, size: size)
}
