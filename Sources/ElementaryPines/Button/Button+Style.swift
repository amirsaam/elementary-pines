import Elementary
import ElementaryTailwind

/// Layout styles for a Pines-styled button. Combine with `PinesColor` to get
/// the full set of button variants from the original Pines library
/// (3 layouts × 11 colors = 33 variants).
///
/// Apply with `.pinesButtonStyle(_:color:)` on any `HTMLElement<HTMLTag.button>`:
/// ```swift
/// button { "Save" }.pinesButtonStyle(.solid, color: .blue)
/// button { "Cancel" }.pinesButtonStyle(.tonal)
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
    public func attributes(_ color: PinesColor?) -> [HTMLAttribute<HTMLTag.button>] {
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

    private func solidAttributes(color: PinesColor?) -> [HTMLAttribute<HTMLTag.button>] {
        guard let color else {
            return [
                .class(PinesTheme.primaryForeground),
                .transition(.colors), .transitionDuration(.ms(200)),
                .borderRadius(.md),
                .class(PinesTheme.primary),
                .class(PinesTheme.utility(PinesTheme.primary, opacity: 90, variants: [.hover])),
                .ringWidth(.size(2), variants: [.focus]),
                .ringOffsetWidth(.size(2), variants: [.focus]),
                .class(PinesTheme.ring, variants: [.focus]),
                .outlineStyle(.hidden, variants: [.focus]),
            ]
        }
        let scale = color.solidButtonScale
        let focusRing: HTMLAttribute<HTMLTag.button> =
            color == .neutral
            ? .class(PinesTheme.ring, variants: [.focus])
            : .ringColor(scale.ring, variants: [.focus])
        var attrs: [HTMLAttribute<HTMLTag.button>] = [
            .textColor(.white),
            .transition(.colors), .transitionDuration(.ms(200)),
            .borderRadius(.md),
            .backgroundColor(scale.bg),
            .backgroundColor(scale.hover, variants: [.hover]),
            .ringWidth(.size(2), variants: [.focus]),
            .ringOffsetWidth(.size(2), variants: [.focus]),
            focusRing,
            .outlineStyle(.hidden, variants: [.focus]),
        ]
        if color == .neutral {
            attrs += [
                .backgroundColor(PinesColor.neutral.shade(.tint1), variants: [.dark]),
                .textColor(PinesColor.neutral.shade(.darkest), variants: [.dark]),
                .backgroundColor(PinesColor.neutral.shade(.subtle), variants: [.dark, .hover]),
            ]
        }
        return attrs
    }

    private func tonalAttributes(color: PinesColor?) -> [HTMLAttribute<HTMLTag.button>] {
        guard let color else {
            return [
                .class(PinesTheme.primaryText),
                .transition(.colors), .transitionDuration(.ms(100)),
                .borderRadius(.md),
                .ringWidth(.size(2), variants: [.focus]),
                .ringOffsetWidth(.size(2), variants: [.focus]),
                .class(PinesTheme.ring, variants: [.focus]),
                .outlineStyle(.hidden, variants: [.focus]),
                .class(PinesTheme.utility(PinesTheme.primary, opacity: 10)),
                .class(PinesTheme.utility(PinesTheme.primary, opacity: 20, variants: [.hover])),
            ]
        }
        let scale = color.tonalButtonScale
        let focusRing: HTMLAttribute<HTMLTag.button> =
            color == .neutral
            ? .class(PinesTheme.ring, variants: [.focus])
            : .ringColor(scale.ring, variants: [.focus])
        return [
            .textColor(scale.text),
            .transition(.colors), .transitionDuration(.ms(100)),
            .borderRadius(.md),
            .ringWidth(.size(2), variants: [.focus]),
            .ringOffsetWidth(.size(2), variants: [.focus]),
            focusRing,
            .backgroundColor(scale.bg),
            .textColor(scale.hoverText, variants: [.hover]),
            .backgroundColor(scale.hoverBg, variants: [.hover]),
            .outlineStyle(.hidden, variants: [.focus]),
        ]
    }

    private func outlineAttributes(color: PinesColor?) -> [HTMLAttribute<HTMLTag.button>] {
        guard let color else {
            return [
                .class(PinesTheme.primaryText),
                .transition(.colors), .transitionDuration(.ms(100)),
                .borderRadius(.md),
                .class(PinesTheme.background),
                .borderWidth(.size(2)),
                .class(PinesTheme.primaryBorder),
                .class(PinesTheme.primary, variants: [.hover]),
                .class(PinesTheme.primaryForeground, variants: [.hover]),
                .outlineStyle(.hidden, variants: [.focus]),
            ]
        }
        let scale = color.outlineButtonScale
        return [
            .textColor(scale.text),
            .transition(.colors), .transitionDuration(.ms(100)),
            .borderRadius(.md),
            .class(PinesTheme.background),
            .borderWidth(.size(2)),
            .borderColor(scale.border),
            .textColor(.white, variants: [.hover]),
            .backgroundColor(scale.hoverBg, variants: [.hover]),
            .outlineStyle(.hidden, variants: [.focus]),
        ]
    }
}
