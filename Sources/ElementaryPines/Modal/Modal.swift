import Elementary
import ElementaryAlpine
import ElementaryTailwind

/// Renders the Pines modal: a trigger button that opens a centered dialog
/// teleported to `<body>`, with a backdrop, a built-in close button, and a
/// zoom-in transition. Escape, clicking the backdrop, or the close button
/// dismisses it; focus is trapped and scroll locked while open.
///
/// The trigger and panel use the theme surfaces (`bg-background`,
/// `hover:bg-muted`, `ring-ring`). `color:` tints the trigger's text, hover
/// wash, and focus ring (default `.neutral` keeps the theme tokens).
///
/// Requires `setupAlpine(plugins: [.focus])` for the `x-trap` focus trap.
///
/// **Generated HTML:**
/// ```html
/// <div x-data="{ modalOpen: false }" x-on:keydown.escape.window="modalOpen=false" class="relative z-50 w-auto h-auto">
///   <button x-on:click="modalOpen=true" type="button" class="inline-flex justify-center items-center px-4 py-2 h-10 text-sm font-medium bg-background rounded-md border transition-colors hover:bg-muted active:bg-background focus:bg-background focus:outline-hidden focus:ring-2 focus:ring-offset-2 focus:ring-ring">Open</button>
///   <template x-teleport="body">
///     <div x-show="modalOpen" class="fixed top-0 left-0 z-[99] flex items-center justify-center w-screen h-screen" x-cloak>
///       <div x-show="modalOpen" x-on:click="modalOpen=false" class="absolute inset-0 w-full h-full bg-black/40"></div>
///       <div x-show="modalOpen" x-trap.inert.noscroll="modalOpen" class="relative px-7 py-6 w-full bg-background sm:max-w-lg sm:rounded-lg">
///         <button x-on:click="modalOpen=false" type="button" class="flex absolute top-0 right-0 justify-center items-center mt-5 mr-5 w-8 h-8 text-muted-foreground rounded-full hover:text-foreground hover:bg-muted">…</button>
///         …content…
///       </div>
///     </div>
///   </template>
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesModal(color: .blue) {
///     p(.fontWeight(.medium)) { "Open settings" }
/// } content: {
///     h3(.fontSize(.lg), .fontWeight(.semibold)) { "Settings" }
///     p(.fontSize(.sm), .opacity(.value(60))) { "Configure your workspace." }
/// }
/// ```
public func pinesModal(
    color: PinesColor = .neutral,
    attributes: [HTMLAttribute<HTMLTag.div>] = [],
    @ContentBuilder trigger: () -> some HTML,
    @ContentBuilder content: () -> some HTML
) -> some HTML {
    let html = div(
        attributes: [
            .position(.relative), .zIndex(.number(50)), .width(.auto), .height(.auto),
            .x.data(PinesModalState.xData),
            .x.on("keydown", "modalOpen=false", modifiers: [.escape, .window]),
        ] + attributes
    ) {
        let triggerAttrs =
            [HTMLAttribute<HTMLTag.button>.type(.button), .x.on("click", "modalOpen=true")]
            + PinesSurface.overlayTriggerAttributes(color: color)
        button(attributes: triggerAttrs) {
            trigger()
        }
        template(.x.teleport("body")) {
            div(
                .x.show("modalOpen"),
                .position(.fixed),
                .insetTop(.zero),
                .insetLeft(.zero),
                .zIndex(.number(99)),
                .display(.flex),
                .items(.center),
                .justify(.center),
                .width(.screen),
                .height(.screen),
                .x.cloak
            ) {
                div(
                    .x.show("modalOpen"),
                    .x.transitionEnter(twValue(.transitionTimingFunction(.easeOut), .transitionDuration(.ms(300)))),
                    .x.transitionEnterStart(twValue(.opacity(.value(0)))),
                    .x.transitionEnterEnd(twValue(.opacity(.value(100)))),
                    .x.transitionLeave(twValue(.transitionTimingFunction(.easeIn), .transitionDuration(.ms(300)))),
                    .x.transitionLeaveStart(twValue(.opacity(.value(100)))),
                    .x.transitionLeaveEnd(twValue(.opacity(.value(0)))),
                    .x.on("click", "modalOpen=false"),
                    .position(.absolute),
                    .inset(.zero),
                    .width(.full),
                    .height(.full),
                    .backgroundColor(.black, opacity: 40)
                ) {}
                div(
                    .x.show("modalOpen"),
                    HTMLAttribute<HTMLTag.div>(name: "x-trap.inert.noscroll", value: "modalOpen"),
                    .x.transitionEnter(twValue(.transitionTimingFunction(.easeOut), .transitionDuration(.ms(300)))),
                    .x.transitionEnterStart(
                        twValue(.opacity(.value(0)), .translate(.y("4")))
                            + " " + twValue(.translate(.y("0"), variants: [.sm]), .scale(.all(95), variants: [.sm]))
                    ),
                    .x.transitionEnterEnd(
                        twValue(.opacity(.value(100)), .translate(.y("0")))
                            + " " + twValue(.scale(.all(100), variants: [.sm]))
                    ),
                    .x.transitionLeave(twValue(.transitionTimingFunction(.easeIn), .transitionDuration(.ms(200)))),
                    .x.transitionLeaveStart(
                        twValue(.opacity(.value(100)), .translate(.y("0")))
                            + " " + twValue(.scale(.all(100), variants: [.sm]))
                    ),
                    .x.transitionLeaveEnd(
                        twValue(.opacity(.value(0)), .translate(.y("4")))
                            + " " + twValue(.translate(.y("0"), variants: [.sm]), .scale(.all(95), variants: [.sm]))
                    ),
                    .position(.relative),
                    .paddingX(.size(7)),
                    .paddingY(.size(6)),
                    .width(.full),
                    .class(PinesSurface.background),
                    .maxWidth(.lg, variants: [.sm]),
                    .borderRadius(.lg, variants: [.sm]),
                    .class(PinesSurface.foreground)
                ) {
                    button(
                        .type(.button),
                        .x.on("click", "modalOpen=false"),
                        .display(.flex),
                        .position(.absolute),
                        .insetTop(.zero),
                        .insetRight(.zero),
                        .justify(.center),
                        .items(.center),
                        .marginTop(.size(5)),
                        .marginRight(.size(5)),
                        .width(.size(8)),
                        .height(.size(8)),
                        .borderRadius(.full),
                        .class(PinesSurface.mutedForeground),
                        .class(PinesSurface.foreground, variants: [.hover]),
                        .class(PinesSurface.muted, variants: [.hover])
                    ) {
                        pinesIcon(.x, size: .md)
                    }
                    content()
                }
            }
        }
    }
    return HTMLRaw(html.render())
}
