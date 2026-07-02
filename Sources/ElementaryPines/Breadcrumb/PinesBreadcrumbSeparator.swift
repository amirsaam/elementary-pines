/// Separator style for `pinesBreadcrumb(_:separator:)`.
///
/// Each case picks a single character drawn between items. The character is
/// rendered inside an `aria-hidden="true"` `<li>` so screen readers skip it.
///
/// ```swift
/// pinesBreadcrumb(items, separator: .slash)   // / / /
/// pinesBreadcrumb(items, separator: .chevron) // › › › (default)
/// pinesBreadcrumb(items, separator: .arrow)   // → → →
/// ```
public enum PinesBreadcrumbSeparator: Sendable {
    case slash
    case chevron
    case arrow
}

extension PinesBreadcrumbSeparator {
    /// The literal character used for this separator.
    public var character: String {
        switch self {
        case .slash: return "/"
        case .chevron: return "›"
        case .arrow: return "→"
        }
    }
}
