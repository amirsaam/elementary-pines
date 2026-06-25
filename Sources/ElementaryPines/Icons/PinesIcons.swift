import Elementary

/// Renders a Pines-styled SVG icon. The `color` is applied as a Tailwind
/// `text-X-Y` class on the SVG (so it sets the stroke color via
/// `currentColor`). When `color` is `nil` or `.neutral`, no text class is
/// added and the icon inherits color from the parent.
///
/// For positioning classes (e.g. `ml-2`), wrap the icon in a parent element:
///
/// ```swift
/// pinesIcon(.check)                            // md, currentColor
/// pinesIcon(.check, size: .lg)                 // w-6 h-6, currentColor
/// pinesIcon(.check, color: .green)             // md, text-green-500
/// pinesIcon(.check, size: .lg, color: .blue)   // w-6 h-6, text-blue-500
/// span(.class("ml-2")) { pinesIcon(.check) }   // positioned
/// ```
public func pinesIcon(
    _ icon: PinesIconKind,
    size: PinesIconSize = .md,
    color: PinesColor? = nil
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

    return svg(
        HTMLAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
        HTMLAttribute(name: "fill", value: "none"),
        HTMLAttribute(name: "viewBox", value: "0 0 24 24"),
        HTMLAttribute(name: "stroke-width", value: "1.5"),
        HTMLAttribute(name: "stroke", value: "currentColor"),
        .class(className)
    ) {
        HTMLRaw(#"<path stroke-linecap="round" stroke-linejoin="round" d="\#(path)" />"#)
    }
}
