import Elementary
import ElementaryTailwind

/// Layout styles for a Pines-styled button. Combine with `PinesColor` to get
/// the full set of button variants from the original Pines library
/// (3 layouts × 11 colors = 33 variants).
///
/// Apply with `.pinesButtonStyle(_:color:)` on any `HTMLElement<HTMLTag.button>`:
/// ```swift
/// button { "Save" }.pinesButtonStyle(.solid, color: .blue)
/// button { "Cancel" }.pinesButtonStyle(.tonal, color: .neutral)
/// button { "Delete" }.pinesButtonStyle(.outline, color: .red)
/// ```
public enum PinesButtonStyle: String, Sendable, CaseIterable {
    /// Filled background with white text. From `pines/elements/button-examples/example-01.html`.
    case solid
    /// Tinted background with matching colored text. From `pines/elements/button-examples/example-02.html`.
    case tonal
    /// White background with colored border, fills with color on hover. From `pines/elements/button-examples/example-03.html`.
    case outline
}

extension PinesButtonStyle {
    /// Typed HTML attributes for this style + color combination.
    public func attributes(_ color: PinesColor) -> [HTMLAttribute<HTMLTag.button>] {
        var attrs: [HTMLAttribute<HTMLTag.button>] = [
            .display(.inlineFlex), .items(.center), .justify(.center),
            .paddingX(.size(4)), .paddingY(.size(2)),
            .fontSize(.sm), .fontWeight(.medium), .letterSpacing(.wide),
        ]
        switch self {
        case .solid: attrs.append(contentsOf: solidAttributes(color: color))
        case .tonal: attrs.append(contentsOf: tonalAttributes(color: color))
        case .outline: attrs.append(contentsOf: outlineAttributes(color: color))
        }
        return attrs
    }

    // MARK: - Per-style helpers

    private func solidAttributes(color: PinesColor) -> [HTMLAttribute<HTMLTag.button>] {
        let scale = color.solidButtonScale
        return [
            .textColor(.white),
            .transition(.colors), .transitionDuration(.ms(200)),
            .borderRadius(.md),
            .backgroundColor(scale.bg),
            .backgroundColor(scale.hover, variants: [.hover]),
            .ringWidth(.size(2), variants: [.focus]),
            .ringOffsetWidth(.size(2), variants: [.focus]),
            .ringColor(scale.ring, variants: [.focus]),
            .class("shadow-outline", variants: [.focus]),
            .outlineStyle(.hidden, variants: [.focus]),
        ]
    }

    private func tonalAttributes(color: PinesColor) -> [HTMLAttribute<HTMLTag.button>] {
        let scale = color.tonalButtonScale
        return [
            .textColor(scale.text),
            .transition(.colors), .transitionDuration(.ms(100)),
            .borderRadius(.md),
            .ringWidth(.size(2), variants: [.focus]),
            .ringOffsetWidth(.size(2), variants: [.focus]),
            .ringColor(scale.ring, variants: [.focus]),
            .backgroundColor(scale.bg),
            .textColor(scale.hoverText, variants: [.hover]),
            .backgroundColor(scale.hoverBg, variants: [.hover]),
        ]
    }

    private func outlineAttributes(color: PinesColor) -> [HTMLAttribute<HTMLTag.button>] {
        let scale = color.outlineButtonScale
        return [
            .textColor(scale.text),
            .transition(.colors), .transitionDuration(.ms(100)),
            .borderRadius(.md),
            .backgroundColor(.white),
            .borderWidth(.size(2)),
            .borderColor(scale.border),
            .textColor(.white, variants: [.hover]),
            .backgroundColor(scale.hoverBg, variants: [.hover]),
        ]
    }
}
