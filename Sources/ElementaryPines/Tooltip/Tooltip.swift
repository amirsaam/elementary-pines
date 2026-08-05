import Elementary
import ElementaryAlpine
import ElementaryTailwind

/// The placement of a Pines tooltip relative to its trigger.
public enum PinesTooltipPosition: String, Sendable {
    /// Places the tooltip above the trigger.
    case top
    /// Places the tooltip to the left of the trigger.
    case left
    /// Places the tooltip below the trigger.
    case bottom
    /// Places the tooltip to the right of the trigger.
    case right
}

/// Renders a tooltip around arbitrary trigger content.
public func pinesTooltip(
    text: String,
    position: PinesTooltipPosition = .top,
    arrow: Bool = true,
    @ContentBuilder content: () -> some HTML
) -> some HTML {
    let xData =
        "{ tooltipVisible: false, tooltipText: \(pinesJavaScriptStringLiteral(text)), tooltipArrow: \(arrow), tooltipPosition: '\(position.rawValue)' }"
    let html = div(
        .position(.relative),
        .x.data(xData),
        .x.setup(
            "$refs.content.addEventListener('mouseenter', () => { tooltipVisible = true; }); $refs.content.addEventListener('mouseleave', () => { tooltipVisible = false; });"
        )
    ) {
        div(
            .x.ref("tooltip"),
            .x.show("tooltipVisible"),
            .x.bindClass(PinesTooltipState.positionBinding()),
            .position(.absolute),
            .width(.auto),
            .fontSize(.sm),
            .x.cloak
        ) {
            div(
                .x.show("tooltipVisible"),
                .x.transition(),
                .position(.relative),
                .paddingX(.size(2)),
                .paddingY(.size(1)),
                .textColor(.white),
                .borderRadius(.sm),
                .backgroundColor(.black, opacity: 90)
            ) {
                p(.x.text("tooltipText"), .display(.block), .flexShrink(.shrink0), .fontSize(.xs), .whitespace(.nowrap)) {}
                if arrow {
                    div(
                        .x.ref("tooltipArrow"),
                        .x.show("tooltipArrow"),
                        .x.bindClass(PinesTooltipState.arrowBinding()),
                        .display(.inlineFlex),
                        .overflow(.hidden),
                        .position(.absolute),
                        .justify(.center),
                        .items(.center)
                    ) {
                        div(
                            .x.bindClass(PinesTooltipState.arrowSquareBinding()),
                            .width(.size(1.5)),
                            .height(.size(1.5)),
                            .backgroundColor(.black, opacity: 90),
                        ) {}
                    }
                }
            }
        }
        div(.x.ref("content")) { content() }
    }
    return HTMLRaw(html.render())
}
