import Elementary
import ElementaryAlpine

/// Renders a Pines UI banner: a fixed top- (or bottom-) of-page
/// announcement bar driven by Alpine.js.
///
/// The banner starts hidden (`bannerVisible: false`), appears
/// `bannerVisibleAfter` milliseconds after `x-init`, and animates in/out via
/// `x-transition` classes. The content model is a leading icon, a `<strong>` label, a vertical divider, and a message —
/// all wrapped in a link — plus a dismiss button. The dismiss button
/// re-shows the banner after 1 second; remove the
/// second `setTimeout` statement from its `x-on:click` handler if you want a
/// permanent dismiss.
///
/// **Generated HTML (top, defaults):**
/// ```html
/// <div x-data="{ bannerVisible: false, bannerVisibleAfter: 300 }"
///      x-show="bannerVisible"
///      x-transition:enter="transition ease-out duration-500"
///      x-transition:enter-start="-translate-y-10"
///      x-transition:enter-end="translate-y-0"
///      x-transition:leave="transition ease-in duration-300"
///      x-transition:leave-start="translate-y-0"
///      x-transition:leave-end="-translate-y-10"
///      x-init="setTimeout(()=>{ bannerVisible = true }, bannerVisibleAfter);"
///      class="fixed top-0 left-0 w-full h-auto py-2 duration-300 ease-out bg-white shadow-sm sm:py-0 sm:h-10" x-cloak>
///     <div class="flex items-center justify-between w-full h-full px-3 mx-auto max-w-7xl">
///         <a href="#" class="flex flex-col w-full h-full text-xs leading-6 text-black duration-150 ease-out sm:flex-row sm:items-center opacity-80 hover:opacity-100">
///             <span class="flex items-center">
///                 <!-- icon (unless `icon: nil`) -->
///                 <strong class="font-semibold">New Feature</strong><span class="hidden w-px h-4 mx-3 rounded-full sm:block bg-neutral-200"></span>
///             </span>
///             <span class="block pt-1 pb-2 leading-none sm:inline sm:pt-0 sm:pb-0">Click here to learn about our latest feature</span>
///         </a>
///         <!-- dismiss button (if `dismissible: true`) -->
///     </div>
/// </div>
/// ```
///
/// **Examples:**
/// ```swift
/// // Top-of-page example (white banner).
/// pinesBanner(
///     label: "New Feature",
///     message: "Click here to learn about our latest feature",
///     href: "#"
/// )
///
/// // Bottom-of-page example (black banner).
/// pinesBanner(
///     label: "New Feature",
///     message: "Click here to learn about our latest feature",
///     href: "#",
///     position: .bottom
/// )
///
/// // No icon, not dismissible.
/// pinesBanner(label: "Hello", message: "World", href: "/hello", icon: nil, dismissible: false)
/// ```
///
/// - Parameters:
///   - label: The bold leading text inside the banner link.
///   - message: The message text shown after the divider.
///   - href: The URL the banner content links to. Defaults to `"#"`.
///   - icon: An optional leading icon. Defaults to `.wand` (the
///     magic-wand SVG). Pass `nil` to omit the icon.
///   - dismissible: When `true`, a close button is rendered at the trailing
///     edge. Defaults to `true`.
///   - position: `.top` (default — white banner sliding in from above) or
///     `.bottom` (black banner sliding in from below).
public func pinesBanner(
    label: String,
    message: String,
    href: String = "#",
    icon: PinesBannerIcon? = .wand,
    dismissible: Bool = true,
    position: PinesBannerPosition = .top
) -> some HTML {
    let styles = BannerPositionStyles(position: position)

    return div(
        .x.data("{ bannerVisible: false, bannerVisibleAfter: 300 }"),
        .x.show("bannerVisible"),
        .x.transitionEnter("transition ease-out duration-500"),
        .x.transitionEnterStart(styles.hiddenTranslation),
        .x.transitionEnterEnd("translate-y-0"),
        .x.transitionLeave("transition ease-in duration-300"),
        .x.transitionLeaveStart("translate-y-0"),
        .x.transitionLeaveEnd(styles.hiddenTranslation),
        .x.setup("setTimeout(()=>{ bannerVisible = true }, bannerVisibleAfter);"),
        .class("fixed \(styles.edge) left-0 w-full h-auto py-2 duration-300 ease-out \(styles.background) shadow-sm sm:py-0 sm:h-10"),
        .x.cloak
    ) {
        div(.class("flex items-center justify-between w-full h-full px-3 mx-auto max-w-7xl")) {
            a(
                .href(href),
                .class(
                    "flex flex-col w-full h-full text-xs leading-6 \(styles.text) "
                        + "duration-150 ease-out sm:flex-row sm:items-center opacity-80 hover:opacity-100"
                )
            ) {
                span(.class("flex items-center")) {
                    if let icon {
                        switch icon {
                        case .wand:
                            pinesSpecialIcon(.wand, attributes: [.class("w-4 h-4 mr-1")])
                        case .kind(let kind):
                            pinesIcon(kind, size: .sm, attributes: [.class("mr-1")])
                        case .custom(let path):
                            img(.src(path), .class("w-4 h-4 mr-1"))
                        }
                    }
                    strong(.class("font-semibold")) {
                        label
                    }
                    span(.class("hidden w-px h-4 mx-3 rounded-full sm:block \(styles.divider)")) {
                        ""
                    }
                }
                span(.class("block pt-1 pb-2 leading-none sm:inline sm:pt-0 sm:pb-0")) {
                    message
                }
            }
            if dismissible {
                button(
                    .x.on("click", "bannerVisible=false; setTimeout(()=>{ bannerVisible = true }, 1000);"),
                    .class(
                        "flex items-center flex-shrink-0 translate-x-1 ease-out duration-150 "
                            + "justify-center w-6 h-6 p-1.5 \(styles.text) rounded-full \(styles.buttonHover)"
                    )
                ) {
                    pinesBannerDismissIcon()
                }
            }
        }
    }
}

