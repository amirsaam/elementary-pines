import Elementary

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
/// <div class="rounded-lg overflow-hidden border border-neutral-200/60 bg-white text-neutral-700 shadow-sm">
///     <!-- user content -->
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesCard {
///     div(.class("p-7")) {
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
///     p(.class("text-3xl font-bold")) { "1,234" }
///     p(.class("text-sm text-neutral-500")) { "Total users" }
/// }
/// ```
public func pinesCard<Content: HTML>(
    _ variant: PinesCardVariant = .basic,
    image: String? = nil,
    @ContentBuilder content: () -> Content
) -> some HTML {
    let base = "rounded-lg overflow-hidden border border-neutral-200/60 bg-white text-neutral-700 shadow-sm"
    let outer = base + variant.outerSuffix

    // Resolve the image URL outside the ContentBuilder so the guard can run
    // before the builder closure starts.
    let imageURL: String? = {
        switch variant {
        case .image, .horizontal:
            guard let image else { fatalError("pinesCard(\(variant)) requires the image: parameter") }
            return image
        case .basic, .stat:
            return nil
        }
    }()

    return div(.class(outer)) {
        if variant == .image, let imageURL {
            img(.src(imageURL), .class("w-full h-auto"))
            div(.class("p-7")) { content() }
        } else if variant == .horizontal, let imageURL {
            img(.src(imageURL), .class("w-full md:w-48 h-auto"))
            div(.class("p-7 flex-1")) { content() }
        } else {
            content()
        }
    }
}
