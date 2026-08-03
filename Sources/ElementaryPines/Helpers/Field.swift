import Elementary
import ElementaryTailwind

func pinesTextFieldAttributes<Tag: HTMLTagDefinition>(
    borderColor: TWColor,
    placeholderColor: TWColor,
    focusRingColor: TWColor,
    includeRingOffset: Bool = true
) -> [HTMLAttribute<Tag>] {
    var attributes: [HTMLAttribute<Tag>] = [
        .borderColor(borderColor)
    ]
    if includeRingOffset {
        attributes.append(.class("ring-offset-background"))
    }
    attributes += [
        .textColor(placeholderColor, variants: [.placeholder]),
        .borderColor(borderColor, variants: [.focus]),
        .outlineStyle(.hidden, variants: [.focus]),
        .ringWidth(.size(2), variants: [.focus]),
        .ringOffsetWidth(.size(2), variants: [.focus]),
        .ringColor(focusRingColor, variants: [.focus]),
        .opacity(.value(50), variants: [.disabled]),
        .cursor(.notAllowed, variants: [.disabled]),
    ]
    return attributes
}
