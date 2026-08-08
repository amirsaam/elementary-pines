import Elementary
import ElementaryAlpine
import ElementaryTailwind

/// Renders a Pines dropdown menu.
///
/// A styled trigger `<button>` (which the user fills with avatar/name/chevron
/// content) toggles a dropdown panel anchored by `position`. Clicking outside
/// closes it; the panel supports arrow-key navigation (Up/Down to move, Enter
/// to activate, Escape to close). Menu contents are supplied via the
/// `items:` closure — use ``pinesDropdownItem(_:)`` and
/// ``pinesDropdownSeparator()`` and wrap them in an array.
///
/// `color` tints the trigger text, the panel text, and the menu-item hover
/// background. Defaults to `.neutral`, which reproduces the Pines palette.
/// ``PinesDropdownItem``s with `danger: true` override the color with red.
///
/// **Generated HTML:**
/// ```html
/// <div class="relative" x-data="{ dropdownOpen: false, ... }">
///     <button type="button" x-on:click="openDropdown()"
///             class="inline-flex justify-center items-center py-2 pr-12 pl-3 h-12 ...">
///         <!-- trigger content -->
///     </button>
///     <div x-show="dropdownOpen" x-on:click.outside="dropdownOpen=false"
///          class="absolute top-0 left-1/2 z-50 mt-12 w-56 -translate-x-1/2" x-cloak>
///         <div class="p-1 mt-1 bg-white rounded-md border shadow-md border-neutral-200/70 text-neutral-700">
///             <!-- menu items -->
///         </div>
///     </div>
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesDropdown(color: .blue) {
///     img(.src("avatar.jpg"), .width(.size(8)), .height(.size(8)), .borderRadius(.full))
///     span(.marginLeft(.size(2))) { "Adam Wathan" }
/// } items: {
///     [pinesDropdownItem(.init(title: "Profile", icon: .user, shortcut: "⇧⌘P")),
///      pinesDropdownSeparator(),
///      pinesDropdownItem(.init(title: "Delete", icon: .trash, danger: true, action: "remove()"))]
/// }
/// ```
public func pinesDropdown<Trigger: HTML>(
    color: PinesColor = .neutral,
    position: PinesDropdownPosition = .belowCenter,
    width: TWTWidth = .size(56),
    attributes: [HTMLAttribute<HTMLTag.div>] = [],
    @ContentBuilder trigger: () -> Trigger,
    items: () -> [PinesDropdownContent]
) -> some HTML {
    let rootAttributes: [HTMLAttribute<HTMLTag.div>] =
        [
            .position(.relative),
            .x.data(PinesDropdownState.xData),
        ] + attributes
    let html = div(attributes: rootAttributes) {
        button(
            .x.ref("dropdownButton"),
            .type(.button),
            .x.on("click", "openDropdown()"),
            .x.on("keydown", "openDropdown()", modifiers: [.down, .prevent]),
            .x.on("keydown", "closeDropdown()", modifiers: [.escape]),
            .display(.inlineFlex),
            .justify(.center),
            .items(.center),
            .paddingY(.size(2)),
            .paddingLeft(.size(3)),
            .paddingRight(.size(12)),
            .height(.size(12)),
            .fontSize(.sm),
            .fontWeight(.medium),
            .class(PinesSurface.background),
            .borderRadius(.md),
            .borderWidth(.bare),
            .transition(.colors),
            .textColor(color.shade(.bold)),
            .backgroundColor(color.shade(.tint2), variants: [.hover]),
            .backgroundColor(.white, variants: [.active, .focus]),
            .outlineStyle(.hidden, variants: [.focus])
        ) {
            trigger()
        }

        let panelAttributes: [HTMLAttribute<HTMLTag.div>] =
            [
                .x.ref("dropdownPanel"),
                .x.show("dropdownOpen"),
                .x.on("click", "dropdownOpen=false", modifiers: [.outside]),
                .x.on("keydown", "moveNext()", modifiers: [.down, .prevent]),
                .x.on("keydown", "movePrev()", modifiers: [.up, .prevent]),
                .x.on("keydown", "closeDropdown()", modifiers: [.escape]),
                .x.transitionEnter(twValue(.transitionTimingFunction(.easeOut), .transitionDuration(.ms(200)))),
                .x.transitionEnterStart(twValue(.translate(.y("2"), negative: true))),
                .x.transitionEnterEnd(twValue(.translate(.y("0")))),
                .position(.absolute),
                .zIndex(.number(50)),
                .width(width),
                .x.cloak,
            ] + position.attributes

        div(attributes: panelAttributes) {
            div(
                .padding(.size(1)),
                .marginTop(.size(1)),
                .class(PinesSurface.background),
                .borderRadius(.md),
                .borderWidth(.bare),
                .boxShadow(.md),
                .class(PinesSurface.borderSubtle),
                .textColor(color.shade(.bold))
            ) {
                for content in items() {
                    switch content {
                    case .item(let item):
                        pinesDropdownItemView(item, color: color)
                    case .separator:
                        pinesDropdownSeparatorView()
                    }
                }
            }
        }
    }
    return HTMLRaw(html.render())
}

private func pinesDropdownItemView(_ item: PinesDropdownItem, color: PinesColor) -> HTMLRaw {
    if let href = item.href {
        var attrs: [HTMLAttribute<HTMLTag.a>] = pinesDropdownItemAttributes(item, color: color)
        attrs.append(HTMLAttribute(name: "href", value: href))
        if let action = item.action { attrs.append(.x.on("click", item.handler(for: action))) }
        if item.disabled { attrs.append(HTMLAttribute(name: "data-disabled", value: nil)) }
        let element = a(attributes: attrs) {
            pinesDropdownItemChildren(item)
        }
        return HTMLRaw(element.render())
    }
    var attrs: [HTMLAttribute<HTMLTag.div>] = pinesDropdownItemAttributes(item, color: color)
    if let action = item.action {
        let handler = item.handler(for: action)
        attrs.append(.x.on("click", handler))
        attrs.append(.x.on("keydown", handler, modifiers: [.enter, .prevent]))
    }
    if item.disabled { attrs.append(HTMLAttribute(name: "data-disabled", value: nil)) }
    let element = div(attributes: attrs) {
        pinesDropdownItemChildren(item)
    }
    return HTMLRaw(element.render())
}

private func pinesDropdownSeparatorView() -> HTMLRaw {
    let element = div(
        .marginX(.size(1), negative: true),
        .marginY(.size(1)),
        .height(.arbitrary("1px")),
        .backgroundColor(PinesColor.neutral.shade(.subtle))
    ) {}
    return HTMLRaw(element.render())
}

@ContentBuilder
private func pinesDropdownItemChildren(_ item: PinesDropdownItem) -> some HTML {
    if let icon = item.icon {
        pinesIcon(icon, size: .sm, attributes: [.marginRight(.size(2))])
    }
    span { item.title }
    if let shortcut = item.shortcut {
        span(
            .marginLeft(.auto),
            .fontSize(.xs),
            .letterSpacing(.widest),
            .opacity(.value(60))
        ) {
            shortcut
        }
    }
}

private func pinesDropdownItemAttributes<Tag: HTMLTagDefinition>(
    _ item: PinesDropdownItem,
    color: PinesColor
) -> [HTMLAttribute<Tag>] {
    var attrs: [HTMLAttribute<Tag>] = [
        .position(.relative),
        .display(.flex),
        .items(.center),
        .cursor(.default),
        .userSelect(.none),
        .borderRadius(.md),
        .paddingX(.size(2)),
        .paddingY(.size(1.5)),
        .fontSize(.sm),
        .outlineStyle(.hidden),
        .transition(.colors),
        HTMLAttribute(name: "tabindex", value: "-1"),
        HTMLAttribute(name: "data-dropdown-item", value: nil),
        .pointerEvents(.none, variants: [.arbitrary("data-[disabled]")]),
        .opacity(.value(50), variants: [.arbitrary("data-[disabled]")]),
    ]
    if item.danger {
        attrs.append(.textColor(PinesColor.red.shade(.strong)))
        attrs.append(.backgroundColor(PinesColor.red.shade(.tint2), variants: [.hover]))
    } else {
        attrs.append(.backgroundColor(color.shade(.tint2), variants: [.hover]))
    }
    return attrs
}

private extension PinesDropdownItem {
    /// The Alpine click handler for the item, closing the menu when
    /// `closeOnSelect` is true.
    func handler(for action: String) -> String {
        closeOnSelect ? "dropdownOpen=false; \(action)" : action
    }
}
