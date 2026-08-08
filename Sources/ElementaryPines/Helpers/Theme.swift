import Elementary
import ElementaryTailwind

/// Semantic theme tokens resolved by `setupPines()`. Use these for component
/// **surfaces** (backgrounds, borders, body text, hover washes, focus rings)
/// so every component follows the theme's light/dark surfaces and `accent:`.
///
/// Keep `PinesColor` shades for **accents** (buttons, badges, ratings, active
/// states) — those are literal palette classes and deliberately stay outside
/// the theme.
enum PinesSurface {
    static let background = "bg-background"
    static let foreground = "text-foreground"
    static let border = "border-border"
    static let borderSubtle = "border-border/70"
    static let borderSubtle60 = "border-border/60"
    static let borderSubtle80 = "border-border/80"
    static let muted = "bg-muted"
    static let mutedForeground = "text-muted-foreground"
    static let ring = "ring-ring"

    /// The class for an accent-tinted hover wash: the theme `muted` surface
    /// for `.neutral` (dark-adaptive), or the color's `tint2` (`bg-blue-100`)
    /// for real accents.
    static func accentHoverClass(_ color: PinesColor) -> String {
        if color == .neutral { return muted }
        return twValue(.backgroundColor(color.shade(.tint2)))
    }

    /// The attribute for an accent-tinted hover wash (see `accentHoverClass`).
    static func accentHover<Tag: HTMLTagDefinition>(_ color: PinesColor, variants: [TWVariant] = []) -> HTMLAttribute<Tag> {
        if color == .neutral { return .class(muted, variants: variants) }
        return .backgroundColor(color.shade(.tint2), variants: variants)
    }
}