/// Per-position style values for the banner (white at top, black at bottom).
private struct BannerPositionStyles {
    /// The fixed edge class: `top-0` or `bottom-0`.
    let edge: String
    /// The banner background class: `bg-white` or `bg-black`.
    let background: String
    /// The foreground text class applied to the link and the dismiss button:
    /// `text-black` or `text-white`.
    let text: String
    /// The divider background class: `bg-neutral-200` or `bg-neutral-700`.
    let divider: String
    /// The dismiss button hover class: `hover:bg-neutral-100` or
    /// `hover:bg-neutral-800`.
    let buttonHover: String
    /// The off-screen translation used for `x-transition:enter-start` and
    /// `x-transition:leave-end`: `-translate-y-10` (top) or
    /// `translate-y-full` (bottom).
    let hiddenTranslation: String

    init(position: PinesBannerPosition) {
        switch position {
        case .top:
            edge = "top-0"
            background = "bg-white"
            text = "text-black"
            divider = "bg-neutral-200"
            buttonHover = "hover:bg-neutral-100"
            hiddenTranslation = "-translate-y-10"
        case .bottom:
            edge = "bottom-0"
            background = "bg-black"
            text = "text-white"
            divider = "bg-neutral-700"
            buttonHover = "hover:bg-neutral-800"
            hiddenTranslation = "translate-y-full"
        }
    }
}

/// The close icon inside the dismiss button — identical to `pinesIcon(.x)`
/// but with `class="w-full h-full"` so it fills the `w-6 h-6 p-1.5` button.
private func pinesBannerDismissIcon() -> some HTML {
    SVG.svg(
        SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
        SVGAttribute(name: "fill", value: "none"),
        SVGAttribute(name: "viewBox", value: "0 0 24 24"),
        SVGAttribute(name: "stroke-width", value: "1.5"),
        SVGAttribute(name: "stroke", value: "currentColor"),
        .class("w-full h-full")
    ) {
        SVG.path(
            .d(PinesIconKind.x.path),
            .strokeLinecap(.round),
            .strokeLinejoin(.round)
        )
    }
}
