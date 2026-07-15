import Elementary

/// Renders a notice/announcement bar as an `<aside>` with three optional
/// slots: a leading icon, a content area (user-provided), and a trailing
/// dismiss button. Matches the Pines UI notification bar style.
///
/// Layout:
/// ```html
/// <aside class="bg-white shadow-sm h-10">
///     <div class="flex items-center justify-between h-full px-3 mx-auto max-w-7xl">
///         <div class="flex items-center gap-2 min-w-0">
///             <!-- icon (if `icon:` is set) -->
///             <!-- user content -->
///         </div>
///         <!-- dismiss button (if `dismissible: true`) -->
///     </div>
/// </aside>
/// ```
///
/// **Example:**
/// ```swift
/// pinesBanner(icon: .kind(.info)) {
///     p { "New version available." }
/// }
///
/// pinesBanner(icon: .custom("/icons/spinner.svg")) {
///     p { "Loading..." }
/// }
///
/// pinesBanner(icon: .kind(.warning), dismissible: true) {
///     p { "Your session is about to expire." }
/// }
/// ```
///
/// - Parameters:
///   - icon: An optional icon source (built-in or user-provided SVG).
///   - dismissible: When `true`, a close button (`pinesIcon(.x)`) is
///     rendered to the right of the content.
///   - content: The body of the banner, typically `<p>` text content.
public func pinesBanner<Content: HTML>(
    icon: PinesBannerIcon? = nil,
    dismissible: Bool = false,
    @HTMLBuilder content: () -> Content
) -> some HTML {
    aside(.class("bg-white shadow-sm h-10")) {
        div(.class("flex items-center justify-between h-full px-3 mx-auto max-w-7xl")) {
            div(.class("flex items-center gap-2 min-w-0")) {
                if let icon {
                    switch icon {
                    case .kind(let kind):
                        pinesIcon(kind, size: .sm)
                    case .custom(let path):
                        img(.src(path), .class("w-4 h-4"))
                    }
                }
                div(.class("text-xs truncate")) {
                    content()
                }
            }
            if dismissible {
                button(
                    .type(.button),
                    .class("flex-shrink-0 text-neutral-400 hover:text-neutral-600"),
                    HTMLAttribute(name: "aria-label", value: "Dismiss")
                ) {
                    pinesIcon(.x, size: .sm)
                }
            }
        }
    }
}
