import Elementary

/// Renders a Pines-styled SVG icon. The `color` is applied as a Tailwind
/// `text-X-Y` class on the SVG (so it sets the stroke color via
/// `currentColor`). When `color` is `nil` or `.neutral`, no text class is
/// added and the icon inherits color from the parent.
///
/// Pass `attributes` to layer on Alpine directives, extra classes, or
/// any other SVG attribute. Classes are merged with the default
/// size/color class (so `attributes: [.class("ml-2")]` produces
/// `class="w-4 h-4 ml-2"`).
///
/// ```swift
/// pinesIcon(.check)                                                          // md, currentColor
/// pinesIcon(.check, size: .lg)                                               // w-6 h-6, currentColor
/// pinesIcon(.check, color: .green)                                           // md, text-green-500
/// pinesIcon(.check, size: .lg, color: .blue)                                 // w-6 h-6, text-blue-500
/// pinesIcon(.check, attributes: [.class("ml-2")])                            // class merges
/// pinesIcon(.check, attributes: [.x.show("isVisible")])                      // Alpine directive
/// ```
public func pinesIcon(
    _ icon: PinesIconKind,
    size: PinesIconSize = .md,
    color: PinesColor? = nil,
    attributes: [SVGAttribute<SVGTag.svg>] = []
) -> some HTML {
    let path = icon.path
    let sizeClass = size.classes
    let colorClass: String = {
        if let color, color != .neutral {
            "text-\(color.outlineScale.text)"
        } else {
            ""
        }
    }()
    let className = [sizeClass, colorClass].filter { !$0.isEmpty }.joined(separator: " ")

    let allAttributes: [SVGAttribute<SVGTag.svg>] =
        [
            SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
            SVGAttribute(name: "fill", value: "none"),
            SVGAttribute(name: "viewBox", value: "0 0 24 24"),
            SVGAttribute(name: "stroke-width", value: "1.5"),
            SVGAttribute(name: "stroke", value: "currentColor"),
            SVGAttribute<SVGTag.svg>(
                name: "class",
                value: className,
                mergedBy: .appending(separatedBy: " ")
            ),
        ] + attributes

    return SVG.svg(attributes: allAttributes) {
        HTMLRaw(#"<path stroke-linecap="round" stroke-linejoin="round" d="\#(path)" />"#)
    }
}
