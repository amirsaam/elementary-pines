import Elementary

public extension HTMLElement where Tag == HTMLTag.button {
    /// Applies a Pines button style to the element by adding the appropriate
    /// Tailwind utility classes to the `class` attribute.
    ///
    /// Merges with any existing `class` attribute (rather than replacing it),
    /// so the user can layer on extra classes via `.class(_:)` at construction
    /// time and have them preserved.
    ///
    /// - Parameters:
    ///   - style: The layout style — `.solid`, `.tonal`, or `.outline`.
    ///   - color: The Tailwind color palette. Defaults to `.neutral` (the Pines
    ///     default, matching the `button.html` source).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <button class="...tailwind utility classes...">Save</button>
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// button { "Save" }.pinesButtonStyle(.solid, color: .blue)
    /// button { "Cancel" }.pinesButtonStyle(.tonal, color: .neutral)
    /// button { "Delete" }.pinesButtonStyle(.outline, color: .red)
    /// button { "Default" }.pinesButtonStyle(.solid)  // color defaults to .neutral
    /// ```
    func pinesButtonStyle(_ style: PinesButtonStyle, color: PinesColor = .neutral) -> Self {
        let attr = HTMLAttribute<Tag>(
            name: "class",
            value: style.classes(color),
            mergedBy: .appending(separatedBy: " ")
        )
        return self.attributes(attr)
    }
}
