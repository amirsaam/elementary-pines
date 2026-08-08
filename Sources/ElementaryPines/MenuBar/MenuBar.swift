import Elementary
import ElementaryAlpine
import ElementaryTailwind

/// A single selectable row in a `pinesMenuBar` menu.
public struct PinesMenuBarItem: Sendable {
    /// The row label.
    public let title: String
    /// An optional keyboard-shortcut hint rendered right-aligned.
    public let shortcut: String?
    /// When `true`, the row is inert (`data-disabled`) and faded.
    public let disabled: Bool
    /// An optional Alpine expression run on click, after the menu closes.
    public let action: String?

    public init(title: String, shortcut: String? = nil, disabled: Bool = false, action: String? = nil) {
        self.title = title
        self.shortcut = shortcut
        self.disabled = disabled
        self.action = action
    }
}

/// An entry inside a `PinesMenuBarMenu` — either an item or a separator.
public enum PinesMenuBarContent: Sendable {
    case item(PinesMenuBarItem)
    case separator
}

/// A named menu (File, Edit, …) inside a `pinesMenuBar`.
public struct PinesMenuBarMenu: Sendable {
    /// The menu's button label and the key used in the Alpine state.
    public let title: String
    /// The rows shown when the menu is open.
    public let items: [PinesMenuBarContent]

    public init(title: String, items: [PinesMenuBarContent]) {
        self.title = title
        self.items = items
    }
}

