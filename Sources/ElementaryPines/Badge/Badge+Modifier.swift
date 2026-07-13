import Elementary

public extension HTMLElement where Tag == HTMLTag.span {
    /// Applies a Pines badge style to the element by adding the appropriate
    /// Tailwind utility classes to the `class` attribute.
    ///
    /// Merges with any existing `class` attribute (rather than replacing it),
    /// so the user can layer on extra classes via `.class(_:)` at construction
    /// time and have them preserved.
    ///
    /// - Parameters:
    ///   - style: The layout style — `.solid`, `.light`, `.outline`, `.dot`, or `.icon`.
    ///   - color: The Tailwind color palette. Defaults to `.neutral` (the Pines
    ///     default, matching the `badge.html` source).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <span class="...tailwind utility classes...">New</span>
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// span { "New" }.pinesBadgeStyle(.light, color: .blue)
    /// span { "Active" }.pinesBadgeStyle(.solid)
    /// span { "Online" }.pinesBadgeStyle(.dot, color: .green)  // user adds the dot element
    /// span { "Active" }.pinesBadgeStyle(.icon, color: .green)  // user adds the icon
    /// ```
    func pinesBadgeStyle(_ style: PinesBadgeStyle, color: PinesColor = .neutral) -> Self {
        let attr = HTMLAttribute<Tag>(
            name: "class",
            value: style.classes(color),
            mergedBy: .appending(separatedBy: " ")
        )
        return self.attributes(attr)
    }
}
