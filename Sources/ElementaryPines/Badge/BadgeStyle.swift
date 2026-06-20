/// Visual styles for a Pines-styled badge. Combine with `PinesColor` to get
/// the full set of variants from the original Pines library.
///
/// Apply with `.pinesBadgeStyle(_:color:)` on any `HTMLElement<HTMLTag.span>`:
/// ```swift
/// span { "New" }.pinesBadgeStyle(.light, color: .blue)
/// span { "Active" }.pinesBadgeStyle(.solid)
/// span { "● Online" }.pinesBadgeStyle(.dot, color: .green)  // user adds the dot element
/// ```
public enum PinesBadgeStyle: String, Sendable, CaseIterable {
    /// Dark background with white text. From `pines/elements/badge.html`.
    case solid
    /// Light background with dark text. From `pines/elements/badge-examples/example-01.html`.
    case light
    /// Transparent background with colored text and border. From `pines/elements/badge-examples/example-02.html`.
    case outline
    /// Outline with a colored dot before the text (user must add the dot element).
    /// From `pines/elements/badge-examples/example-03.html`.
    case dot
    /// Dark background with white text and an icon slot (user must add the icon element).
    /// From `pines/elements/badge-examples/example-04.html`.
    case icon
}

extension PinesBadgeStyle {
    /// The Tailwind utility classes for this style + color combination.
    public func classes(_ color: PinesColor) -> String {
        let shared = "text-xs font-semibold rounded-full"
        switch self {
        case .solid: return Self.solidClasses(shared: shared, color: color)
        case .light: return Self.lightClasses(shared: shared, color: color)
        case .outline: return Self.outlineClasses(shared: shared, color: color)
        case .dot: return Self.dotClasses(shared: shared, color: color)
        case .icon: return Self.iconClasses(shared: shared, color: color)
        }
    }

    // MARK: - Per-style helpers

    private static func solidClasses(shared: String, color: PinesColor) -> String {
        let bg: String
        switch color {
        case .neutral: bg = "bg-black"
        default: bg = "bg-\(color.rawValue)-600"
        }
        return "\(shared) px-2.5 py-0.5 \(bg) text-white"
    }

    private static func lightClasses(shared: String, color: PinesColor) -> String {
        let c = color.rawValue
        return "\(shared) px-2.5 py-0.5 bg-\(c)-100 text-\(c)-800"
    }

    private static func outlineClasses(shared: String, color: PinesColor) -> String {
        let c = color.rawValue
        return "\(shared) px-2.5 py-0.5 bg-transparent text-\(c)-500 border border-\(c)-500"
    }

    private static func dotClasses(shared: String, color: PinesColor) -> String {
        let c = color.rawValue
        return """
            \(shared) px-2.5 py-0.5 bg-transparent text-\(c)-500 \
            border border-neutral-300 flex items-center
            """
    }

    private static func iconClasses(shared: String, color: PinesColor) -> String {
        let bg: String
        switch color {
        case .neutral: bg = "bg-black"
        default: bg = "bg-\(color.rawValue)-600"
        }
        return "\(shared) pl-2 pr-2.5 py-1 \(bg) text-white relative flex items-center"
    }
}
