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

// MARK: - Range slider CSS variables

extension PinesColor {
    /// Tailwind CSS variables for every shade supported by `PinesColor`.
    internal var cssValues: [Int: String] {
        Dictionary(
            uniqueKeysWithValues: Shade.allCases.map { shade in
                (shade.rawValue, "var(--color-\(rawValue)-\(shade.rawValue))")
            }
        )
    }
}
