/// Derives a `[PinesBreadcrumbItem]` trail from a current URL path and
/// a flat site map of `(path, label)` entries.
///
/// Behavior:
/// 1. Walks the site map and finds every entry whose path equals `path`
///    or is a prefix of it, sorted shortest-first.
/// 2. Marks the deepest exact match as `.current`. When no entry
///    matches the exact current path, the last URL segment is used as
///    the label for the `.current` item.
/// 3. Returns the chain — root, ancestors in order, then the current
///    page last — ready to pass to `pinesBreadcrumb(_:separator:)`.
///
/// **Example:**
/// ```swift
/// let siteMap: [PinesSiteMapEntry] = [
///     .init(path: "/", label: "Home"),
///     .init(path: "/docs", label: "Docs"),
///     .init(path: "/docs/getting-started", label: "Getting Started"),
///     .init(path: "/docs/getting-started/installation", label: "Installation"),
/// ]
///
/// let items = pinesBreadcrumbItems(
///     for: "/docs/getting-started/installation",
///     in: siteMap
/// )
/// pinesBreadcrumb(items)
/// ```
///
/// - Parameters:
///   - path: The current URL path (leading slash optional).
///   - siteMap: A list of `(path, label)` entries describing the site
///     hierarchy. If it contains a `"/"` entry, that entry is used as
///     the root; otherwise `root:` is used.
///   - root: The fallback root entry. Default is `/` labeled `"Home"`.
/// - Returns: A breadcrumb trail — root, ancestors in order, then the
///   current page last.
public func pinesBreadcrumbItems(
    for path: String,
    in siteMap: [PinesSiteMapEntry],
    root: PinesSiteMapEntry = PinesSiteMapEntry(path: "/", label: "Home")
) -> [PinesBreadcrumbItem] {
    // Normalize the path: ensure leading slash, strip trailing slash.
    let withLeading = path.hasPrefix("/") ? path : "/" + path
    let normalized =
        (withLeading.count > 1 && withLeading.hasSuffix("/"))
        ? String(withLeading.dropLast())
        : withLeading

    // Find every entry whose path equals `normalized` or is a strict prefix
    // of it. Sorted shortest-first so the trail reads root → leaf.
    let matching =
        siteMap
        .filter { entry in
            normalized == entry.path
                || normalized.hasPrefix(entry.path + "/")
        }
        .sorted { $0.path.count < $1.path.count }

    // The deepest exact match is the current page. If the current path
    // doesn't descend from any site map entry, `currentEntry` is nil
    // and a label is derived from the last URL segment below.
    let currentEntry = matching.last(where: { $0.path == normalized })

    // All other matching entries are ancestors (the first one is the root).
    let ancestors = matching.filter { $0.path != currentEntry?.path }

    // If the current page is the root, the trail is just the root as
    // `.current`. Otherwise build root + ancestors + current.
    var items: [PinesBreadcrumbItem] = []
    if normalized == root.path {
        items.append(.current(root.label))
        return items
    }

    let rootItem =
        ancestors.first(where: { $0.path == root.path })
        ?? root
    items.append(.link(rootItem.label, href: rootItem.path))

    for ancestor in ancestors where ancestor.path != rootItem.path {
        items.append(.link(ancestor.label, href: ancestor.path))
    }

    if let current = currentEntry, current.path != rootItem.path {
        items.append(.current(current.label))
    } else if currentEntry == nil {
        // No entry in the site map matches the current path — derive a
        // label from the last URL segment.
        let label =
            normalized
            .split(separator: "/", omittingEmptySubsequences: true)
            .last
            .map(String.init) ?? normalized
        items.append(.current(label))
    }

    return items
}
