import ElementaryTailwind

/// Height variants for `pinesProgress(_:of:color:size:)`.
///
/// - `.md` (default) is the base progress bar height (`h-3`).
/// - `.sm` and `.lg` are package extensions.
///
/// ```swift
/// pinesProgress()                   // .md, h-3
/// pinesProgress(45, size: .sm)      // h-1.5
/// pinesProgress(45, size: .lg)      // h-4
/// ```
public enum PinesProgressSize: Sendable {
    /// 6px tall. h-1.5
    case sm
    /// 12px tall. h-3
    case md
    /// 16px tall. h-4
    case lg
}

extension PinesProgressSize {
    /// The Tailwind height token for this size.
    var heightToken: TWTHeight {
        switch self {
        case .sm: .size(1.5)
        case .md: .size(3)
        case .lg: .size(4)
        }
    }
}
