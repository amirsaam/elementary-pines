import Elementary
import ElementaryAlpine
import ElementaryTailwind

/// Renders a Pines UI popover: a trigger button that toggles an anchored
/// panel with arbitrary content.
///
/// The styled trigger `<button>` (filled by the `trigger:` content builder)
/// toggles the panel, which opens below the trigger by default and flips above
/// when it would overflow the viewport. Clicking outside or pressing Escape
/// closes it; keyboard focus is trapped inside the panel while it is open.
///
/// `arrow:` renders the Pines arrow pointing at the trigger, `width:` controls
/// the panel width, `color:` tints the trigger text, its hover background, the
/// focus ring, and the panel text, and `position:` seeds the preferred side.
/// The focus trap uses `x-trap`, so this component requires
/// `setupAlpine(plugins: [.focus])` in `<head>`.
///
/// **Generated HTML:**
/// ```html
/// <div class="relative inline-block" x-data="{ popoverOpen: false, ... }" x-init="...">
///     <button type="button" x-ref="popoverButton" x-on:click="popoverOpen=!popoverOpen"
///             class="flex items-center justify-center w-10 h-10 bg-background border rounded-full ...">
///         <!-- trigger content -->
///     </button>
///     <div x-ref="popover" x-show="popoverOpen" x-trap.inert="popoverOpen"
///          x-on:click.outside="popoverOpen=false" x-on:keydown.escape.window="popoverOpen=false"
///          class="absolute w-[300px] max-w-lg -translate-x-1/2 left-1/2" x-cloak>
///         <div x-ref="popoverInner" class="w-full p-4 bg-background border rounded-md shadow-xs ...">
///             <!-- arrow -->
///             <!-- panel content -->
///         </div>
///     </div>
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesPopover(color: .blue, position: .bottom, arrow: true) {
///     pinesIcon(.settings, size: .sm)
/// } content: {
///     p { "Adjust the layer dimensions." }
///     input(.type(.text), .value("100%"))
/// }
/// ```
public func pinesPopover<Trigger: HTML>(
    color: PinesColor? = nil,
    position: PinesPopoverPosition = .bottom,
    arrow: Bool = true,
    width: TWTWidth = .arbitrary("300px"),
    attributes: [HTMLAttribute<HTMLTag.div>] = [],
    @ContentBuilder trigger: () -> Trigger,
    @ContentBuilder content: () -> some HTML
) -> some HTML {
    let rootAttributes: [HTMLAttribute<HTMLTag.div>] =
        [
            .position(.relative),
            .display(.inlineBlock),
            .x.data(PinesPopoverState.xData(arrow: arrow, position: position.rawValue)),
            .x.setup(PinesPopoverState.rootInit),
            .x.on("resize", "popoverPositionCalculate()", modifiers: [.window]),
        ] + attributes

    let html = div(attributes: rootAttributes) {
        let background: HTMLAttribute<HTMLTag.button> =
            color == nil
            ? .class(PinesTheme.primary)
            : color == .neutral
                ? .class(PinesTheme.background)
                : .backgroundColor(color!.shade(.tint1))
        let foreground: HTMLAttribute<HTMLTag.button> =
            color == nil
            ? .class(PinesTheme.primaryForeground)
            : color == .neutral
                ? .class(PinesTheme.foreground)
                : .textColor(color!.shade(.deep))
        let hover: HTMLAttribute<HTMLTag.button> =
            color == nil
            ? .class(PinesTheme.utility(PinesTheme.primary, opacity: 90), variants: [.hover])
            : color == .neutral
                ? .class(PinesTheme.muted, variants: [.hover])
                : .backgroundColor(color!.shade(.tint2), variants: [.hover])
        button(
            .x.ref("popoverButton"),
            .type(.button),
            .x.on("click", "popoverOpen=!popoverOpen"),
            .display(.flex),
            .items(.center),
            .justify(.center),
            .width(.size(10)),
            .height(.size(10)),
            background,
            .borderWidth(.bare),
            .borderRadius(.full),
            .boxShadow(.xs),
            .cursor(.pointer),
            foreground,
            hover,
            .ringWidth(.size(2), variants: [.focusVisible]),
            color == nil
                ? .class(PinesTheme.ring, variants: [.focusVisible])
                : color == .neutral
                    ? .class(PinesTheme.ring, variants: [.focusVisible])
                    : .ringColor(color!.shade(.accent), variants: [.focusVisible]),
            .outlineStyle(.hidden, variants: [.focusVisible]),
            color == nil
                ? .class(PinesTheme.primary, variants: [.active])
                : color == .neutral
                    ? .class(PinesTheme.background, variants: [.active])
                    : .backgroundColor(color!.shade(.tint1), variants: [.active]),
            .class(PinesTheme.utility(PinesTheme.border, opacity: 70))
        ) {
            trigger()
        }

        let panelAttributes: [HTMLAttribute<HTMLTag.div>] =
            [
                .x.ref("popover"),
                .x.show("popoverOpen"),
                .x.setup(PinesPopoverState.panelInit),
                HTMLAttribute(name: "x-trap.inert", value: "popoverOpen"),
                .x.on("click", "popoverOpen=false", modifiers: [.outside]),
                .x.on("keydown", "popoverOpen=false", modifiers: [.escape, .window]),
                .x.bindClass(pinesPopoverPositionBinding()),
                .position(.absolute),
                .width(width),
                .maxWidth(.lg),
                .insetLeft(.fraction("1/2")),
                .translate(.x("1/2"), negative: true),
                .zIndex(.number(50)),
                .x.cloak,
            ]

        div(attributes: panelAttributes) {
            div(
                .x.ref("popoverInner"),
                .x.show("popoverOpen"),
                .x.transition(),
                .width(.full),
                .padding(.size(4)),
                .class(PinesTheme.background),
                .borderRadius(.md),
                .borderWidth(.bare),
                .boxShadow(.xs),
                .class(PinesTheme.utility(PinesTheme.border, opacity: 70)),
                .class(PinesTheme.foreground)
            ) {
                if arrow {
                    pinesPopoverArrow(.bottom)
                    pinesPopoverArrow(.top)
                }
                content()
            }
        }
    }
    return HTMLRaw(html.render())
}

/// Anchors the panel below or above the trigger, matching the popover position.
private func pinesPopoverPositionBinding() -> HTMLAttributeValue.Alpine.BindClass {
    pinesAlpineBindClass([
        (twValue(.insetTop(.zero), .marginTop(.size(12))), "popoverPosition=='bottom'"),
        (twValue(.insetBottom(.zero), .marginBottom(.size(12))), "popoverPosition=='top'"),
    ])
}

/// The Pines arrow pointing at the trigger, shown on the matching side.
private func pinesPopoverArrow(_ position: PinesPopoverPosition) -> some HTML {
    switch position {
    case .bottom:
        return div(
            .x.show("popoverArrow && popoverPosition=='bottom'"),
            .position(.absolute),
            .insetTop(.zero),
            .display(.inlineBlock),
            .width(.size(5)),
            .marginTop(.arbitrary("1px")),
            .overflow(.hidden),
            .translate(.x("2"), negative: true),
            .translate(.y("2.5"), negative: true),
            .insetLeft(.fraction("1/2"))
        ) {
            div(
                .width(.size(2.5)),
                .height(.size(2.5)),
                .transformOrigin(.bottomLeft),
                .rotate(.all(45)),
                .class(PinesTheme.background),
                .class("border-t border-l border-t-border border-l-border"),
                .borderRadius(.xs)
            ) {}
        }
    case .top:
        return div(
            .x.show("popoverArrow && popoverPosition=='top'"),
            .position(.absolute),
            .insetBottom(.zero),
            .display(.inlineBlock),
            .width(.size(5)),
            .marginBottom(.arbitrary("1px")),
            .overflow(.hidden),
            .translate(.x("2"), negative: true),
            .translate(.y("2.5")),
            .insetLeft(.fraction("1/2"))
        ) {
            div(
                .width(.size(2.5)),
                .height(.size(2.5)),
                .transformOrigin(.topLeft),
                .rotate(.all(45), negative: true),
                .class(PinesTheme.background),
                .class("border-b border-l border-b-border border-l-border"),
                .borderRadius(.xs)
            ) {}
        }
    }
}
