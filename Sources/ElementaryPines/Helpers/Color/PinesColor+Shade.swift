import ElementaryTailwind

extension PinesColor {
    /// Named shade levels for consistent Tailwind color usage.
    public enum Shade: Int, Sendable, CaseIterable {
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
