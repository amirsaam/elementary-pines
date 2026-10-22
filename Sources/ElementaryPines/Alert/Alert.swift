import Elementary
import ElementaryTailwind

/// The base Tailwind classes shared by all Pines alert variants.
/// Contains arbitrary selectors (`[&>svg]`, `[&>img]`, `[&:has(svg),&:has(img)]`)
/// that must remain raw.
let pinesAlertBaseAttributes: [HTMLAttribute<HTMLTag.div>] = [
    .position(.relative), .width(.full), .borderRadius(.lg),
    .borderWidth(.bare), .class(PinesTheme.background), .padding(.size(4)),
    .position(.absolute, variants: [.arbitrary("[&>svg]")]),
    .position(.absolute, variants: [.arbitrary("[&>img]")]),
    .insetLeft(.size(4), variants: [.arbitrary("[&>svg]")]),
    .insetLeft(.size(4), variants: [.arbitrary("[&>img]")]),
    .insetTop(.size(4), variants: [.arbitrary("[&>svg]")]),
    .insetTop(.size(4), variants: [.arbitrary("[&>img]")]),
    .translate(.y("[-3px]"), variants: [.arbitrary("[&>svg+div]")]),
    .translate(.y("[-3px]"), variants: [.arbitrary("[&>img+div]")]),
    .paddingLeft(.size(11), variants: [.arbitrary("[&:has(svg),&:has(img)]")]),
    .class(PinesTheme.foreground),
]

/// Wraps the given content in a Pines-styled alert container.
///
/// The alert provides the layout (icon positioning via Tailwind's
/// `[&>svg]`/`[&>img]` selectors, padding, rounded corners, border, etc.) and
/// nothing else. The user provides the icon (first child), title, and body
/// inside. Use the `pinesAlert(_:icon:content:)` overload with a
/// `PinesAlertVariant` to apply a colored background, or layer `.class(...)`
/// on the result for custom styling.
///
/// The canonical styling matches `pines/elements/alert.html` while using the
/// package's semantic background and foreground theme tokens.
///
/// **Generated HTML:**
/// ```html
/// <div class="relative w-full rounded-lg border border-border bg-background p-4
///            [&>svg]:absolute [&>img]:absolute
///            [&>svg]:left-4 [&>img]:left-4 [&>svg]:top-4 [&>img]:top-4
///            [&>svg+div]:translate-y-[-3px] [&>img+div]:translate-y-[-3px]
///            [&:has(svg),&:has(img)]:pl-11 text-foreground">
///     <!-- user content -->
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesAlert {
///     pinesIcon(.info)
///     h5(.class("mb-1 font-medium leading-none tracking-tight")) { "Alert Title" }
///     div(.fontSize(.sm), .opacity(.value(70))) { "Body text" }
/// }
/// ```
public func pinesAlert<Content: HTML>(
    @ContentBuilder content: () -> Content
) -> some HTML {
    // The border color is explicit: a bare `border` resolves to
    // `currentColor` in Tailwind v4, which would paint the border in the
    // text color instead of the theme's border color.
    div(attributes: pinesAlertBaseAttributes + [.class(PinesTheme.border)]) {
        content()
    }
}
