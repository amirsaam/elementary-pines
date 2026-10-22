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

}
