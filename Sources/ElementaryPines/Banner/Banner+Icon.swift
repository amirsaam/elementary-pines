/// Icon source for `pinesBanner(label:message:href:icon:dismissible:position:)`.
///
/// The banner renders an optional leading icon to the left of the label:
///
/// ```swift
/// pinesBanner(label: "New Feature", message: "...", href: "#")                            // default wand
/// pinesBanner(label: "New Feature", message: "...", href: "#", icon: .kind(.info))        // built-in Heroicon
/// pinesBanner(label: "New Feature", message: "...", href: "#", icon: .custom(path: "/icons/my.svg"))
/// pinesBanner(label: "New Feature", message: "...", href: "#", icon: nil)                 // no icon
/// ```
///
/// `.wand` (the default) inlines a magic-wand SVG.
/// `.kind(_)` uses one of the built-in `PinesIconKind`
/// cases rendered at `.sm` size with an `mr-1` spacer. `.custom(_)` renders a
/// user-provided SVG file via `<img src="path" class="w-4 h-4 mr-1">`.
public enum PinesBannerIcon: Sendable {
    /// The magic-wand SVG (the default).
    case wand
    /// Render a built-in `PinesIconKind` icon at `.sm` size.
    case kind(PinesIconKind)
    /// Render a user-provided SVG file via `<img src="path" class="w-4 h-4 mr-1">`.
    case custom(path: String)
}
