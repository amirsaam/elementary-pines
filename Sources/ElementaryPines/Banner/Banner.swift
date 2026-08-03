import Elementary
import ElementaryAlpine
import ElementaryTailwind

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
///      class="fixed top-0 left-0 w-full h-auto py-2 duration-300 ease-out bg-white shadow-xs sm:py-0 sm:h-10" x-cloak>
///     <div class="flex items-center justify-between w-full h-full px-3 mx-auto max-w-7xl">
///         <a href="#" class="flex flex-col w-full h-full text-xs leading-6 text-black duration-150 ease-out sm:flex-row sm:items-center opacity-80 hover:opacity-100">
///             <span class="flex items-center">
///                 <!-- icon (unless `icon: nil`) -->
///                 <strong class="font-semibold">New Feature</strong><span class="hidden w-[1px] h-4 mx-3 rounded-full sm:block bg-neutral-200"></span>
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
    let isTop = position == .top
    let hiddenTranslation = isTop ? twValue(.translate(.y("10"), negative: true)) : twValue(.translate(.y("full")))

    return div(
        .x.data("{ bannerVisible: false, bannerVisibleAfter: 300 }"),
        .x.show("bannerVisible"),
        .x.transitionEnter(
            twValue(
                .transition(.all),
                .transitionTimingFunction(.easeOut),
                .transitionDuration(.ms(500))
            )
        ),
        .x.transitionEnterStart(hiddenTranslation),
        .x.transitionEnterEnd(twValue(.translate(.y("0")))),
        .x.transitionLeave(
            twValue(
                .transition(.all),
                .transitionTimingFunction(.easeIn),
                .transitionDuration(.ms(300))
            )
        ),
        .x.transitionLeaveStart(twValue(.translate(.y("0")))),
        .x.transitionLeaveEnd(hiddenTranslation),
        .x.setup("setTimeout(()=>{ bannerVisible = true }, bannerVisibleAfter);"),
        .position(.fixed),
        isTop ? .insetTop(.zero) : .insetBottom(.zero),
        .insetLeft(.zero),
        .width(.full),
        .height(.auto),
        .paddingY(.size(2)),
        .transitionDuration(.ms(300)),
        .transitionTimingFunction(.easeOut),
        .backgroundColor(isTop ? .white : .black),
        .boxShadow(.xs),
        .paddingY(.size(0), variants: [.sm]),
        .height(.size(10), variants: [.sm]),
        .x.cloak
    ) {
        div(
            .display(.flex),
            .items(.center),
            .justify(.between),
            .width(.full),
            .height(.full),
            .paddingX(.size(3)),
            .marginX(.auto),
            .maxWidth(.sevenxl),
        ) {
            a(
                .href(href),
                .display(.flex),
                .flexDirection(.column),
                .width(.full),
                .height(.full),
                .fontSize(.xs),
                .lineHeight(.value(6)),
                .textColor(isTop ? .black : .white),
                .transitionDuration(.ms(150)),
                .transitionTimingFunction(.easeOut),
                .flexDirection(.row, variants: [.sm]),
                .items(.center, variants: [.sm]),
                .opacity(.value(80)),
                .opacity(.value(100), variants: [.hover])
            ) {
                span(.display(.flex), .items(.center)) {
                    if let icon {
                        switch icon {
                        case .wand:
                            pinesSpecialIcon(.wand, attributes: [.width(.size(4)), .height(.size(4)), .marginRight(.size(1))])
                        case .kind(let kind):
                            pinesIcon(kind, size: .sm, attributes: [.marginRight(.size(1))])
                        case .custom(let path):
                            img(.src(path), .width(.size(4)), .height(.size(4)), .marginRight(.size(1)))
                        }
                    }
                    strong(.fontWeight(.semibold)) {
                        label
                    }
                    span(
                        .display(.hidden),
                        .width(.arbitrary("1px")),
                        .height(.size(4)),
                        .marginX(.size(3)),
                        .borderRadius(.full),
                        .display(.block, variants: [.sm]),
                        .backgroundColor(isTop ? PinesColor.neutral.shade(.subtle) : PinesColor.neutral.shade(.bold))
                    ) {
                        ""
                    }
                }
                span(
                    .display(.block),
                    .paddingTop(.size(1)),
                    .paddingBottom(.size(2)),
                    .lineHeight(.none),
                    .display(.inline, variants: [.sm]),
                    .paddingTop(.size(0), variants: [.sm]),
                    .paddingBottom(.size(0), variants: [.sm])
                ) {
                    message
                }
            }
            if dismissible {
                button(
                    .type(.button),
                    .x.on("click", "bannerVisible=false; setTimeout(()=>{ bannerVisible = true }, 1000);"),
                    .display(.flex),
                    .items(.center),
                    .flexShrink(.shrink0),
                    .translate(.x("1")),
                    .transitionTimingFunction(.easeOut),
                    .transitionDuration(.ms(150)),
                    .justify(.center),
                    .width(.size(6)),
                    .height(.size(6)),
                    .padding(.size(1.5)),
                    .textColor(isTop ? .black : .white),
                    .borderRadius(.full),
                    .backgroundColor(
                        isTop
                            ? PinesColor.neutral.shade(.tint2)
                            : PinesColor.neutral.shade(.deep),
                        variants: [.hover]
                    )
                ) {
                    pinesBannerDismissIcon()
                }
            }
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
        .width(.full),
        .height(.full)
    ) {
        SVG.path(
            .d(PinesIconKind.x.path),
            .strokeLinecap(.round),
            .strokeLinejoin(.round)
        )
    }
}
