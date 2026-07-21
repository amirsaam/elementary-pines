import Elementary

/// Special SVG icons that are not part of the standard Heroicons set.
///
/// Some Pines elements use custom multi-path or custom-viewBox SVGs
/// that do not fit the single-path `pinesIcon` model. This enum groups them
/// under a single `pinesSpecialIcon(_:attributes:)` entry point.
public enum PinesSpecialIcon {
    /// The magic-wand illustration used by the Pines banner.
    case wand
    /// The oversized decorative quote mark used by the Pines blockquote.
    case quoteMark
}

/// Renders a special non-Heroicons SVG.
///
/// - Parameters:
///   - icon: The special icon to render.
///   - attributes: Additional SVG attributes merged with the icon's defaults.
///     Classes are appended to the default class when the icon defines one.
/// - Returns: An SVG element suitable for use in HTML content.
@ContentBuilder
public func pinesSpecialIcon(
    _ icon: PinesSpecialIcon,
    attributes: [SVGAttribute<SVGTag.svg>] = []
) -> some HTML {
    switch icon {
    case .wand:
        pinesSpecialWandIcon(attributes: attributes)
    case .quoteMark:
        pinesSpecialQuoteMarkIcon(attributes: attributes)
    }
}

// MARK: - Wand

@ContentBuilder
private func pinesSpecialWandIcon(
    attributes: [SVGAttribute<SVGTag.svg>]
) -> some HTML {
    let allAttributes: [SVGAttribute<SVGTag.svg>] =
        [
            SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
            SVGAttribute(name: "fill", value: "none"),
            SVGAttribute(name: "viewBox", value: "0 0 24 24"),
        ] + attributes

    SVG.svg(attributes: allAttributes) {
        SVG.g {
            SVG.path(
                .d(
                    "M10.1893 8.12241C9.48048 8.50807 9.66948 9.5633 10.4691 9.68456L13.5119 10.0862C13.7557 10.1231 13.7595 10.6536 13.7968 10.8949L14.2545 13.5486C14.377 14.3395 15.4432 14.5267 15.8333 13.8259L17.1207 11.3647C17.309 11.0046 17.702 10.7956 18.1018 10.8845C18.8753 11.1023 19.6663 11.3643 20.3456 11.4084C21.0894 11.4567 21.529 10.5994 21.0501 10.0342C20.6005 9.50359 20.0352 8.75764 19.4669 8.06623C19.2213 7.76746 19.1292 7.3633 19.2863 7.00567L20.1779 4.92643C20.4794 4.23099 19.7551 3.52167 19.0523 3.82031L17.1037 4.83372C16.7404 4.99461 16.3154 4.92545 16.0217 4.65969C15.3919 4.08975 14.6059 3.39451 14.0737 2.95304C13.5028 2.47955 12.6367 2.91341 12.6845 3.64886C12.7276 4.31093 13.0055 5.20996 13.1773 5.98734C13.2677 6.3964 13.041 6.79542 12.658 6.97364L10.1893 8.12241Z"
                ),
                .stroke("currentColor"),
                .strokeWidth(1.5)
            )
            SVG.path(
                .d(
                    "M12.1575 9.90759L3.19359 18.8714C2.63313 19.3991 2.61799 20.2851 3.16011 20.8317C3.70733 21.3834 4.60355 21.3694 5.13325 20.8008L13.9787 11.9552"
                ),
                .stroke("currentColor"),
                .strokeWidth(1.5),
                .strokeLinecap(.round),
                .strokeLinejoin(.round)
            )
            SVG.path(
                .d("M5 6.25V3.75M3.75 5H6.25"),
                .stroke("currentColor"),
                .strokeWidth(1.5),
                .strokeLinecap(.round),
                .strokeLinejoin(.round)
            )
            SVG.path(
                .d("M18 20.25V17.75M16.75 19H19.25"),
                .stroke("currentColor"),
                .strokeWidth(1.5),
                .strokeLinecap(.round),
                .strokeLinejoin(.round)
            )
        }
    }
}

// MARK: - Quote mark

@ContentBuilder
private func pinesSpecialQuoteMarkIcon(
    attributes: [SVGAttribute<SVGTag.svg>]
) -> some HTML {
    let defaultClass = "w-16 h-16 text-gray-100 transform -translate-x-6 -translate-y-8"

    let allAttributes: [SVGAttribute<SVGTag.svg>] =
        [
            SVGAttribute(
                name: "class",
                value: defaultClass,
                mergedBy: .appending(separatedBy: " ")
            ),
            SVGAttribute(name: "width", value: "16"),
            SVGAttribute(name: "height", value: "16"),
            SVGAttribute(name: "viewBox", value: "0 0 16 16"),
            SVGAttribute(name: "fill", value: "none"),
            SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
            SVGAttribute(name: "aria-hidden", value: "true"),
        ] + attributes

    SVG.svg(attributes: allAttributes) {
        SVG.path(
            .d(
                "M7.39762 10.3C7.39762 11.0733 7.14888 11.7 6.6514 12.18C6.15392 12.6333 5.52552 12.86 4.76621 12.86C3.84979 12.86 3.09047 12.5533 2.48825 11.94C1.91222 11.3266 1.62421 10.4467 1.62421 9.29999C1.62421 8.07332 1.96459 6.87332 2.64535 5.69999C3.35231 4.49999 4.33418 3.55332 5.59098 2.85999L6.4943 4.25999C5.81354 4.73999 5.26369 5.27332 4.84476 5.85999C4.45201 6.44666 4.19017 7.12666 4.05926 7.89999C4.29491 7.79332 4.56983 7.73999 4.88403 7.73999C5.61716 7.73999 6.21938 7.97999 6.69067 8.45999C7.16197 8.93999 7.39762 9.55333 7.39762 10.3ZM14.6242 10.3C14.6242 11.0733 14.3755 11.7 13.878 12.18C13.3805 12.6333 12.7521 12.86 11.9928 12.86C11.0764 12.86 10.3171 12.5533 9.71484 11.94C9.13881 11.3266 8.85079 10.4467 8.85079 9.29999C8.85079 8.07332 9.19117 6.87332 9.87194 5.69999C10.5789 4.49999 11.5608 3.55332 12.8176 2.85999L13.7209 4.25999C13.0401 4.73999 12.4903 5.27332 12.0713 5.85999C11.6786 6.44666 11.4168 7.12666 11.2858 7.89999C11.5215 7.79332 11.7964 7.73999 12.1106 7.73999C12.8437 7.73999 13.446 7.97999 13.9173 8.45999C14.3886 8.93999 14.6242 9.55333 14.6242 10.3Z"
            ),
            .fill("currentColor")
        )
    }
}
