import Elementary
import ElementaryAlpine
import ElementaryTailwind

/// Renders a selectable Pines UI tab group.
public func pinesTabs(tabs: [PinesTab]) -> some HTML {
    let columns = TWTGridTemplateColumns.value(tabs.count)
    let html = div(
        .position(.relative),
        .width(.full),
        .x.data(PinesTabsState.xData),
        .x.setup(PinesTabsState.xInit)
    ) {
        div(
            .x.ref("tabButtons"),
            .position(.relative),
            .display(.inlineGrid),
            .items(.center),
            .justify(.center),
            .width(.full),
            .height(.size(10)),
            .padding(.size(1)),
            .class(PinesTheme.mutedForeground),
            .class(PinesTheme.muted),
            .borderRadius(.lg),
            .userSelect(.none),
            .gridTemplateColumns(columns)
        ) {
            for tab in tabs {
                button(
                    .x.bind("id", "$id(tabId)"),
                    .x.on("click", "tabButtonClicked($el);"),
                    .type(.button),
                    .position(.relative),
                    .zIndex(.number(20)),
                    .display(.inlineFlex),
                    .items(.center),
                    .justify(.center),
                    .width(.full),
                    .height(.size(8)),
                    .paddingX(.size(3)),
                    .fontSize(.sm),
                    .fontWeight(.medium),
                    .class("transition-all"),
                    .borderRadius(.md),
                    .cursor(.pointer),
                    .whitespace(.nowrap),
                    .x.bindClass(
                        pinesAlpineBindClass([
                            (PinesTheme.primaryForeground, "tabSelected == $el.id.replace(tabId + '-', '')")
                        ])
                    )
                ) { tab.title }
            }
            div(
                .x.ref("tabMarker"),
                .position(.absolute),
                .insetLeft(.zero),
                .zIndex(.number(10)),
                .width(.fraction("1/2")),
                .height(.full),
                .transitionDuration(.ms(300)),
                .transitionTimingFunction(.easeOut),
                .x.cloak
            ) {
                div(.width(.full), .height(.full), .class(PinesTheme.primary), .borderRadius(.md), .boxShadow(.xs)) {}
            }
        }
        div(
            .position(.relative),
            .display(.flex),
            .items(.center),
            .justify(.center),
            .width(.full),
            .marginTop(.size(2)),
            .padding(.size(5)),
            .fontSize(.xs),
            .class(PinesTheme.mutedForeground),
            .borderWidth(.bare),
            .borderRadius(.md),
            .class(PinesTheme.border)
        ) {
            for (index, tab) in tabs.enumerated() {
                if index == 0 {
                    div(.x.bind("id", "$id(tabId + '-content')"), .x.show("tabContentActive($el)"), .position(.relative)) {
                        tab.content()
                    }
                } else {
                    div(.x.bind("id", "$id(tabId + '-content')"), .x.show("tabContentActive($el)"), .position(.relative), .x.cloak) {
                        tab.content()
                    }
                }
            }
        }
    }
    return HTMLRaw(html.render())
}
