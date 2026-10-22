import Elementary
import ElementaryTailwind

/// Severity variants for `pinesAlert`.
///
/// Each variant maps to a specific `PinesColor` (info→blue, success→green,
/// warning→yellow, danger→red) and applies a light tint in light mode and a
/// dark shade in dark mode. Pass to
/// `pinesAlert(_:icon:content:)`:
///
/// ```swift
/// pinesAlert(.info) {
///     h5(.class("mb-1 font-medium leading-none tracking-tight")) { "Heads up" }
///     p { "This is informational." }
/// }
/// ```
public enum PinesAlertVariant: Sendable {
    case info
    case success
    case warning
    case danger
    case basic
}

extension PinesAlertVariant {
    /// The `PinesColor` that this variant renders in.
    public var color: PinesColor {
        switch self {
        case .info: return .blue
        case .success: return .green
        case .warning: return .yellow
        case .danger: return .red
        case .basic: return .neutral
        }
    }

    /// Typed HTML attributes appended to the alert's outer div for this variant.
    public func attributes(customColor: PinesColor? = nil) -> [HTMLAttribute<HTMLTag.div>] {
        let resolvedColor = customColor ?? color
        if self == .basic && customColor == nil {
            return [
                .borderColor(.transparent),
                .class(PinesTheme.muted),
                .class(PinesTheme.foreground),
                .class(PinesTheme.muted, variants: [.dark]),
                .textColor(.white, variants: [.dark]),
            ]
        }
        return [
            .borderColor(.transparent),
            .backgroundColor(resolvedColor.shade(.tint1)),
            .textColor(resolvedColor.shade(.deep)),
            .backgroundColor(resolvedColor.shade(.darkest), variants: [.dark]),
            .textColor(.white, variants: [.dark]),
        ]
    }

    /// The default icon to auto-insert for this variant when
    /// `PinesAlertIcon.auto` is used.
    public var defaultIcon: PinesIconKind {
        switch self {
        case .info: return .info
        case .success: return .check
        case .warning: return .warning
        case .danger: return .x
        case .basic: return .info
        }
    }
}
