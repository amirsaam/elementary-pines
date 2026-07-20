import Elementary

/// Controls the icon shown for the first breadcrumb item (the home/root).
public enum PinesBreadcrumbHomeIcon: Sendable {
    /// Use a built-in `pinesIcon` kind.
    case icon(PinesIconKind)
    /// Render a user-provided image.
    case custom(path: String)
    /// No icon — render the first item as text like the rest of the trail.
    case none
}
