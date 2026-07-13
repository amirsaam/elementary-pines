/// Layout variants for `pinesQuote(_:avatar:content:)`.
///
/// Each variant changes the outer structure of the figure. Pass to
/// `pinesQuote(_:avatar:content:)`:
///
/// ```swift
/// pinesQuote { /* user content */ }
/// pinesQuote(.withAvatar, avatar: "avatar.jpg") { /* user content */ }
/// ```
public enum PinesQuoteVariant: Sendable {
    /// Centered quote with no avatar. The user provides the
    /// `<blockquote>` and `<figcaption>` content directly.
    case basic
    /// Left-aligned quote with a small avatar image to the left of the
    /// content. Requires the `avatar:` parameter.
    case withAvatar
}

extension PinesQuoteVariant {
    /// Extra Tailwind utility classes appended to the figure for this
    /// variant. Empty for `.basic`.
    public var outerSuffix: String {
        switch self {
        case .basic: return " text-center max-w-2xl mx-auto"
        case .withAvatar: return " flex items-start gap-4 max-w-2xl"
        }
    }
}
