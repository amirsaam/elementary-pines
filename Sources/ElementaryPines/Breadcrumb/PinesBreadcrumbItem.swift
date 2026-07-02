/// A single item in a `pinesBreadcrumb(_:separator:)` list.
///
/// Use `.link` for navigable crumbs and `.current` for the current page
/// (rendered as non-clickable text with `aria-current="page"`).
///
/// ```swift
/// pinesBreadcrumb([
///     .link("Home", href: "/"),
///     .link("Docs", href: "/docs"),
///     .current("Current Page")
/// ])
/// ```
public enum PinesBreadcrumbItem: Sendable {
    /// A clickable crumb that links to `href`.
    case link(_ text: String, href: String)
    /// The current page — not clickable, rendered with `aria-current="page"`.
    case current(_ text: String)
}

extension PinesBreadcrumbItem {
    /// `true` if this item is a `.current` item.
    public var isCurrent: Bool {
        if case .current = self { return true }
        return false
    }

    /// The display text for this item.
    public var text: String {
        switch self {
        case .link(let t, _): return t
        case .current(let t): return t
        }
    }

    /// The `href` for this item, or `nil` for `.current` items.
    public var href: String? {
        if case .link(_, let h) = self { return h }
        return nil
    }
}
