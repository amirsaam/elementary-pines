import ElementaryTailwind

extension PinesColor {
    /// Groups colors by how their shades shift in solid/outline button styles.
    enum Temperament { case cool, warm, gray, deep }

    var temperament: Temperament {
        switch self {
        case .blue, .green, .red, .indigo, .pink, .purple: .cool
        case .amber, .orange, .yellow: .warm
        case .gray: .gray
        case .neutral: .deep
        }
    }

    /// Shade triplet for the solid button style: (background, hover, focus ring).
    struct SolidScale {
        let bg: TWColor
        let hover: TWColor
        let ring: TWColor
    }

    /// Shade quintuplet for the tonal button style: (background, text, ring, hover background, hover text).
    struct TonalScale {
        let bg: TWColor
        let text: TWColor
        let ring: TWColor
        let hoverBg: TWColor
        let hoverText: TWColor
    }

    /// Shade triplet for the outline button style: (border, text, hover background).
    struct OutlineScale {
        let border: TWColor
        let text: TWColor
        let hoverBg: TWColor
    }

    var solidButtonScale: SolidScale {
        switch temperament {
        case .cool: SolidScale(bg: shade(.strong), hover: shade(.bold), ring: shade(.bold))
        case .warm: SolidScale(bg: shade(.base), hover: shade(.strong), ring: shade(.strong))
        case .gray: SolidScale(bg: shade(.bold), hover: shade(.deep), ring: shade(.deep))
        case .deep: SolidScale(bg: shade(.darkest), hover: shade(.dark), ring: shade(.dark))
        }
    }

    var tonalButtonScale: TonalScale {
        switch self {
        case .yellow:
            TonalScale(
                bg: shade(.tint1),
                text: shade(.strong),
                ring: shade(.tint2),
                hoverBg: shade(.tint2),
                hoverText: shade(.bold)
            )
        default:
            TonalScale(
                bg: shade(.tint1),
                text: shade(.base),
                ring: shade(.tint2),
                hoverBg: shade(.tint2),
                hoverText: shade(.strong)
            )
        }
    }

    var outlineButtonScale: OutlineScale {
        switch self {
        case .orange, .yellow: OutlineScale(border: shade(.base), text: shade(.strong), hoverBg: shade(.base))
        case .gray, .neutral: OutlineScale(border: shade(.dark), text: shade(.dark), hoverBg: shade(.dark))
        default: OutlineScale(border: shade(.strong), text: shade(.strong), hoverBg: shade(.strong))
        }
    }
}
