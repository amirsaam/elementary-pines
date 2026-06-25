/// Severity variants for `pinesAlert`.
///
/// Each variant maps to a specific `PinesColor` (info→blue, success→green,
/// warning→yellow, danger→red) and applies a matching colored border, text,
/// and icon color to the alert container. Pass to
/// `pinesAlert(_:icon:content:)`:
///
/// ```swift
/// pinesAlert(.info) {
///     h5 { "Heads up" }
///     p { "This is informational." }
/// }
/// ```
public enum PinesAlertVariant: Sendable {
    case info
    case success
    case warning
    case danger
}

extension PinesAlertVariant {
    /// The `PinesColor` that this variant renders in. Used as the source for
    /// the class-name template below so we never hardcode a color name.
    public var color: PinesColor {
        switch self {
        case .info: return .blue
        case .success: return .green
        case .warning: return .yellow
        case .danger: return .red
        }
    }

    /// Extra Tailwind utility classes appended to the alert's outer div for
    /// this variant. Must be appended *after* the base classes so the
    /// `[&>svg]:text-{color}-500` overrides `[&>svg]:text-foreground` per
    /// Tailwind's later-class-wins specificity rule.
    public var classesSuffix: String {
        let c = color.rawValue
        return " border-\(c)-500 text-\(c)-700 [&>svg]:text-\(c)-500"
    }

    /// The default icon to auto-insert for this variant when
    /// `PinesAlertIcon.auto` is used.
    public var defaultIcon: PinesIconKind {
        switch self {
        case .info: return .info
        case .success: return .check
        case .warning: return .warning
        case .danger: return .x
        }
    }
}
