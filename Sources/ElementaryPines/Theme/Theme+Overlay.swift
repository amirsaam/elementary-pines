import Elementary
import ElementaryTailwind

extension PinesTheme {
    /// Shared trigger button for overlay components (modal, slide-over).
    /// Surfaces follow the theme. An omitted `color` uses the semantic accent
    /// emitted by `setupPines()`, while an explicit color uses its palette.
    static func overlayTriggerAttributes<Tag: HTMLTagDefinition>(color: PinesColor?) -> [HTMLAttribute<Tag>] {
        let background: HTMLAttribute<Tag> =
            color == nil
            ? .class(PinesTheme.primary)
            : color == .neutral
                ? .class(PinesTheme.background)
                : .backgroundColor(color!.shade(.tint1))
        let foreground: HTMLAttribute<Tag> =
            color == nil
            ? .class(PinesTheme.primaryForeground)
            : color == .neutral
                ? .class(PinesTheme.foreground)
                : .textColor(color!.shade(.deep))
        let hover: HTMLAttribute<Tag> =
            color == nil
            ? .class(PinesTheme.utility(PinesTheme.primary, opacity: 90), variants: [.hover])
            : color == .neutral
                ? .class(PinesTheme.muted, variants: [.hover])
                : .backgroundColor(color!.shade(.tint2), variants: [.hover])
        let active: HTMLAttribute<Tag> =
            color == nil
            ? .class(PinesTheme.primary, variants: [.active, .focus])
            : color == .neutral
                ? .class(PinesTheme.background, variants: [.active, .focus])
                : .backgroundColor(color!.shade(.tint1), variants: [.active, .focus])
        return [
            .display(.inlineFlex), .justify(.center), .items(.center),
            .paddingX(.size(4)), .paddingY(.size(2)), .height(.size(10)),
            .fontSize(.sm), .fontWeight(.medium),
            background, .borderRadius(.md), .borderWidth(.bare),
            .class(utility(border, opacity: 70)), .transition(.colors),
            foreground,
            hover,
            active,
            .outlineStyle(.hidden, variants: [.focus]),
            .ringWidth(.size(2), variants: [.focus]), .ringOffsetWidth(.size(2), variants: [.focus]),
            overlayTriggerRing(color),
        ]
    }

    private static func overlayTriggerRing<Tag: HTMLTagDefinition>(_ color: PinesColor?) -> HTMLAttribute<Tag> {
        if color == nil { return .class(ring, variants: [.focus]) }
        if color == .neutral { return .class(ring, variants: [.focus]) }
        return .ringColor(color!.shade(.accent), variants: [.focus])
    }

}
