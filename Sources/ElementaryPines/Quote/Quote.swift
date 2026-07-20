import Elementary

/// Renders a Pines-styled blockquote with an oversized decorative quote mark,
/// the quote text, and a footer with the author's avatar, name, and role.
///
/// The structure and classes match the official Pines Quotes element
/// (`pines/elements/quotes.html`): a relative `<blockquote>` containing an
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
        SVG.svg(
            attributes: [
                .class("absolute top-0 left-0 w-16 h-16 text-gray-100 transform -translate-x-6 -translate-y-8"),
                SVGAttribute(name: "width", value: "16"),
                SVGAttribute(name: "height", value: "16"),
                SVGAttribute(name: "viewBox", value: "0 0 16 16"),
                SVGAttribute(name: "fill", value: "none"),
                SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
                SVGAttribute(name: "aria-hidden", value: "true"),
            ]
        ) {
            HTMLRaw(
                #"<path d="M7.39762 10.3C7.39762 11.0733 7.14888 11.7 6.6514 12.18C6.15392 12.6333 5.52552 12.86 4.76621 12.86C3.84979 12.86 3.09047 12.5533 2.48825 11.94C1.91222 11.3266 1.62421 10.4467 1.62421 9.29999C1.62421 8.07332 1.96459 6.87332 2.64535 5.69999C3.35231 4.49999 4.33418 3.55332 5.59098 2.85999L6.4943 4.25999C5.81354 4.73999 5.26369 5.27332 4.84476 5.85999C4.45201 6.44666 4.19017 7.12666 4.05926 7.89999C4.29491 7.79332 4.56983 7.73999 4.88403 7.73999C5.61716 7.73999 6.21938 7.97999 6.69067 8.45999C7.16197 8.93999 7.39762 9.55333 7.39762 10.3ZM14.6242 10.3C14.6242 11.0733 14.3755 11.7 13.878 12.18C13.3805 12.6333 12.7521 12.86 11.9928 12.86C11.0764 12.86 10.3171 12.5533 9.71484 11.94C9.13881 11.3266 8.85079 10.4467 8.85079 9.29999C8.85079 8.07332 9.19117 6.87332 9.87194 5.69999C10.5789 4.49999 11.5608 3.55332 12.8176 2.85999L13.7209 4.25999C13.0401 4.73999 12.4903 5.27332 12.0713 5.85999C11.6786 6.44666 11.4168 7.12666 11.2858 7.89999C11.5215 7.79332 11.7964 7.73999 12.1106 7.73999C12.8437 7.73999 13.446 7.97999 13.9173 8.45999C14.3886 8.93999 14.6242 9.55333 14.6242 10.3Z" fill="currentColor"/>"#
            )
        }
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
