/// Icon source for `pinesBanner(icon:dismissible:content:)`.
///
/// The banner accepts a single optional icon slot to the left of the content:
///
/// ```swift
/// pinesBanner(icon: .kind(.info))                  // built-in Heroicon
/// pinesBanner(icon: .custom("/icons/my.svg"))      // user-provided SVG file
/// ```
///
/// `.kind(_)` uses one of the 35 built-in `PinesIconKind` cases. `.custom(_)`
/// renders a user-provided SVG file via `<img src="path" class="w-4 h-4">`.
public enum PinesBannerIcon: Sendable {
    /// Render a built-in `PinesIconKind` icon at `.sm` size.
    case kind(PinesIconKind)
    /// Render a user-provided SVG file via `<img src="path" class="w-4 h-4">`.
    case custom(path: String)
}
