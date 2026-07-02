/// A single entry in a breadcrumb site map.
///
/// A site map is a flat list of `(path, label)` pairs describing a site
/// hierarchy. `pinesBreadcrumbItems(for:in:root:)` walks this list to
/// derive the breadcrumb trail for a given URL path.
///
/// ```swift
/// let siteMap: [PinesSiteMapEntry] = [
///     .init(path: "/", label: "Home"),
///     .init(path: "/docs", label: "Documentation"),
///     .init(path: "/docs/getting-started", label: "Getting Started"),
///     .init(path: "/docs/getting-started/installation", label: "Installation"),
/// ]
/// ```
public struct PinesSiteMapEntry: Sendable {
    /// The URL path this entry represents (e.g. `"/docs/getting-started"`).
    public let path: String
    /// The display label for this entry (e.g. `"Getting Started"`).
    public let label: String

    public init(path: String, label: String) {
        self.path = path
        self.label = label
    }
}
