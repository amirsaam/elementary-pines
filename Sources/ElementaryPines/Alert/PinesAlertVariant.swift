/// Severity variants for `pinesAlert`.
///
/// Each variant applies a colored border, text, and icon color to the alert
/// container. Pass to `pinesAlert(_:icon:content:)`:
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
    /// Extra Tailwind utility classes appended to the alert's outer div for
    /// this variant. Must be appended *after* the base classes so the
    /// `[&>svg]:text-{color}-500` overrides `[&>svg]:text-foreground` per
    /// Tailwind's later-class-wins specificity rule.
    public var classesSuffix: String {
        switch self {
        case .info: return " border-blue-500 text-blue-700 [&>svg]:text-blue-500"
        case .success: return " border-green-500 text-green-700 [&>svg]:text-green-500"
        case .warning: return " border-yellow-500 text-yellow-700 [&>svg]:text-yellow-500"
        case .danger: return " border-red-500 text-red-700 [&>svg]:text-red-500"
        }
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
