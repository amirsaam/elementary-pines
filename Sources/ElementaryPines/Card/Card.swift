import Elementary
import ElementaryTailwind

/// Wraps the given content in a Pines-styled card container.
///
/// The card provides the outer styling (border, rounded corners, background,
/// shadow) and nothing else — the user controls the entire interior
/// (image sections, body padding, content, etc.). This is a free function
/// rather than a modifier because the card's outer div isn't useful on its
/// own; it's a layout primitive that the user's content sits inside.
///
/// **Generated HTML:**
/// ```html
/// <div class="rounded-lg overflow-hidden border border-neutral-200/60 bg-white text-neutral-700 shadow-xs">
///     <!-- user content -->
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesCard {
///     div(.padding(.size(7))) {
///         h2 { "Product Name" }
///         p { "Description" }
///         button { "View" }
///     }
/// }
///
/// pinesCard(.image, image: "photo.jpg") {
///     h3 { "Title" }
///     p { "Body" }
/// }
///
/// pinesCard(.horizontal, image: "photo.jpg") {
///     h3 { "Title" }
///     p { "Body" }
/// }
///
/// pinesCard(.stat) {
///     p(.fontSize(.xxxl), .fontWeight(.bold)) { "1,234" }
///     p(.fontSize(.sm), .textColor(PinesColor.neutral.shade(.base))) { "Total users" }
/// }
/// ```
public func pinesCard<Content: HTML>(
    _ variant: PinesCardVariant = .basic,
    image: String? = nil,
    @ContentBuilder content: () -> Content
) -> some HTML {
    let outerAttributes: [HTMLAttribute<HTMLTag.div>] =
        [
            .borderRadius(.lg),
            .overflow(.hidden),
            .borderWidth(.bare),
            .borderColor(PinesColor.neutral.shade(.subtle), opacity: 60),
            .backgroundColor(.white),
            .textColor(PinesColor.neutral.shade(.bold)),
            .boxShadow(.xs),
        ] + variant.outerAttributes

    let imageURL: String? = {
        switch variant {
        case .image, .horizontal:
            guard let image else { fatalError("pinesCard(\(variant)) requires the image: parameter") }
            return image
        case .basic, .stat:
            return nil
        }
    }()

    return div(attributes: outerAttributes) {
        if variant == .image, let imageURL {
            img(.src(imageURL), .width(.full), .height(.auto))
            div(.padding(.size(7))) { content() }
        } else if variant == .horizontal, let imageURL {
            img(
                .src(imageURL),
                .objectFit(.cover),
                .width(.auto),
                .height(.size(48)),
                .aspect(.video)
            )
            div(.padding(.size(7)), .flex(.one)) { content() }
        } else {
            content()
        }
    }
}