/// Renders the Pines menu bar: a bordered bar of menu buttons, each opening a
/// dropdown panel. Clicking a menu opens it; hovering switches menus while
/// open; clicking away closes. Selecting an item closes the bar.
///
/// The bar and its panels use the theme surfaces (`bg-background`,
/// `text-foreground`, `border-border/80`, `hover:bg-muted`), so they follow
/// `setupPines(accent:bgLight:bgDark:)`. `color:` tints the menu-button and
/// item hover washes (default `.neutral` keeps the theme `bg-muted`).
///
/// **Generated HTML:**
/// ```html
/// <div x-data="{ menuBarOpen: false, menuBarMenu: '' }" x-on:click.outside="menuBarOpen=false" class="relative top-0 left-0 z-50 w-auto transition-all duration-150 ease-out">
///   <div class="relative top-0 left-0 z-40 w-auto h-10 transition duration-200 ease-out">
///     <div class="w-full h-full p-1 bg-background border rounded-md border-border/80">
///       <div class="flex justify-between w-full h-full select-none text-foreground">
///         <div class="relative h-full cursor-default">
///           <button x-on:click="menuBarOpen=true; menuBarMenu='File'" x-on:mouseover="menuBarMenu='File'" x-bind:class="{ 'bg-muted' : menuBarOpen && menuBarMenu == 'File'}" class="rounded text-sm cursor-default flex items-center leading-tight justify-center px-3 py-1.5 h-full hover:bg-muted">File</button>
///           <div x-show="menuBarOpen && menuBarMenu=='File'" x-transition:enter="transition ease-linear duration-100" x-transition:enter-start="-translate-y-1 opacity-90" x-transition:enter-end="translate-y-0 opacity-100" class="absolute top-0 z-50 min-w-[8rem] text-foreground rounded-md border border-border/70 bg-background mt-10 text-sm p-1 shadow-md w-48 -translate-x-0.5" x-cloak>
///             <button x-on:click="menuBarOpen=false" class="relative flex justify-between w-full cursor-default select-none group items-center rounded px-2 py-1.5 hover:bg-muted hover:text-foreground outline-hidden data-[disabled]:opacity-50 data-[disabled]:pointer-events-none"><span>New Tab</span><span class="ml-auto text-xs tracking-widest text-muted-foreground group-hover:text-foreground">⌘T</span></button>
///             <div class="h-px my-1 -mx-1 bg-neutral-200"></div>
///           </div>
///         </div>
///       </div>
///     </div>
///   </div>
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesMenuBar(menus: [
///     .init(title: "File", items: [
///         .item(.init(title: "New Tab", shortcut: "⌘T", action: "newTab()")),
///         .separator,
///         .item(.init(title: "Print", shortcut: "⌘P")),
///     ]),
///     .init(title: "Edit", items: [
///         .item(.init(title: "Undo", shortcut: "⌘Z")),
///         .item(.init(title: "Redo", shortcut: "⇧⌘Z", disabled: true)),
///     ]),
/// ])
/// ```
public func pinesMenuBar(
    color: PinesColor = .neutral,
    attributes: [HTMLAttribute<HTMLTag.div>] = [],
    menus: [PinesMenuBarMenu]
) -> some HTML {
    let html = div(
        attributes: [
            .position(.relative), .insetTop(.zero), .insetLeft(.zero), .zIndex(.number(50)),
            .width(.auto), .transition(.all), .transitionDuration(.ms(150)), .transitionTimingFunction(.easeOut),
            .x.data(PinesMenuBarState.xData),
            .x.on("click", "menuBarOpen=false", modifiers: [.outside]),
        ] + attributes
    ) {
        div(
            .position(.relative),
            .insetTop(.zero),
            .insetLeft(.zero),
            .zIndex(.number(40)),
            .width(.auto),
            .height(.size(10)),
            .transition(.all),
            .transitionDuration(.ms(200)),
            .transitionTimingFunction(.easeOut)
        ) {
            div(
                .width(.full),
                .height(.full),
                .padding(.size(1)),
                .class(PinesSurface.background),
                .borderWidth(.bare),
                .borderRadius(.md),
                .class(PinesSurface.borderSubtle80)
            ) {
                div(
                    .display(.flex),
                    .justify(.between),
                    .width(.full),
                    .height(.full),
                    .userSelect(.none),
                    .class(PinesSurface.foreground)
                ) {
                    for menu in menus {
                        pinesMenuBarButtonView(menu, color: color)
                    }
                }
            }
        }
    }
    return HTMLRaw(html.render())
}

private func pinesMenuBarButtonView(_ menu: PinesMenuBarMenu, color: PinesColor) -> HTMLRaw {
    let name = pinesJavaScriptStringLiteral(menu.title)
    let html = div(.position(.relative), .height(.full), .cursor(.default)) {
        button(
            .type(.button),
            .x.on("click", "menuBarOpen=true; menuBarMenu=\(name)"),
            .x.on("mouseover", "menuBarMenu=\(name)"),
            .x.bindClass(
                pinesAlpineBindClass([
                    (pinesMenuBarHoverClass(color), "menuBarOpen && menuBarMenu == \(name)")
                ])
            ),
            .borderRadius(.md),
            .fontSize(.sm),
            .cursor(.default),
            .display(.flex),
            .items(.center),
            .lineHeight(.none),
            .justify(.center),
            .paddingX(.size(3)),
            .paddingY(.size(1.5)),
            .height(.full),
            pinesMenuBarHoverBackground(color, variants: [.hover])
        ) {
            menu.title
        }
        div(
            .x.show("menuBarOpen && menuBarMenu==\(name)"),
            .x.transitionEnter("transition ease-linear duration-100"),
            .x.transitionEnterStart("-translate-y-1 opacity-90"),
            .x.transitionEnterEnd("translate-y-0 opacity-100"),
            .position(.absolute),
            .insetTop(.zero),
            .zIndex(.number(50)),
            .minWidth(.arbitrary("8rem")),
            .class(PinesSurface.foreground),
            .borderRadius(.md),
            .borderWidth(.bare),
            .class(PinesSurface.borderSubtle),
            .class(PinesSurface.background),
            .marginTop(.size(10)),
            .fontSize(.sm),
            .padding(.size(1)),
            .boxShadow(.md),
            .width(.size(48)),
            .translate(.x("0.5"), negative: true),
            .x.cloak
        ) {
            for content in menu.items {
                switch content {
                case .item(let item):
                    pinesMenuBarItemView(item, color: color)
                case .separator:
                    pinesMenuBarSeparatorView()
                }
            }
        }
    }
    return HTMLRaw(html.render())
}

private func pinesMenuBarItemView(_ item: PinesMenuBarItem, color: PinesColor) -> HTMLRaw {
    var attrs: [HTMLAttribute<HTMLTag.button>] = [
        .type(.button),
        .x.on("click", item.clickHandler),
        .position(.relative), .display(.flex), .justify(.between), .width(.full),
        .cursor(.default), .userSelect(.none), .borderRadius(.md),
        .paddingX(.size(2)), .paddingY(.size(1.5)),
        pinesMenuBarHoverBackground(color, variants: [.hover]),
        .class(PinesSurface.foreground, variants: [.hover]),
        .outlineStyle(.hidden),
        .opacity(.value(50), variants: [.arbitrary("[data-disabled]")]),
        .pointerEvents(.none, variants: [.arbitrary("[data-disabled]")]),
    ]
    if item.disabled {
        attrs.append(HTMLAttribute<HTMLTag.button>(name: "data-disabled", value: ""))
    }
    let html = button(attributes: attrs) {
        span { item.title }
        if let shortcut = item.shortcut {
            span(
                .marginLeft(.auto),
                .fontSize(.xs),
                .letterSpacing(.widest),
                .class(PinesSurface.mutedForeground),
                .class(PinesSurface.foreground, variants: [.groupHover])
            ) {
                shortcut
            }
        }
    }
    return HTMLRaw(html.render())
}

private func pinesMenuBarSeparatorView() -> HTMLRaw {
    let html = div(
        .height(.arbitrary("1px")),
        .marginY(.size(1)),
        .marginX(.size(1), negative: true),
        .backgroundColor(PinesColor.neutral.shade(.subtle))
    ) {}
    return HTMLRaw(html.render())
}

private extension PinesMenuBarItem {
    var clickHandler: String {
        if let action {
            return "menuBarOpen=false; \(action)"
        }
        return "menuBarOpen=false"
    }
}

private func pinesMenuBarHoverBackground<Tag: HTMLTagDefinition>(_ color: PinesColor, variants: [TWVariant] = []) -> HTMLAttribute<Tag> {
    if color == .neutral {
        return .class(PinesSurface.muted, variants: variants)
    }
    return .backgroundColor(color.shade(.tint2), variants: variants)
}

private func pinesMenuBarHoverClass(_ color: PinesColor) -> String {
    if color == .neutral {
        return PinesSurface.muted
    }
    return twValue(.backgroundColor(color.shade(.tint2)))
}
