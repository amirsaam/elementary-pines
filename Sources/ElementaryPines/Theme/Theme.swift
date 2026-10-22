import Elementary
import ElementaryTailwind

/// Semantic theme tokens resolved by `setupPines()`. Use these roles for
/// component backgrounds, borders, text, hover states, and focus rings so
/// every component follows the theme's light/dark values and `accent:`.
///
/// Keep `PinesColor` shades for **accents** (buttons, badges, ratings, active
/// states) — those are literal palette classes and deliberately stay outside
/// the theme.
enum PinesTheme {
    static let background = "bg-background"
    static let foreground = "text-foreground"
    static let border = "border-border"
    static let borderForeground = "border-foreground"
    static let divider = "bg-border"
    static let muted = "bg-muted"
    static let mutedForeground = "text-muted-foreground"
    static let primary = "bg-primary"
    static let primaryBorder = "border-primary"
    static let primaryText = "text-primary"
    static let primaryForeground = "text-primary-foreground"
    static let ring = "ring-ring"

    static func utility(
        _ className: String,
        opacity: Int? = nil,
        variants: [TWVariant] = []
    ) -> String {
        let value = opacity.map { "\(className)/\($0)" } ?? className
        return TWVariant.apply(variants, to: value)
    }

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
