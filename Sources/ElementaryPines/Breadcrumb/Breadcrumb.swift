import Elementary
import ElementaryTailwind

/// Renders a Pines-styled breadcrumb navigation.
///
/// Defaults: a bordered `<nav>`,
/// a chevron separator between items, and a home icon for the first crumb.
///
/// - Parameters:
///   - items: The breadcrumb trail.
///   - separator: The separator rendered between items. Defaults to `.chevron`.
///   - homeIcon: The icon shown for the first item. Defaults to `.icon(.home)`,
///     which renders a filled home icon. Pass `.none` to render the first item
///     as text.
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
        .display(.flex),
        .justify(.between),
        .paddingX(.size(3.5)),
        .paddingY(.size(1)),
        .borderWidth(.bare),
        .class(PinesSurface.borderSubtle60),
        .borderRadius(.md),
        HTMLAttribute(name: "aria-label", value: "Breadcrumb")
    ) {
        let activeCrumb: [TWVariant] = [.arbitrary("[&_.active-breadcrumb]")]
        ol(
            .display(.inlineFlex),
            .items(.center),
            .marginBottom(.size(3)),
            .marginBottom(.size(0), variants: [.sm]),
            .spaceX(.size(1)),
            .fontSize(.xs),
            .class(PinesSurface.mutedForeground),
            .class(PinesSurface.foreground, variants: activeCrumb),
            .fontWeight(.medium, variants: activeCrumb)
        ) {
            for (index, item) in items.enumerated() {
                if index > 0 {
                    breadcrumbSeparatorItem(separator)
                }

                if item.isCurrent {
                    li {
                        a(
                            .display(.inlineFlex),
                            .items(.center),
                            .paddingY(.size(1)),
                            .fontWeight(.normal),
                            .borderRadius(.sm),
                            .cursor(.default),
                            .class("active-breadcrumb"),
                            .outlineStyle(.hidden, variants: [.focus]),
                            HTMLAttribute(name: "aria-current", value: "page")
                        ) {
                            item.text
                        }
                    }
                } else if index == 0, case .none = homeIcon {
                    li {
                        a(
                            .display(.inlineFlex),
                            .items(.center),
                            .paddingY(.size(1)),
                            .fontWeight(.normal),
                            .class(PinesSurface.foreground, variants: [.hover]),
                            .outlineStyle(.hidden, variants: [.focus]),
                            HTMLAttribute(name: "href", value: item.href ?? "#")
                        ) {
                            item.text
                        }
                    }
                } else if index == 0 {
                    li(.display(.flex), .items(.center), .height(.full)) {
                        a(
                            .paddingY(.size(1)),
                            .class(PinesSurface.foreground, variants: [.hover]),
                            HTMLAttribute(name: "href", value: item.href ?? "#")
                        ) {
                            breadcrumbHomeContent(homeIcon)
                        }
                    }
                } else {
                    li {
                        a(
                            .display(.inlineFlex),
                            .items(.center),
                            .paddingY(.size(1)),
                            .fontWeight(.normal),
                            .class(PinesSurface.foreground, variants: [.hover]),
                            .outlineStyle(.hidden, variants: [.focus]),
                            HTMLAttribute(name: "href", value: item.href ?? "#")
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
        let icon = SVG.svg(
            SVGAttribute(name: "class", value: "w-5 h-5 text-gray-400/70"),
            SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
            SVGAttribute(name: "viewBox", value: "0 0 24 24")
        ) {
            SVG.path(
                .d("M10 8.013l4 4-4 4"),
                .stroke("currentColor"),
                .strokeWidth(2),
                .strokeLinecap(.round),
                .strokeLinejoin(.round)
            )
        }
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
    case .icon(.home):
        return HTMLRaw(breadcrumbFilledHomeIcon().render())
    case .icon(let kind):
        let icon = pinesIcon(kind, size: .xs, attributes: [.width(.size(3.5)), .height(.size(3.5))])
        return HTMLRaw(icon.render())
    case .custom(let path):
        return HTMLRaw(img(.src(path), .width(.size(3.5)), .height(.size(3.5))).render())
    case .none:
        return HTMLRaw("")
    }
}

private func breadcrumbFilledHomeIcon() -> some HTML {
    SVG.svg(
        SVGAttribute(name: "class", value: "w-3.5 h-3.5"),
        SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
        SVGAttribute(name: "viewBox", value: "0 0 24 24"),
        SVGAttribute(name: "fill", value: "currentColor")
    ) {
        SVG.path(
            .d(
                "M11.47 3.84a.75.75 0 011.06 0l8.69 8.69a.75.75 0 101.06-1.06l-8.689-8.69a2.25 2.25 0 00-3.182 0l-8.69 8.69a.75.75 0 001.061 1.06l8.69-8.69zM12 5.432l8.159 8.159c.03.03.06.058.091.086v6.198c0 1.035-.84 1.875-1.875 1.875H15a.75.75 0 01-.75-.75v-4.5a.75.75 0 00-.75-.75h-3a.75.75 0 00-.75.75V21a.75.75 0 01-.75.75H5.625a1.875 1.875 0 01-1.875-1.875v-6.198a2.29 2.29 0 00.091-.086L12 5.43z"
            )
        )
    }
}
