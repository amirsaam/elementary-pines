import Elementary

/// Wraps the given content in a Pines-styled alert container.
///
/// The alert provides the layout (icon positioning via Tailwind's `[&>svg]`
/// selectors, padding, rounded corners, border, etc.) and nothing else. The
/// user provides the icon (first child), title, and body inside. To recolor
/// the alert (e.g. for info/success/warning/danger), layer `.class(...)` on
/// the result.
///
/// The canonical styling matches `pines/elements/alert.html` — white
/// background, neutral text, opacity-70 on the body for a subtle look.
///
/// **Generated HTML:**
/// ```html
/// <div class="relative w-full rounded-lg border bg-white p-4
///            [&>svg]:absolute [&>svg]:text-foreground [&>svg]:left-4 [&>svg]:top-4
///            [&>svg+div]:translate-y-[-3px] [&:has(svg)]:pl-11 text-neutral-900">
///     <!-- user content -->
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesAlert {
///     HTMLRaw(#"<svg class="w-4 h-4" ...>...</svg>"#)
///     h5 { "Alert Title" }
///     div(.class("text-sm opacity-70")) { "Body text" }
/// }
/// ```
public func pinesAlert<Content: HTML>(
    @ContentBuilder content: () -> Content
) -> some HTML {
    div(
        .class(
            "relative w-full rounded-lg border bg-white p-4 [&>svg]:absolute [&>svg]:text-foreground [&>svg]:left-4 [&>svg]:top-4 [&>svg+div]:translate-y-[-3px] [&:has(svg)]:pl-11 text-neutral-900"
        )
    ) {
        content()
    }
}
