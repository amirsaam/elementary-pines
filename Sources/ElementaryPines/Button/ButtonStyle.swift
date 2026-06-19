/// Layout styles for a Pines-styled button. Combine with `PinesColor` to get
/// the full set of 15 button variants from the original Pines library
/// (3 layouts × 5 colors).
///
/// Apply with `.pinesButtonStyle(_:color:)` on any `HTMLElement<HTMLTag.button>`:
/// ```swift
/// button { "Save" }.pinesButtonStyle(.solid, color: .blue)
/// button { "Cancel" }.pinesButtonStyle(.tonal, color: .neutral)
/// button { "Delete" }.pinesButtonStyle(.outline, color: .red)
/// ```
public enum PinesButtonStyle: String, Sendable, CaseIterable {
    /// Filled background with white text. From `pines/elements/button-examples/example-01.html`.
    case solid
    /// Tinted background with matching colored text. From `pines/elements/button-examples/example-02.html`.
    case tonal
    /// White background with colored border, fills with color on hover. From `pines/elements/button-examples/example-03.html`.
    case outline
}

extension PinesButtonStyle {
    /// The Tailwind utility classes for this style + color combination.
    /// Faithful to the original Pines examples — class *order* matches the
    /// source HTML for easy diffing in snapshot tests.
    public func classes(_ color: PinesColor) -> String {
        let base = "inline-flex items-center justify-center px-4 py-2 text-sm font-medium tracking-wide"
        switch self {
        case .solid: return Self.solidClasses(base: base, color: color)
        case .tonal: return Self.tonalClasses(base: base, color: color)
        case .outline: return Self.outlineClasses(base: base, color: color)
        }
    }

    private static func solidClasses(base: String, color: PinesColor) -> String {
        let scale = color.solidScale
        return """
            \(base) text-white transition-colors duration-200 rounded-md \
            \(scale.bg) \(scale.hover) focus:ring-2 focus:ring-offset-2 \(scale.ring) \
            focus:shadow-outline focus:outline-none
            """
    }

    private static func tonalClasses(base: String, color: PinesColor) -> String {
        let scale = color.tonalScale
        return """
            \(base) \(scale.text) transition-colors duration-100 rounded-md \
            focus:ring-2 focus:ring-offset-2 \(scale.ring) \(scale.bg) \
            \(scale.hoverText) \(scale.hoverBg)
            """
    }

    private static func outlineClasses(base: String, color: PinesColor) -> String {
        let scale = color.outlineScale
        return """
            \(base) text-\(scale.text) transition-colors duration-100 \
            bg-white border-2 rounded-md border-\(scale.border) \
            hover:text-white hover:bg-\(scale.hoverBg)
            """
    }
}
