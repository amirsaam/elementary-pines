import Elementary
import ElementaryAlpine
import ElementaryTailwind

/// A slide-over panel that enters from the right edge of the screen, anchored
/// by a styled trigger button. It mirrors the Pines slide-over element.
///
/// The panel is teleported to `<body>`, slides in with a translate transition,
/// and closes on backdrop click, Escape, or `click.away`. A title header and a
/// labeled "Close" button are rendered when `title` is non-empty.
///
/// **Generated HTML:**
/// ```html
/// <div x-data="{ slideOverOpen: false }" class="relative z-50 w-auto h-auto">
///   <button @click="slideOverOpen=true" class="inline-flex justify-center items-center px-4 py-2 h-10 text-sm font-medium bg-background ...">Open</button>
///   <template x-teleport="body">
///     <div x-show="slideOverOpen" @keydown.window.escape="slideOverOpen=false" class="relative z-[99]">
///       <div x-show="slideOverOpen" x-transition.opacity.duration.600ms @click="slideOverOpen=false" class="fixed inset-0 bg-black/10"></div>
///       ...
///     </div>
///   </template>
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesSlideOver(title: "Settings", size: .default) {
///     p(.fontWeight(.medium)) { "Open settings" }
/// } content: {
///     p(.fontSize(.sm), .opacity(.value(60))) { "Configure your workspace." }
/// }
/// ```
///
/// - Parameters:
///   - size: The panel width — `.default`, `.half`, or `.full`. Defaults to `.default`.
///   - title: The panel title shown in the header. An empty string hides the header.
///   - color: The accent tint for the trigger (label text, hover wash, focus ring).
///     Defaults to `.neutral`, which keeps the theme surfaces.
///   - attributes: Extra attributes merged onto the root element.
///   - trigger: The button label content.
///   - content: The slide-over body content.
public func pinesSlideOver(
    size: PinesSlideOverSize = .default,
    title: String = "",
    color: PinesColor = .neutral,
    attributes: [HTMLAttribute<HTMLTag.div>] = [],
    @ContentBuilder trigger: () -> some HTML,
    @ContentBuilder content: () -> some HTML
) -> some HTML {
    let enterLeave =
        twValue(
            .transitionTimingFunction(.easeInOut),
            .transitionDuration(.ms(500)),
            .transitionDuration(.ms(700), variants: [.sm])
        )
    let slideIn = twValue(.translate(.x("0")))
    let slideOut = twValue(.translate(.x("full")))
    let panelAttrs: [HTMLAttribute<HTMLTag.div>] = [
        .x.show("slideOverOpen"),
        .x.on("click", "slideOverOpen=false", modifiers: [.outside]),
        .x.transitionEnter(enterLeave),
        .x.transitionEnterStart(slideOut),
        .x.transitionEnterEnd(slideIn),
        .x.transitionLeave(enterLeave),
        .x.transitionLeaveStart(slideIn),
        .x.transitionLeaveEnd(slideOut),
        .width(.screen),
        .maxWidth(size.maxWidth),
    ]
    let panelInnerAttrs: [HTMLAttribute<HTMLTag.div>] = [
        .display(.flex),
        .overflowY(.scroll),
        .flexDirection(.column),
        .paddingY(.size(5)),
        .height(.full),
        .class(PinesSurface.background),
        .borderWidth(.l(1)),
        .class(PinesSurface.borderSubtle),
        .boxShadow(.lg),
        .position(.relative),
    ]
    let closeButtonAttrs: [HTMLAttribute<HTMLTag.button>] = [
        .type(.button),
        .x.on("click", "slideOverOpen=false"),
        .display(.flex),
        .position(.absolute),
        .insetRight(.zero),
        .zIndex(.number(30)),
        .justify(.center),
        .items(.center),
        .paddingX(.size(3)),
        .paddingY(.size(2)),
        .marginTop(.size(6)),
        .marginRight(.size(5)),
        .spaceX(.size(1)),
        .fontSize(.xs),
        .fontWeight(.medium),
        .textTransform(.uppercase),
        .borderRadius(.md),
        .borderWidth(.bare),
        .class(PinesSurface.border),
        .class(PinesSurface.mutedForeground),
        .class(PinesSurface.muted, variants: [.hover]),
    ]
    let html = div(
        attributes: [
            .position(.relative), .zIndex(.number(50)), .width(.auto), .height(.auto),
            .x.data(PinesSlideOverState.xData),
        ] + attributes
    ) {
        let triggerAttrs =
            [HTMLAttribute<HTMLTag.button>.type(.button), .x.on("click", "slideOverOpen=true")]
            + PinesSurface.overlayTriggerAttributes(color: color)
        button(attributes: triggerAttrs) {
            trigger()
        }
        template(.x.teleport("body")) {
            div(
                .position(.relative),
                .zIndex(.arbitrary("99")),
                .x.show("slideOverOpen"),
                .x.on("keydown", "slideOverOpen=false", modifiers: [.escape, .window])
            ) {
                div(
                    .position(.fixed),
                    .inset(.zero),
                    .backgroundColor(.black, opacity: 10),
                    .x.show("slideOverOpen"),
                    .x.transition(modifiers: [.opacity, .duration(600)]),
                    .x.on("click", "slideOverOpen=false")
                ) {}
                div(.overflow(.hidden), .position(.fixed), .inset(.zero)) {
                    div(.overflow(.hidden), .position(.absolute), .inset(.zero)) {
                        div(
                            .display(.flex),
                            .position(.fixed),
                            .insetTop(.zero),
                            .insetBottom(.zero),
                            .insetRight(.zero),
                            .maxWidth(.full)
                        ) {
                            div(attributes: panelAttrs) {
                                div(attributes: panelInnerAttrs) {
                                    if !title.isEmpty {
                                        div(
                                            .display(.flex),
                                            .justify(.between),
                                            .items(.start),
                                            .paddingBottom(.size(1)),
                                            .paddingX(.size(4)),
                                            .paddingX(.size(5), variants: [.sm])
                                        ) {
                                            h2(
                                                .fontSize(.base),
                                                .fontWeight(.semibold),
                                                .lineHeight(.value(6)),
                                                .class(PinesSurface.foreground)
                                            ) {
                                                title
                                            }
                                        }
                                    }
                                    button(attributes: closeButtonAttrs) {
                                        pinesIcon(.x, size: .sm)
                                        span { "Close" }
                                    }
                                    div(
                                        .position(.relative),
                                        .flex(.one),
                                        .paddingX(.size(4)),
                                        .marginTop(.size(5)),
                                        .paddingX(.size(5), variants: [.sm])
                                    ) {
                                        content()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return HTMLRaw(html.render())
}
