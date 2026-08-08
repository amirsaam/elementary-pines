import Elementary
import ElementaryTailwind

func pinesTextFieldAttributes<Tag: HTMLTagDefinition>(
    borderColor: TWColor,
    placeholderColor: TWColor,
    focusRingColor: TWColor,
    includeRingOffset: Bool = true,
    surface: Bool = false
) -> [HTMLAttribute<Tag>] {
    var attributes: [HTMLAttribute<Tag>] = []
    if surface {
        attributes.append(.class(PinesSurface.border))
    } else {
        attributes.append(.borderColor(borderColor))
    }
    if includeRingOffset {
        attributes.append(.class("ring-offset-background"))
    }
    if surface {
        attributes += [
            .class(PinesSurface.mutedForeground, variants: [.placeholder]),
            .class(PinesSurface.border, variants: [.focus]),
            .outlineStyle(.hidden, variants: [.focus]),
            .ringWidth(.size(2), variants: [.focus]),
            .ringOffsetWidth(.size(2), variants: [.focus]),
            .class(PinesSurface.ring, variants: [.focus]),
        ]
    } else {
        attributes += [
            .textColor(placeholderColor, variants: [.placeholder]),
            .borderColor(borderColor, variants: [.focus]),
            .outlineStyle(.hidden, variants: [.focus]),
            .ringWidth(.size(2), variants: [.focus]),
            .ringOffsetWidth(.size(2), variants: [.focus]),
            .ringColor(focusRingColor, variants: [.focus]),
        ]
    }
    attributes += [
        .opacity(.value(50), variants: [.disabled]),
        .cursor(.notAllowed, variants: [.disabled]),
    ]
    return attributes
}
