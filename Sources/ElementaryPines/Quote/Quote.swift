import Elementary

/// Renders a Pines-styled blockquote with an oversized decorative quote mark,
/// the quote text, and a footer with the author's avatar, name, and role.
///
/// The structure is a relative `<blockquote>` containing an
/// absolutely positioned gray-100 quote-mark SVG, the italic quote text in a
/// `relative z-10` wrapper, and a `<footer>` with a 10×10 rounded-full avatar
/// next to the author name (semibold) and role (muted, extra small).
///
/// Pass `avatar:` to include the author's avatar image; when `nil`, the
/// avatar column is omitted and the remaining markup is unchanged.
///
/// **Generated HTML:**
/// ```html
/// <blockquote class="relative w-full max-w-2xl mx-auto">
///     <svg class="absolute top-0 left-0 w-16 h-16 text-gray-100 transform -translate-x-6 -translate-y-8" width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path d="…" fill="currentColor"/></svg>
///     <div class="relative z-10">
///         <p class="text-gray-800 sm:text-xl"><em>Quote text</em></p>
///     </div>
///     <footer class="mt-6">
///         <div class="flex items-center">
///             <div class="flex-shrink-0">
///                 <img class="w-10 h-10 rounded-full" src="avatar.jpg" alt="Author Name">
///             </div>
///             <div class="ml-4">
///                 <div class="text-base font-semibold text-gray-800">Author Name</div>
///                 <div class="text-xs text-gray-500">Author Role</div>
///             </div>
///         </div>
///     </footer>
/// </blockquote>
/// ```
///
/// **Example:**
/// ```swift
/// pinesQuote(
///     quote: "Elementary Pines makes server-rendered HTML a joy.",
///     author: "Ada Lovelace",
///     role: "First Programmer",
///     avatar: "ada.jpg"
/// )
/// ```
public func pinesQuote(
    quote: String,
    author: String,
    role: String,
    avatar: String? = nil
) -> some HTML {
    blockquote(.class("relative w-full max-w-2xl mx-auto")) {
        pinesSpecialIcon(
            .quoteMark,
            attributes: [
                .class("absolute top-0 left-0")
            ]
        )
        div(.class("relative z-10")) {
            p(.class("text-gray-800 sm:text-xl")) {
                em { quote }
            }
        }
        footer(.class("mt-6")) {
            div(.class("flex items-center")) {
                if let avatar {
                    div(.class("flex-shrink-0")) {
                        img(.class("w-10 h-10 rounded-full"), .src(avatar), .alt(author))
                    }
                }
                div(.class("ml-4")) {
                    div(.class("text-base font-semibold text-gray-800")) { author }
                    div(.class("text-xs text-gray-500")) { role }
                }
            }
        }
    }
}
