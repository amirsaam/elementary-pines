import Elementary
import ElementaryTailwind

/// Severity variants for `pinesAlert`.
///
/// Each variant maps to a specific `PinesColor` (info→blue, success→green,
/// warning→yellow, danger→red) and applies a matching background and white
/// text to the alert container. Pass to
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
    /// The `PinesColor` that this variant renders in.
    public var color: PinesColor {
        switch self {
        case .info: return .blue
        case .success: return .green
        case .warning: return .yellow
        case .danger: return .red
        }
    }

    /// Typed HTML attributes appended to the alert's outer div for this variant.
    public var attributes: [HTMLAttribute<HTMLTag.div>] {
        [
            .borderColor(.transparent),
            .backgroundColor(backgroundColor),
            .textColor(.white),
        ]
    }

    private var backgroundColor: TWColor {
        switch self {
        case .success, .warning: color.shade(.base)
        case .info, .danger: color.shade(.strong)
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
