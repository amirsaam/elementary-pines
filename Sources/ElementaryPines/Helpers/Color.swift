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

// The `*Scale` tuples on `PinesColor` are the building blocks the per-style
// helpers in each element's `Style.swift` file use to assemble the final
// Tailwind class string. They are `internal` (not `public`) because they're
// implementation details of the package — end users always go through a
// `.pines<Element>Style(_:color:)` modifier.

// Shade conventions per color (intentionally not uniform — each palette gets
// a shade range that reads as a "default button" for that color):
//   - cool saturated colors (blue, red, green, indigo, pink, purple) → 600/700
//   - warm colors that wash out at 600 (amber, orange, yellow)         → 500/600
//   - gray (medium gray, more readable as a button)                     → 700/800
//   - neutral (Pines default — the very dark look)                      → 950/900

extension PinesColor {
    /// (background, hover background, focus ring) for the **solid** layout.
    /// Used by `PinesButtonStyle.solid`.
    internal var solidScale: (bg: String, hover: String, ring: String) {
        switch self {
        case .amber: ("bg-amber-600", "hover:bg-amber-700", "focus:ring-amber-700")
        case .blue: ("bg-blue-600", "hover:bg-blue-700", "focus:ring-blue-700")
        case .gray: ("bg-gray-700", "hover:bg-gray-800", "focus:ring-gray-800")
        case .green: ("bg-green-600", "hover:bg-green-700", "focus:ring-green-700")
        case .indigo: ("bg-indigo-600", "hover:bg-indigo-700", "focus:ring-indigo-700")
        case .neutral: ("bg-neutral-950", "hover:bg-neutral-900", "focus:ring-neutral-900")
        case .orange: ("bg-orange-500", "hover:bg-orange-600", "focus:ring-orange-600")
        case .pink: ("bg-pink-600", "hover:bg-pink-700", "focus:ring-pink-700")
        case .purple: ("bg-purple-600", "hover:bg-purple-700", "focus:ring-purple-700")
        case .red: ("bg-red-600", "hover:bg-red-700", "focus:ring-red-700")
        case .yellow: ("bg-yellow-500", "hover:bg-yellow-600", "focus:ring-yellow-600")
        }
    }

    /// (background, text, ring, hover background, hover text) for the **tonal** layout.
    /// Used by `PinesButtonStyle.tonal`.
    internal var tonalScale: (bg: String, text: String, ring: String, hoverBg: String, hoverText: String) {
        switch self {
        case .amber: ("bg-amber-50", "text-amber-500", "focus:ring-amber-100", "hover:bg-amber-100", "hover:text-amber-600")
        case .blue: ("bg-blue-50", "text-blue-500", "focus:ring-blue-100", "hover:bg-blue-100", "hover:text-blue-600")
        case .gray: ("bg-gray-50", "text-gray-500", "focus:ring-gray-100", "hover:bg-gray-100", "hover:text-gray-600")
        case .green: ("bg-green-50", "text-green-500", "focus:ring-green-100", "hover:bg-green-100", "hover:text-green-600")
        case .indigo: ("bg-indigo-50", "text-indigo-500", "focus:ring-indigo-100", "hover:bg-indigo-100", "hover:text-indigo-600")
        case .neutral: ("bg-neutral-50", "text-neutral-500", "focus:ring-neutral-100", "hover:bg-neutral-100", "hover:text-neutral-600")
        case .orange: ("bg-orange-50", "text-orange-500", "focus:ring-orange-100", "hover:bg-orange-100", "hover:text-orange-600")
        case .pink: ("bg-pink-50", "text-pink-500", "focus:ring-pink-100", "hover:bg-pink-100", "hover:text-pink-600")
        case .purple: ("bg-purple-50", "text-purple-500", "focus:ring-purple-100", "hover:bg-purple-100", "hover:text-purple-600")
        case .red: ("bg-red-50", "text-red-500", "focus:ring-red-100", "hover:bg-red-100", "hover:text-red-600")
        // yellow is one shade darker on text/hover (matches original Pines)
        case .yellow: ("bg-yellow-50", "text-yellow-600", "focus:ring-yellow-100", "hover:bg-yellow-100", "hover:text-yellow-700")
        }
    }

    /// (border shade, text shade, hover background shade) for the **outline** layout.
    /// Yellow uses text-600/border-500 (asymmetric — matches original Pines).
    /// Used by `PinesButtonStyle.outline`.
    internal var outlineScale: (border: String, text: String, hoverBg: String) {
        switch self {
        case .amber: ("amber-600", "amber-600", "amber-600")
        case .blue: ("blue-600", "blue-600", "blue-600")
        case .gray: ("gray-900", "gray-900", "gray-900")
        case .green: ("green-600", "green-600", "green-600")
        case .indigo: ("indigo-600", "indigo-600", "indigo-600")
        case .neutral: ("neutral-900", "neutral-900", "neutral-900")
        case .orange: ("orange-500", "orange-600", "orange-500")
        case .pink: ("pink-600", "pink-600", "pink-600")
        case .purple: ("purple-600", "purple-600", "purple-600")
        case .red: ("red-600", "red-600", "red-600")
        // yellow: text-600, border-500 (asymmetric in original Pines)
        case .yellow: ("yellow-500", "yellow-600", "yellow-500")
        }
    }
}
