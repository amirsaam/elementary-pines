import Elementary
import ElementaryTailwind

/// Layout variants for `pinesCard`.
///
/// Each variant changes the card's outer structure and inner layout.
/// Pass to `pinesCard(_:image:content:)`:
///
/// ```swift
/// pinesCard(.image, image: "photo.jpg") {
///     h3 { "Title" }
///     p { "Body" }
/// }
/// ```
public enum PinesCardVariant: Sendable {
    /// Plain card — user provides all content. The default.
    case basic
    /// Card with a full-width image at the top, body wrapped in a padded div.
    /// Requires the `image:` parameter.
    case image
    /// Card with image on the left and body on the right (md+).
    /// Requires the `image:` parameter.
    case horizontal
    /// Centered stat card with internal padding. For value + label layouts.
    case stat
}

extension PinesCardVariant {
    /// Extra typed attributes appended to the card's outer div for this variant.
    public var outerAttributes: [HTMLAttribute<HTMLTag.div>] {
        switch self {
        case .basic, .image: return []
        case .horizontal:
            return [
                .display(.flex),
                .flexDirection(.column),
                .flexDirection(.row, variants: [.md]),
            ]
        case .stat: return [.textAlign(.center), .padding(.size(7))]
        }
    }
}
