import Elementary
import ElementaryTailwind

/// Visual styles for a Pines-styled badge. Combine with `PinesColor` to get
/// the full set of variants from the original Pines library.
///
/// Apply with `.pinesBadgeStyle(_:color:)` on any `HTMLElement<HTMLTag.span>`:
/// ```swift
/// span { "New" }.pinesBadgeStyle(.light, color: .blue)
/// span { "Active" }.pinesBadgeStyle(.solid)
/// span { "● Online" }.pinesBadgeStyle(.dot, color: .green)  // user adds the dot element
/// ```
public enum PinesBadgeStyle: String, Sendable, CaseIterable {
    /// Dark background with white text. From `pines/elements/badge.html`.
    case solid
    /// Light background with dark text. From `pines/elements/badge-examples/example-01.html`.
    case light
    /// Transparent background with colored text and border. From `pines/elements/badge-examples/example-02.html`.
    case outline
    /// Outline with a colored dot before the text (user must add the dot element).
    /// From `pines/elements/badge-examples/example-03.html`.
    case dot
    /// Dark background with white text and an icon slot (user must add the icon element).
    /// From `pines/elements/badge-examples/example-04.html`.
    case icon
}

extension PinesBadgeStyle {
    /// Typed HTML attributes for this style + color combination.
    public func attributes(_ color: PinesColor) -> [HTMLAttribute<HTMLTag.span>] {
        var attrs: [HTMLAttribute<HTMLTag.span>] = [
            .fontSize(.xs), .fontWeight(.semibold), .borderRadius(.full),
        ]
        if self != .icon {
            attrs.append(.paddingX(.size(2.5)))
            attrs.append(.paddingY(.size(0.5)))
        }
        switch self {
        case .solid: attrs.append(contentsOf: solidAttributes(color: color))
        case .light: attrs.append(contentsOf: lightAttributes(color: color))
        case .outline: attrs.append(contentsOf: outlineAttributes(color: color))
        case .dot: attrs.append(contentsOf: dotAttributes(color: color))
        case .icon: attrs.append(contentsOf: iconAttributes(color: color))
        }
        return attrs
    }

    // MARK: - Per-style helpers

    private func solidAttributes(color: PinesColor) -> [HTMLAttribute<HTMLTag.span>] {
        let bg: HTMLAttribute<HTMLTag.span>
        switch color {
        case .neutral: bg = .backgroundColor(.black)
        default: bg = .backgroundColor(color.shade(.strong))
        }
        return [bg, .textColor(.white)]
    }

    private func lightAttributes(color: PinesColor) -> [HTMLAttribute<HTMLTag.span>] {
        [
            .backgroundColor(color.shade(.tint2)),
            .textColor(color.shade(.deep)),
        ]
    }

    private func outlineAttributes(color: PinesColor) -> [HTMLAttribute<HTMLTag.span>] {
        [
            .backgroundColor(.transparent),
            .textColor(color.shade(.base)),
            .borderWidth(.bare),
            .borderColor(color.shade(.base)),
        ]
    }

    private func dotAttributes(color: PinesColor) -> [HTMLAttribute<HTMLTag.span>] {
        [
            .backgroundColor(.transparent),
            .textColor(color.shade(.base)),
            .borderWidth(.bare),
            .borderColor(PinesColor.neutral.shade(.light)),
            .display(.flex), .items(.center),
        ]
    }

    private func iconAttributes(color: PinesColor) -> [HTMLAttribute<HTMLTag.span>] {
        let bg: HTMLAttribute<HTMLTag.span>
        switch color {
        case .neutral: bg = .backgroundColor(.black)
        default: bg = .backgroundColor(color.shade(.strong))
        }
        return [
            bg, .textColor(.white),
            .paddingLeft(.size(2)), .paddingRight(.size(2.5)), .paddingY(.size(1)),
            .position(.relative), .display(.flex), .items(.center),
        ]
    }
}
