import Elementary

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
    static let muted = "bg-muted"
    static let mutedForeground = "text-muted-foreground"
    static let ring = "ring-ring"
}
