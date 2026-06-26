import Elementary

/// Wraps the given content in a Pines-styled `<figure>` for a blockquote.
///
/// The function provides the outer `<figure>` with layout classes and
/// (for `.withAvatar`) prepends the avatar image, then wraps the user's
/// content. The user provides the `<blockquote>` and `<figcaption>` (and
/// any inner markup) themselves — same modifier-approach used by
/// `pinesCard` and `pinesAlert`.
///
/// **Generated HTML (`.basic`):**
/// ```html
/// <figure class="text-center max-w-2xl mx-auto">
///     <!-- user content -->
/// </figure>
/// ```
///
/// **Generated HTML (`.withAvatar`):**
/// ```html
/// <figure class="flex items-start gap-4 max-w-2xl">
///     <img src="avatar.jpg" class="w-12 h-12 rounded-full flex-shrink-0">
///     <div class="flex-1">
///         <!-- user content -->
///     </div>
/// </figure>
/// ```
///
/// **Example:**
/// ```swift
/// pinesQuote {
///     blockquote {
///         p { "\u{201C}This is a great quote.\u{201D}" }
///     }
///     figcaption { "\u{2014} Author Name, Role" }
/// }
///
/// pinesQuote(.withAvatar, avatar: "avatar.jpg") {
///     blockquote {
///         p { "\u{201C}This is a great quote.\u{201D}" }
///     }
///     figcaption {
///         span(.class("font-semibold")) { "Author Name" }
///         ", Role"
///     }
/// }
/// ```
public func pinesQuote<Content: HTML>(
    _ variant: PinesQuoteVariant = .basic,
    avatar: String? = nil,
    @HTMLBuilder content: () -> Content
) -> some HTML {
    let base = "text-neutral-700"
    let outer = base + variant.outerSuffix

    // Resolve the avatar URL outside the HTMLBuilder so the guard can run
    // before the builder closure starts.
    let avatarURL: String? = {
        switch variant {
        case .withAvatar:
            guard let avatar else { fatalError("pinesQuote(.withAvatar) requires the avatar: parameter") }
            return avatar
        case .basic:
            return nil
        }
    }()

    return figure(.class(outer)) {
        if variant == .withAvatar, let avatarURL {
            img(.src(avatarURL), .class("w-12 h-12 rounded-full flex-shrink-0"))
            div(.class("flex-1")) { content() }
        } else {
            content()
        }
    }
}
