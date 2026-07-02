import Elementary

/// Renders a breadcrumb navigation trail as a `<nav>` containing an `<ol>`
/// of `PinesBreadcrumbItem` values, separated by a configurable glyph.
///
/// Each link item is wrapped in an `<li><a>`; the current-page item is
/// wrapped in a `<li><span aria-current="page">`. A separator `<li>` is
/// rendered between every pair of items. The first separator is hidden
/// via Tailwind's `first:hidden` variant so the first item has no
/// leading glyph.
///
/// **Generated HTML:**
/// ```html
/// <nav class="text-sm" aria-label="Breadcrumb">
///     <ol class="flex items-center gap-2">
///         <li><a href="/" class="text-neutral-500 hover:text-neutral-700">Home</a></li>
///         <li aria-hidden="true" class="text-neutral-400">›</li>
///         <li><a href="/docs" class="text-neutral-500 hover:text-neutral-700">Docs</a></li>
///         <li aria-hidden="true" class="text-neutral-400">›</li>
///         <li><span class="text-neutral-900 font-medium" aria-current="page">Current</span></li>
///     </ol>
/// </nav>
/// ```
///
/// **Example:**
/// ```swift
/// pinesBreadcrumb([
///     .link("Home", href: "/"),
///     .link("Docs", href: "/docs"),
///     .current("Current Page")
/// ])
///
/// pinesBreadcrumb(items, separator: .slash)
/// ```
///
/// For data-driven sites with a known hierarchy, `pinesBreadcrumbItems(for:in:root:)`
/// derives the items from a flat `(path, label)` site map:
///
/// ```swift
/// let siteMap: [PinesSiteMapEntry] = [
///     .init(path: "/", label: "Home"),
///     .init(path: "/docs", label: "Docs"),
///     .init(path: "/docs/getting-started", label: "Getting Started"),
///     .init(path: "/docs/getting-started/installation", label: "Installation"),
/// ]
///
/// let items = pinesBreadcrumbItems(for: request.url.path, in: siteMap)
/// pinesBreadcrumb(items)
/// ```
public func pinesBreadcrumb(
    _ items: [PinesBreadcrumbItem],
    separator: PinesBreadcrumbSeparator = .chevron
) -> some HTML {
    nav(.class("text-sm"), HTMLAttribute(name: "aria-label", value: "Breadcrumb")) {
        ol(.class("flex items-center gap-2")) {
            for item in items {
                li(
                    HTMLAttribute(name: "aria-hidden", value: "true"),
                    .class("text-neutral-400 first:hidden")
                ) {
                    separator.character
                }
                if item.isCurrent {
                    li {
                        span(
                            .class("text-neutral-900 font-medium"),
                            HTMLAttribute(name: "aria-current", value: "page")
                        ) {
                            item.text
                        }
                    }
                } else {
                    li {
                        a(
                            HTMLAttribute(name: "href", value: item.href ?? "#"),
                            .class("text-neutral-500 hover:text-neutral-700")
                        ) {
                            item.text
                        }
                    }
                }
            }
        }
    }
}
