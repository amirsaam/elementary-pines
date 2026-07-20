import Elementary
import ElementaryAlpine

/// Renders the official Pines UI banner: a fixed top- (or bottom-) of-page
/// announcement bar driven by Alpine.js.
///
/// The banner starts hidden (`bannerVisible: false`), appears
/// `bannerVisibleAfter` milliseconds after `x-init`, and animates in/out via
/// `x-transition` classes. The content model matches the official example:
/// a leading icon, a `<strong>` label, a vertical divider, and a message —
/// all wrapped in a link — plus a dismiss button. The dismiss button matches
/// the official markup and re-shows the banner after 1 second; remove the
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
/// // Official primary top-of-page example (white banner).
/// pinesBanner(
///     label: "New Feature",
///     message: "Click here to learn about our latest feature",
///     href: "#"
/// )
///
/// // Official bottom-of-page example (black banner).
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
///   - icon: An optional leading icon. Defaults to `.wand` (the official
///     magic-wand SVG). Pass `nil` to omit the icon.
///   - dismissible: When `true`, a close button is rendered at the trailing
///     edge. Defaults to `true`.
///   - position: `.top` (default — white banner sliding in from above) or
///     `.bottom` (black banner sliding in from below), matching the two
///     official Pines examples.
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
                            pinesBannerWandIcon()
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

/// Per-position style values matching the two official Pines banner examples
/// (white banner at the top, black banner at the bottom).
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

/// The magic-wand SVG from the official Pines banner example, inlined 1:1
/// (`class="w-4 h-4 mr-1"`, 24×24 grid, four stroked paths inside a `<g>`).
private func pinesBannerWandIcon() -> some HTML {
    SVG.svg(
        .class("w-4 h-4 mr-1"),
        SVGAttribute(name: "viewBox", value: "0 0 24 24"),
        SVGAttribute(name: "fill", value: "none"),
        SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg")
    ) {
        HTMLRaw(BannerWandIcon.body)
    }
}

/// SVG path data for the default wand icon, copied 1:1 from the official
/// Pines banner example. Distinct from the single-path `PinesIconKind`
/// Heroicons — the wand uses four paths with mixed cap/join styles.
private enum BannerWandIcon {
    static let body =
        #"<g fill="none" stroke="none">"#
        + #"<path d="M10.1893 8.12241C9.48048 8.50807 9.66948 9.5633 10.4691 9.68456L13.5119 10.0862C13.7557 10.1231 13.7595 10.6536 13.7968 10.8949L14.2545 13.5486C14.377 14.3395 15.4432 14.5267 15.8333 13.8259L17.1207 11.3647C17.309 11.0046 17.702 10.7956 18.1018 10.8845C18.8753 11.1023 19.6663 11.3643 20.3456 11.4084C21.0894 11.4567 21.529 10.5994 21.0501 10.0342C20.6005 9.50359 20.0352 8.75764 19.4669 8.06623C19.2213 7.76746 19.1292 7.3633 19.2863 7.00567L20.1779 4.92643C20.4794 4.23099 19.7551 3.52167 19.0523 3.82031L17.1037 4.83372C16.7404 4.99461 16.3154 4.92545 16.0217 4.65969C15.3919 4.08975 14.6059 3.39451 14.0737 2.95304C13.5028 2.47955 12.6367 2.91341 12.6845 3.64886C12.7276 4.31093 13.0055 5.20996 13.1773 5.98734C13.2677 6.3964 13.041 6.79542 12.658 6.97364L10.1893 8.12241Z" stroke="currentColor" stroke-width="1.5"></path>"#
        + #"<path d="M12.1575 9.90759L3.19359 18.8714C2.63313 19.3991 2.61799 20.2851 3.16011 20.8317C3.70733 21.3834 4.60355 21.3694 5.13325 20.8008L13.9787 11.9552" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>"#
        + #"<path d="M5 6.25V3.75M3.75 5H6.25" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>"#
        + #"<path d="M18 20.25V17.75M16.75 19H19.25" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>"#
        + "</g>"
}

/// The close icon inside the dismiss button — identical to `pinesIcon(.x)`
/// but with `class="w-full h-full"` so it fills the `w-6 h-6 p-1.5` button,
/// matching the official example.
private func pinesBannerDismissIcon() -> some HTML {
    SVG.svg(
        SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
        SVGAttribute(name: "fill", value: "none"),
        SVGAttribute(name: "viewBox", value: "0 0 24 24"),
        SVGAttribute(name: "stroke-width", value: "1.5"),
        SVGAttribute(name: "stroke", value: "currentColor"),
        .class("w-full h-full")
    ) {
        HTMLRaw(#"<path stroke-linecap="round" stroke-linejoin="round" d="\#(PinesIconKind.x.path)" />"#)
    }
}
