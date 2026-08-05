import Elementary
import ElementaryAlpine
import ElementaryTailwind

/// A tab title and its rendered content.
public struct PinesTab: Sendable {
    /// The label shown in the tab button.
    public let title: String
    let content: @Sendable () -> HTMLRaw

    /// Creates a tab.
    public init(title: String, @ContentBuilder content: @escaping @Sendable () -> any HTML) {
        self.title = title
        self.content = { HTMLRaw(content().render()) }
    }
}

/// Renders a selectable Pines UI tab group.
public func pinesTabs(tabs: [PinesTab]) -> some HTML {
    let columns = TWTGridTemplateColumns.value(tabs.count)
    let html = div(
        .position(.relative),
        .width(.full),
        .x.data(PinesTabsState.xData),
        .x.setup("tabRepositionMarker($refs.tabButtons.firstElementChild);")
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
            .textColor(PinesColor.gray.shade(.base)),
            .backgroundColor(PinesColor.gray.shade(.tint2)),
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
                    .transition(.all),
                    .borderRadius(.md),
                    .cursor(.pointer),
                    .whitespace(.nowrap)
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
                div(.width(.full), .height(.full), .backgroundColor(.white), .borderRadius(.md), .boxShadow(.xs)) {}
            }
        }
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
    return HTMLRaw(html.render())
}
