import Elementary
import Foundation

/// Renders a styled checkbox matching the Pines UI default checkbox design.
///
/// Wraps the `<input>` and a sibling `<label>` in
/// `<div class="flex items-center mb-4">`.
///
/// **Generated HTML:**
/// ```html
/// <div class="flex items-center mb-4">
///     <input type="checkbox" class="w-4 h-4 bg-gray-100 border-gray-300 rounded ..." name="..." id="...">
///     <label for="..." class="ml-2 text-sm font-medium text-gray-900">Label</label>
/// </div>
/// ```
///
/// **Examples:**
/// ```swift
/// pinesCheckbox(labelText: "Remember me", name: "remember", id: "remember")
///
/// pinesCheckbox(labelText: "Accept terms", required: true, name: "terms", id: "terms")
///
/// pinesCheckbox(labelText: "Toggle", name: "opt", id: "opt") {
///     [.x.model("isChecked")]
/// }
///
/// pinesCheckbox(labelText: "Multi", name: "m", id: "m") {
///     [.x.model("val"), .x.on("click", "handler()")]
/// }
/// ```
public func pinesCheckbox(
    labelText: String,
    checked: Bool = false,
    color: PinesColor? = nil,
    disabled: Bool = false,
    required: Bool = false,
    name: String? = nil,
    id: String,
    attributes: () -> [HTMLAttribute<HTMLTag.input>] = { [] }
) -> some HTML {
    let textColorClass = color.map { "text-\($0.rawValue)-600" } ?? "text-neutral-900"
    let focusRingClass = color.map { "focus:ring-\($0.rawValue)-300" } ?? "focus:ring-neutral-900"

    var inputClasses = "w-4 h-4 bg-gray-100 border-gray-300 rounded \(textColorClass) \(focusRingClass)"
    if disabled {
        inputClasses += " disabled:opacity-50 disabled:cursor-not-allowed"
    }

    let inputAttrs = buildCheckboxAttributes(
        classes: inputClasses,
        name: name,
        id: id,
        checked: checked,
        disabled: disabled,
        required: required,
        extra: attributes()
    )

    let html = div(.class("flex items-center mb-4")) {
        input(attributes: inputAttrs)
        label(.for(id), .class("ml-2 text-sm font-medium text-gray-900")) {
            labelText
        }
    }
    return HTMLRaw(html.render())
}

/// Renders a peer-checked card checkbox with user-provided content.
///
/// The `<input>` is hidden (`hidden peer`) and a `<label>` wraps the content
/// closure. The label carries card-style `peer-checked:` Tailwind utilities
/// (border, padding, background transitions on check).
///
/// **Examples:**
/// ```swift
/// pinesCheckbox(name: "lib", id: "lib") {
///     [.x.model("selected")]
/// } content: {
///     PinesIcon(.atSymbol, size: .xl, color: .blue)
///     div { "AlpineJS" }
/// }
///
/// pinesCheckbox(name: "lib", id: "lib") {
///     [.x.model("selected"), .x.on("click", "handler()")]
/// } content: {
///     div { "AlpineJS" }
/// }
/// ```
public func pinesCheckbox(
    checked: Bool = false,
    color: PinesColor? = nil,
    disabled: Bool = false,
    required: Bool = false,
    name: String? = nil,
    id: String,
    attributes: () -> [HTMLAttribute<HTMLTag.input>] = { [] },
    @HTMLBuilder content: () -> some HTML
) -> some HTML {
    let accentColor = color?.rawValue ?? "blue"

    var inputClasses = "hidden peer"
    if disabled {
        inputClasses += " disabled:opacity-50 disabled:cursor-not-allowed"
    }

    let inputAttrs = buildCheckboxAttributes(
        classes: inputClasses,
        name: name,
        id: id,
        checked: checked,
        disabled: disabled,
        required: required,
        extra: attributes()
    )

    let labelClasses = """
        inline-flex items-center justify-between w-full p-5 bg-white border-2 \
        rounded-lg cursor-pointer group border-neutral-200/70 text-neutral-600 \
        peer-checked:border-\(accentColor)-600 peer-checked:text-neutral-900 \
        peer-checked:bg-\(accentColor)-50/50 hover:text-neutral-900
        """
        .replacingOccurrences(of: "\n", with: " ")
        .trimmingCharacters(in: .whitespaces)

    let html = div(.class("relative")) {
        input(attributes: inputAttrs)
        label(.for(id), .class(labelClasses)) {
            content()
        }
    }
    return HTMLRaw(html.render())
}

/// Renders a peer-checked custom checkbox with user-provided content and label classes.
///
/// The `<input>` is hidden (`hidden peer`) and a `<label>` wraps the content
/// closure. The user supplies `labelClasses` to define `peer-checked:` and
/// `[&_...]` Tailwind utilities that control how the content reacts to the
/// checked state.
///
/// **Examples:**
/// ```swift
/// pinesCheckbox(name: "x", id: "x", labelClasses: "peer-checked:[&_svg]:scale-100 [&_svg]:scale-0 peer-checked:[&_.custom-checkbox]:border-blue-500 peer-checked:[&_.custom-checkbox]:bg-blue-500 text-sm font-medium text-neutral-600 flex items-center space-x-2") {
///     [.x.model("toggle")]
/// } content: {
///     span(.class("flex items-center justify-center w-5 h-5 border-2 rounded custom-checkbox text-neutral-900")) {
///         // svg checkmark
///     }
///     span { "Custom Checkbox" }
/// }
/// ```
public func pinesCheckbox(
    checked: Bool = false,
    color: PinesColor? = nil,
    disabled: Bool = false,
    required: Bool = false,
    name: String? = nil,
    id: String,
    labelClasses: String,
    attributes: () -> [HTMLAttribute<HTMLTag.input>] = { [] },
    @HTMLBuilder content: () -> some HTML
) -> some HTML {
    let accentColor = color?.rawValue ?? "blue"

    var inputClasses = "hidden peer"
    if disabled {
        inputClasses += " disabled:opacity-50 disabled:cursor-not-allowed"
    }

    let inputAttrs = buildCheckboxAttributes(
        classes: inputClasses,
        name: name,
        id: id,
        checked: checked,
        disabled: disabled,
        required: required,
        extra: attributes()
    )

    let fullLabelClasses = "peer-checked:text-\(accentColor)-600 select-none \(labelClasses)"

    let html = div(.class("flex items-start mb-6")) {
        div(.class("flex items-center h-5")) {
            input(attributes: inputAttrs)
            label(.for(id), .class(fullLabelClasses)) {
                content()
            }
        }
    }
    return HTMLRaw(html.render())
}

private func buildCheckboxAttributes(
    classes: String,
    name: String?,
    id: String,
    checked: Bool,
    disabled: Bool,
    required: Bool,
    extra: [HTMLAttribute<HTMLTag.input>] = []
) -> [HTMLAttribute<HTMLTag.input>] {
    var attrs: [HTMLAttribute<HTMLTag.input>] = [
        HTMLAttribute(name: "type", value: "checkbox"),
        .class(classes),
    ]
    if let name { attrs.append(.name(name)) }
    attrs.append(.id(id))
    if checked { attrs.append(.checked) }
    if disabled { attrs.append(.disabled) }
    if required { attrs.append(.required) }
    attrs.append(contentsOf: extra)
    return attrs
}
