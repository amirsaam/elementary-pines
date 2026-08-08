import Elementary
import ElementaryAlpine
import ElementaryTailwind

/// Renders a collapsible Pines UI accordion.
public func pinesAccordion(items: [PinesAccordionItem]) -> some HTML {
    let html = div(
        .position(.relative),
        .width(.full),
        .marginX(.auto),
        .overflow(.hidden),
        .fontSize(.sm),
        .fontWeight(.normal),
        .class(PinesSurface.background),
        .borderWidth(.bare),
        .borderColor(PinesColor.gray.shade(.subtle)),
        .divideY(.bare),
        .divideColor(PinesColor.gray.shade(.subtle)),
        .borderRadius(.md),
        .x.data(PinesAccordionState.xData)
    ) {
        for item in items {
            div(
                .x.data("{ id: $id('accordion') }"),
                .cursor(.pointer),
                .group(.bare)
            ) {
                button(
                    .x.on("click", "setActiveAccordion(id)"),
                    .type(.button),
                    .display(.flex),
                    .items(.center),
                    .justify(.between),
                    .width(.full),
                    .padding(.size(4)),
                    .textAlign(.left),
                    .userSelect(.none),
                    .textDecoration(.underline, variants: [.groupHover])
                ) {
                    span { item.title }
                    SVG.svg(
                        SVGAttribute(
                            name: "class",
                            value: twValue(
                                .width(.size(4)),
                                .height(.size(4)),
                                .transitionDuration(.ms(200)),
                                .transitionTimingFunction(.easeOut)
                            )
                        ),
                        SVGAttribute(
                            name: "x-bind:class",
                            value: pinesAlpineBindClass([(className: twValue(.rotate(.all(180))), condition: "activeAccordion==id")])
                                .rawValue
                        ),
                        SVGAttribute(name: "viewBox", value: "0 0 24 24"),
                        SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
                        SVGAttribute(name: "fill", value: "none"),
                        SVGAttribute(name: "stroke", value: "currentColor"),
                        SVGAttribute(name: "stroke-width", value: "2"),
                        SVGAttribute(name: "stroke-linecap", value: "round"),
                        SVGAttribute(name: "stroke-linejoin", value: "round")
                    ) {
                        SVG.polyline(.points("6 9 12 15 18 9"))
                    }
                }
                div(
                    .x.show("activeAccordion==id"),
                    HTMLAttribute(name: "x-collapse", value: nil),
                    .x.cloak
                ) {
                    div(.padding(.size(4)), .paddingTop(.zero), .opacity(.value(70))) {
                        item.body
                    }
                }
            }
        }
    }
    return HTMLRaw(html.render())
}
