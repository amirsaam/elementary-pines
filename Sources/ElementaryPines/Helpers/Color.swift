import ElementaryTailwind

/// Tailwind color palette used across Pines components.
///
/// Shared by every `.pines<Element>Style(_:color:)` modifier that takes a
/// color argument (button, alert, badge, etc.). Matches the 11 color
/// palettes actually used in the original Pines source (`amber`, `blue`,
/// `gray`, `green`, `indigo`, `neutral`, `orange`, `pink`, `purple`,
/// `red`, `yellow`).
public enum PinesColor: String, Sendable, CaseIterable {
    case amber
    case blue
    case gray
    case green
    case indigo
    case neutral
    case orange
    case pink
    case purple
    case red
    case yellow
}

// MARK: - Shade

extension PinesColor {
    /// Named shade levels for consistent Tailwind color usage.
    public enum Shade: Int, Sendable {
        /// Shade value: 50
        case tint1 = 50
        /// Shade value: 100
        case tint2 = 100
        /// Shade value: 200
        case subtle = 200
        /// Shade value: 300
        case light = 300
        /// Shade value: 400
        case accent = 400
        /// Shade value: 500
        case base = 500
        /// Shade value: 600
        case strong = 600
        /// Shade value: 700
        case bold = 700
        /// Shade value: 800
        case deep = 800
        /// Shade value: 900
        case dark = 900
        /// Shade value: 950
        case darkest = 950
    }

    /// Returns a `TWColor` at the given shade level.
    public func shade(_ shade: Shade) -> TWColor { TWColor(rawValue, shade.rawValue) }

    /// Returns a `TWColor` at an arbitrary numeric shade (for one-off values
    /// with no named level, e.g. shade 200 in Rating).
    public func range(_ value: Int) -> TWColor { TWColor(rawValue, value) }
}

// MARK: - Color temperament

extension PinesColor {
    /// Groups colors by how their shades shift in solid/outline button styles.
    /// Cool colors use 600/700, warm colors shift one step lighter, gray and
    /// neutral use their own unique ranges.
    enum Temperament {
        case cool, warm, gray, deep
    }

    /// The shade-shift group for this color.
    var temperament: Temperament {
        switch self {
        case .blue, .green, .red, .indigo, .pink, .purple: .cool
        case .amber, .orange, .yellow: .warm
        case .gray: .gray
        case .neutral: .deep
        }
    }
}

// MARK: - Button style scales

extension PinesColor {
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

    /// Solid button shades grouped by color temperament.
    var solidButtonScale: SolidScale {
        switch temperament {
        case .cool: SolidScale(bg: shade(.strong), hover: shade(.bold), ring: shade(.bold))
        case .warm: SolidScale(bg: shade(.base), hover: shade(.strong), ring: shade(.strong))
        case .gray: SolidScale(bg: shade(.bold), hover: shade(.deep), ring: shade(.deep))
        case .deep: SolidScale(bg: shade(.darkest), hover: shade(.dark), ring: shade(.dark))
        }
    }

    /// Tonal button shades. Nearly uniform across all colors — yellow shifts
    /// text/hover one shade darker to match the original Pines source.
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

    /// Outline button shades. Most colors use 600; gray uses 900; orange/yellow
    /// use 500 for border/hover (asymmetric — matches original Pines).
    var outlineButtonScale: OutlineScale {
        switch self {
        case .orange, .yellow: OutlineScale(border: shade(.base), text: shade(.strong), hoverBg: shade(.base))
        case .gray: OutlineScale(border: shade(.dark), text: shade(.dark), hoverBg: shade(.dark))
        case .neutral: OutlineScale(border: shade(.dark), text: shade(.dark), hoverBg: shade(.dark))
        default: OutlineScale(border: shade(.strong), text: shade(.strong), hoverBg: shade(.strong))
        }
    }
}

// MARK: - Icon color shade

extension PinesColor {
    /// Returns the Tailwind shade number to use for `text-{color}-{shade}` on
    /// icons. Matches the original Pines UI heroicon defaults (green/blue → 600,
    /// yellow → 400, gray → 900, others → 500).
    var iconShade: Int {
        switch self {
        case .green, .blue: 600
        case .yellow: 400
        case .gray: 900
        default: 500
        }
    }
}

// MARK: - Range slider hex

extension PinesColor {
    internal var cssHex: String {
        switch self {
        case .amber: return "f59e0b"
        case .blue: return "4e97ff"
        case .gray: return "6b7280"
        case .green: return "22c55e"
        case .indigo: return "6366f1"
        case .neutral: return "737373"
        case .orange: return "f97316"
        case .pink: return "ec4899"
        case .purple: return "a855f7"
        case .red: return "ef4444"
        case .yellow: return "eab308"
        }
    }
}
