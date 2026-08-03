import ElementaryTailwind

/// Predefined icon sizes. The class strings are Tailwind width/height pairs
/// that match what Pines itself uses across its components.
public enum PinesIconSize: String, Sendable, CaseIterable {
    case xs
    case sm
    case md
    case lg
    case xl
}

extension PinesIconSize {
    /// The Tailwind width token for this size.
    public var widthToken: TWTWidth {
        switch self {
        case .xs: .size(3)
        case .sm: .size(4)
        case .md: .size(5)
        case .lg: .size(6)
        case .xl: .size(8)
        }
    }

    /// The Tailwind height token for this size.
    public var heightToken: TWTHeight {
        switch self {
        case .xs: .size(3)
        case .sm: .size(4)
        case .md: .size(5)
        case .lg: .size(6)
        case .xl: .size(8)
        }
    }

    /// The Tailwind width/height class string for this size.
    public var classes: String {
        twValue(.width(widthToken), .height(heightToken))
    }
}
