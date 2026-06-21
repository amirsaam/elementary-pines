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
///     div(.class("relative")) {
///         img(.src("photo.jpg"), .class("w-full h-auto"))
///     }
///     div(.class("p-7")) {
///         h2 { "Product Name" }
///         p { "Description" }
///         button { "View" }
///     }
/// }
/// ```
public func pinesCard<Content: HTML>(
    @HTMLBuilder content: () -> Content
) -> some HTML {
    div(.class("rounded-lg overflow-hidden border border-neutral-200/60 bg-white text-neutral-700 shadow-sm")) {
        content()
    }
}
