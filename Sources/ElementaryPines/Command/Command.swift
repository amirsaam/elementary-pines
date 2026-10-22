import Elementary
import ElementaryAlpine
import ElementaryTailwind

/// A Spotlight-style command palette with live filtering and keyboard
/// navigation. It mirrors the Pines command element.
///
/// The palette is a passive panel — place it inside your own overlay/modal and
/// drive visibility from there. Arrow keys move the active row, Enter selects
/// it, and typing filters by `title`. Disabled rows are skipped on selection.
///
/// **Generated HTML:**
/// ```html
/// <div x-data="{ commandItems: [...], ... }" @keydown.down="event.preventDefault(); commandItemActiveNext();" class="flex min-h-[370px] justify-center w-full max-w-xl items-start" x-cloak>
///   <div class="flex flex-col w-full h-full overflow-hidden bg-background border border-border rounded-lg shadow-md">
///     <div class="flex items-center px-3 border-b-1 border-border text-muted-foreground">…</div>
///     <div x-ref="commandItemsList" class="max-h-[320px] overflow-y-auto overflow-x-hidden">…</div>
///   </div>
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesCommand(color: .blue, items: [
///     .init(title: "Calendar", value: "calendar", icon: .calendar, category: "Suggestions"),
///     .init(title: "Profile", value: "profile", icon: .user, shortcut: "⌘P", category: "Settings"),
///     .init(title: "Delete", value: "delete", icon: .trash, category: "Danger", action: "remove()"),
/// ])
/// ```
///
/// - Parameters:
///   - color: The accent used for the active row. Defaults to `.neutral`,
///     which keeps the theme `bg-muted`/`text-foreground` highlight.
///   - items: The selectable commands.
///   - placeholder: The search input placeholder text.
///   - attributes: Extra attributes merged onto the root element.
public func pinesCommand(
    color: PinesColor = .neutral,
    items: [PinesCommandItem],
    placeholder: String = "Type a command or search...",
    attributes: [HTMLAttribute<HTMLTag.div>] = []
) -> some HTML {
    let xData = PinesCommandState.xData(items: items)
    let activeClassName: String
    if color == .neutral {
        activeClassName = "\(PinesTheme.muted) \(PinesTheme.foreground)"
    } else {
        activeClassName =
            "\(twValue(.backgroundColor(color.shade(.tint2)))) \(twValue(.textColor(color.shade(.dark))))"
    }
    let activeClass = pinesAlpineBindClass([
        (
            className: activeClassName,
            condition: "commandItemIsActive(item)"
        )
    ])
    let searchInputAttrs: [HTMLAttribute<HTMLTag.input>] = [
        .type(.text), .x.ref("commandInput"), .x.model("commandSearch"),
        .display(.flex), .width(.full), .paddingX(.size(2)), .paddingY(.size(3)),
        .fontSize(.sm), .backgroundColor(.transparent), .borderWidth(.size(0)),
        .borderRadius(.md), .outlineStyle(.hidden),
        .outlineStyle(.hidden, variants: [.focus]),
        .ringWidth(.size(0), variants: [.focus]),
        .borderWidth(.size(0), variants: [.focus]),
        .class(PinesTheme.mutedForeground, variants: [.placeholder]),
        .height(.size(11)),
        HTMLAttribute(name: "placeholder", value: placeholder),
        HTMLAttribute(name: "autocomplete", value: "off"),
        HTMLAttribute(name: "autocorrect", value: "off"),
        HTMLAttribute(name: "spellcheck", value: "false"),
    ]
    let itemRowAttrs: [HTMLAttribute<HTMLTag.div>] = [
        .x.bind("id", "item.value + '-' + commandId"),
        .x.on("click", "commandSelect(item)"),
        .x.on("mousemove", "commandItemActive=item"),
        .x.bind("data-disabled", "item.disabled"),
        .x.bindClass(activeClass),
        .position(.relative), .display(.flex), .cursor(.default),
        .userSelect(.none), .items(.center), .borderRadius(.sm),
        .paddingX(.size(2)), .paddingY(.size(1.5)), .fontSize(.sm),
        .outlineStyle(.hidden),
        .pointerEvents(.none, variants: [.arbitrary("data-[disabled=true]")]),
        .opacity(.value(50), variants: [.arbitrary("data-[disabled=true]")]),
    ]
    let rootAttrs: [HTMLAttribute<HTMLTag.div>] =
        [
            .display(.flex), .minHeight(.arbitrary("370px")), .justify(.center),
            .width(.full), .maxWidth(.xl), .items(.start),
            .x.data(xData),
            .x.setup("commandSearchItems(); $watch('commandSearch', value => commandSearchItems());"),
            .x.on("keydown", "event.preventDefault(); commandItemActiveNext();", modifiers: [.down]),
            .x.on("keydown", "event.preventDefault(); commandItemActivePrevious();", modifiers: [.up]),
            .x.on("keydown", "commandSelect(commandItemActive);", modifiers: [.enter]),
            .x.cloak,
        ] + attributes
    let html = div(attributes: rootAttrs) {
        div(
            .display(.flex),
            .flexDirection(.column),
            .width(.full),
            .height(.full),
            .overflow(.hidden),
            .class(PinesTheme.background),
            .borderWidth(.bare),
            .class(PinesTheme.border),
            .borderRadius(.lg),
            .boxShadow(.md)
        ) {
            div(
                .display(.flex),
                .items(.center),
                .paddingX(.size(3)),
                .borderWidth(.b(1)),
                .class(PinesTheme.border),
                .class(PinesTheme.mutedForeground)
            ) {
                pinesIcon(.search, size: .sm)
                input(attributes: searchInputAttrs)
            }
            div(
                .x.ref("commandItemsList"),
                .maxHeight(.arbitrary("320px")),
                .overflowY(.auto),
                .overflowX(.hidden)
            ) {
                template(
                    .x.loop("(item, index) in commandItemsFiltered"),
                    .x.bind("key", "'item-' + index")
                ) {
                    div(.paddingBottom(.size(1)), .spaceY(.size(1))) {
                        template(.x.when("commandShowCategory(item, index)")) {
                            div(.paddingX(.size(1)), .overflow(.hidden), .class(PinesTheme.foreground)) {
                                div(
                                    .paddingX(.size(2)),
                                    .paddingY(.size(1)),
                                    .marginY(.size(1)),
                                    .fontSize(.xs),
                                    .fontWeight(.medium),
                                    .class(PinesTheme.mutedForeground),
                                    .x.text("commandCategoryCapitalize(item.category)")
                                ) {}
                            }
                        }
                        template(.x.when("(item.default && commandSearchIsEmpty()) || !commandSearchIsEmpty()")) {
                            div(.paddingX(.size(1))) {
                                div(attributes: itemRowAttrs) {
                                    span(.x.html("item.icon")) {}
                                    span(.x.text("item.title")) {}
                                    template(.x.when("item.right")) {
                                        span(
                                            .marginLeft(.auto),
                                            .fontSize(.xs),
                                            .letterSpacing(.widest),
                                            .class(PinesTheme.mutedForeground),
                                            .x.text("item.right")
                                        ) {}
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
