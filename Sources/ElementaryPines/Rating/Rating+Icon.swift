/// The icon shape for the rating component.
public enum PinesRatingIcon: Sendable {
    /// Five-pointed star (default).
    case star
    /// Heart shape.
    case heart

    /// The underlying ``PinesIconKind`` for this rating icon.
    public var kind: PinesIconKind {
        switch self {
        case .star: .star
        case .heart: .heart
        }
    }
}
