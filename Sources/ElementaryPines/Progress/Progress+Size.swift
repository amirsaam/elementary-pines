/// Height variants for `pinesProgress(_:max:color:size:)`.
///
/// Each case maps to a Tailwind height class used for both the track and
/// the fill bar:
///
/// ```swift
/// pinesProgress(45)              // .md (default), h-2.5
/// pinesProgress(45, size: .sm)   // h-1.5
/// pinesProgress(45, size: .lg)   // h-4
/// ```
public enum PinesProgressSize: Sendable {
    /// 6px tall. h-1.5
    case sm
    /// 10px tall. h-2.5 (default)
    case md
    /// 16px tall. h-4
    case lg
}

extension PinesProgressSize {
    /// The Tailwind height class for both the track and the fill bar.
    var heightClass: String {
        switch self {
        case .sm: return "h-1.5"
        case .md: return "h-2.5"
        case .lg: return "h-4"
        }
    }
}
