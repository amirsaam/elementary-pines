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
    /// The Tailwind width/height class string for this size.
    public var classes: String {
        switch self {
        case .xs: "w-3 h-3"
        case .sm: "w-4 h-4"
        case .md: "w-5 h-5"
        case .lg: "w-6 h-6"
        case .xl: "w-8 h-8"
        }
    }
}
