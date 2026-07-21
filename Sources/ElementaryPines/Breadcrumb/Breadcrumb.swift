import Elementary

/// Renders a Pines-styled breadcrumb navigation.
///
/// Defaults: a bordered `<nav>`,
/// a chevron separator between items, and a home icon for the first crumb.
///
/// - Parameters:
///   - items: The breadcrumb trail.
///   - separator: The separator rendered between items. Defaults to `.chevron`.
///   - homeIcon: The icon shown for the first item. Defaults to `.icon(.home)`
///     via `pinesIcon`. Pass `.none` to render the first item as text.
///
/// **Example:**
/// ```swift
/// pinesBreadcrumb([
///     .link("Home", href: "/"),
///     .link("Docs", href: "/docs"),
///     .current("Installation"),
/// ])
///
/// pinesBreadcrumb(items, separator: .slash)
///
/// pinesBreadcrumb(items, homeIcon: .none)
///
/// pinesBreadcrumb(items, homeIcon: .custom(path: "/icons/home.svg"))
/// ```
public func pinesBreadcrumb(
    _ items: [PinesBreadcrumbItem],
    separator: PinesBreadcrumbSeparator = .chevron,
    homeIcon: PinesBreadcrumbHomeIcon = .icon(.home)
) -> some HTML {
    nav(
        .class("flex justify-between px-3.5 py-1 border border-neutral-200/60 rounded-md"),
        HTMLAttribute(name: "aria-label", value: "Breadcrumb")
    ) {
        let breadcrumbListClass =
            "inline-flex items-center mb-3 space-x-1 text-xs text-neutral-500 "
            + "[&_.active-breadcrumb]:text-neutral-600 [&_.active-breadcrumb]:font-medium sm:mb-0"
        ol(.class(breadcrumbListClass)) {
            for (index, item) in items.enumerated() {
                if index > 0 {
                    breadcrumbSeparatorItem(separator)
                }

                if item.isCurrent {
                    li {
                        a(
                            .class("inline-flex items-center py-1 font-normal rounded cursor-default active-breadcrumb focus:outline-none"),
                            HTMLAttribute(name: "aria-current", value: "page")
                        ) {
                            item.text
                        }
                    }
                } else if index == 0, case .none = homeIcon {
                    li {
                        a(
                            HTMLAttribute(name: "href", value: item.href ?? "#"),
                            .class("inline-flex items-center py-1 font-normal hover:text-neutral-900 focus:outline-none")
                        ) {
                            item.text
                        }
                    }
                } else if index == 0 {
                    li(.class("flex items-center h-full")) {
                        a(
                            HTMLAttribute(name: "href", value: item.href ?? "#"),
                            .class("py-1 hover:text-neutral-900")
                        ) {
                            breadcrumbHomeContent(homeIcon)
                        }
                    }
                } else {
                    li {
                        a(
                            HTMLAttribute(name: "href", value: item.href ?? "#"),
                            .class("inline-flex items-center py-1 font-normal hover:text-neutral-900 focus:outline-none")
                        ) {
                            item.text
                        }
                    }
                }
            }
        }
    }
}

/// A single breadcrumb separator rendered as an `aria-hidden` list item.
private func breadcrumbSeparatorItem(
    _ separator: PinesBreadcrumbSeparator
) -> HTMLElement<HTMLTag.li, HTMLRaw> {
    switch separator {
    case .chevron:
        let icon = pinesIcon(.chevronRight, size: .md, attributes: [.class("text-gray-400/70")])
        return li(HTMLAttribute(name: "aria-hidden", value: "true")) {
            HTMLRaw(icon.render())
        }
    case .slash:
        return li(HTMLAttribute(name: "aria-hidden", value: "true")) {
            HTMLRaw("/")
        }
    case .arrow:
        return li(HTMLAttribute(name: "aria-hidden", value: "true")) {
            HTMLRaw("→")
        }
    }
}

/// The home icon/image rendered inside the first crumb's link.
private func breadcrumbHomeContent(
    _ homeIcon: PinesBreadcrumbHomeIcon
) -> HTMLRaw {
    switch homeIcon {
    case .icon(let kind):
        let icon = pinesIcon(kind, size: .xs, attributes: [.class("w-3.5 h-3.5")])
        return HTMLRaw(icon.render())
    case .custom(let path):
        return HTMLRaw(img(.src(path), .class("w-3.5 h-3.5")).render())
    case .none:
        return HTMLRaw("")
    }
}
