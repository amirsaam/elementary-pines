import Elementary
import ElementaryTailwind

/// The base Tailwind classes shared by all Pines alert variants.
/// Contains arbitrary selectors (`[&>svg]`, `[&>img]`, `[&:has(svg),&:has(img)]`)
/// that must remain raw.
let pinesAlertBaseAttributes: [HTMLAttribute<HTMLTag.div>] = [
    .position(.relative), .width(.full), .borderRadius(.lg),
    .borderWidth(.bare), .backgroundColor(.white), .padding(.size(4)),
    .position(.absolute, variants: [.arbitrary("[&>svg]")]),
    .position(.absolute, variants: [.arbitrary("[&>img]")]),
    .class("text-foreground", variants: [.arbitrary("[&>svg]")]),
    .insetLeft(.size(4), variants: [.arbitrary("[&>svg]")]),
    .insetLeft(.size(4), variants: [.arbitrary("[&>img]")]),
    .insetTop(.size(4), variants: [.arbitrary("[&>svg]")]),
    .insetTop(.size(4), variants: [.arbitrary("[&>img]")]),
    .translate(.y("[-3px]"), variants: [.arbitrary("[&>svg+div]")]),
    .translate(.y("[-3px]"), variants: [.arbitrary("[&>img+div]")]),
    .paddingLeft(.size(11), variants: [.arbitrary("[&:has(svg),&:has(img)]")]),
    .textColor(PinesColor.neutral.shade(.dark)),
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
/// The canonical styling matches `pines/elements/alert.html` — white
/// background, neutral text, opacity-70 on the body for a subtle look.
///
/// **Generated HTML:**
/// ```html
/// <div class="relative w-full rounded-lg border bg-white p-4
///            [&>svg]:absolute [&>img]:absolute [&>svg]:text-foreground
///            [&>svg]:left-4 [&>img]:left-4 [&>svg]:top-4 [&>img]:top-4
///            [&>svg+div]:translate-y-[-3px] [&>img+div]:translate-y-[-3px]
///            [&:has(svg),&:has(img)]:pl-11 text-neutral-900">
///     <!-- user content -->
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesAlert {
///     pinesIcon(.info)
///     h5 { "Alert Title" }
///     div(.fontSize(.sm), .opacity(.value(70))) { "Body text" }
/// }
/// ```
public func pinesAlert<Content: HTML>(
    @ContentBuilder content: () -> Content
) -> some HTML {
    div(attributes: pinesAlertBaseAttributes) {
        content()
    }
}
