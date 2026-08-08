import Elementary
import ElementaryTailwind

extension PinesSurface {
    /// Shared trigger button for overlay components (modal, slide-over).
    /// Surfaces follow the theme; `color` tints the label text, hover wash, and
    /// focus ring (`.neutral` keeps the theme tokens).
    static func overlayTriggerAttributes<Tag: HTMLTagDefinition>(color: PinesColor) -> [HTMLAttribute<Tag>] {
        [
            .display(.inlineFlex), .justify(.center), .items(.center),
            .paddingX(.size(4)), .paddingY(.size(2)), .height(.size(10)),
            .fontSize(.sm), .fontWeight(.medium),
            overlayTriggerText(color),
            .class(background), .borderRadius(.md), .borderWidth(.bare),
            .class(borderSubtle), .transition(.colors),
            accentHover(color, variants: [.hover]),
            .class(background, variants: [.active, .focus]),
            .outlineStyle(.hidden, variants: [.focus]),
            .ringWidth(.size(2), variants: [.focus]), .ringOffsetWidth(.size(2), variants: [.focus]),
            overlayTriggerRing(color),
        ]
    }

    private static func overlayTriggerRing<Tag: HTMLTagDefinition>(_ color: PinesColor) -> HTMLAttribute<Tag> {
        if color == .neutral { return .class(ring, variants: [.focus]) }
        return .ringColor(color.shade(.accent), variants: [.focus])
    }

    private static func overlayTriggerText<Tag: HTMLTagDefinition>(_ color: PinesColor) -> HTMLAttribute<Tag> {
        if color == .neutral { return .class(foreground) }
        return .textColor(color.shade(.bold))
    }
}
