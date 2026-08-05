import Elementary
import ElementaryTailwind
import Foundation

/// Renders a styled checkbox matching the Pines UI default checkbox design.
///
/// Wraps the `<input>` and a sibling `<label>` in
/// `<div class="flex items-center mb-4">`.
///
/// **Generated HTML:**
/// ```html
/// <div class="flex items-center mb-4">
///     <input type="checkbox" class="w-4 h-4 bg-gray-100 border-gray-300 rounded-sm text-neutral-900 focus:ring-neutral-900 ..." name="..." id="...">
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
    color: PinesColor? = nil,
    checked: Bool = false,
    disabled: Bool = false,
    required: Bool = false,
    name: String? = nil,
    id: String,
    attributes: () -> [HTMLAttribute<HTMLTag.input>] = { [] }
) -> some HTML {
    let textColor = color.map { $0.shade(.strong) } ?? PinesColor.neutral.shade(.dark)
    let focusRingColor = color.map { $0.shade(.light) } ?? PinesColor.neutral.shade(.dark)

    var inputAttrs: [HTMLAttribute<HTMLTag.input>] = [
        HTMLAttribute(name: "type", value: "checkbox"),
        .width(.size(4)),
        .height(.size(4)),
        .backgroundColor(PinesColor.gray.shade(.tint2)),
        .borderColor(PinesColor.gray.shade(.light)),
        .borderRadius(.sm),
        .textColor(textColor),
        .ringColor(focusRingColor, variants: [.focus]),
    ]
    if let name { inputAttrs.append(.name(name)) }
    inputAttrs.append(.id(id))
    if checked { inputAttrs.append(.checked) }
    if disabled {
        inputAttrs.append(.disabled)
        inputAttrs.append(.opacity(.value(50), variants: [.disabled]))
        inputAttrs.append(.cursor(.notAllowed, variants: [.disabled]))
    }
    if required { inputAttrs.append(.required) }
    inputAttrs.append(contentsOf: attributes())

    let html = div(.display(.flex), .items(.center), .marginBottom(.size(4))) {
        input(attributes: inputAttrs)
        label(.for(id), .marginLeft(.size(2)), .fontSize(.sm), .fontWeight(.medium), .textColor(PinesColor.gray.shade(.dark))) {
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
    color: PinesColor? = nil,
    checked: Bool = false,
    disabled: Bool = false,
    required: Bool = false,
    name: String? = nil,
    id: String,
    attributes: () -> [HTMLAttribute<HTMLTag.input>] = { [] },
    @ContentBuilder content: () -> some HTML
) -> some HTML {
    let resolvedColor = color ?? .blue
    let peerChecked: [TWVariant] = [.arbitrary("peer-checked")]

    var inputAttrs: [HTMLAttribute<HTMLTag.input>] = [
        HTMLAttribute(name: "type", value: "checkbox"),
        .peer(.bare),
        .display(.hidden),
    ]
    if disabled {
        inputAttrs.append(.opacity(.value(50), variants: [.disabled]))
        inputAttrs.append(.cursor(.notAllowed, variants: [.disabled]))
    }
    inputAttrs += buildCheckboxAttributes(
        classes: "",
        name: name,
        id: id,
        checked: checked,
        disabled: disabled,
        required: required,
        extra: attributes()
    )

    let labelAttrs: [HTMLAttribute<HTMLTag.label>] = [
        .for(id),
        .display(.inlineFlex),
        .items(.center),
        .justify(.between),
        .width(.full),
        .padding(.size(5)),
        .backgroundColor(.white),
        .borderWidth(.size(2)),
        .borderRadius(.lg),
        .cursor(.pointer),
        .group(.bare),
        .borderColor(PinesColor.neutral.shade(.subtle), opacity: 70),
        .textColor(PinesColor.neutral.shade(.strong)),
        .textColor(PinesColor.neutral.shade(.dark), variants: [.hover]),
        .borderColor(resolvedColor.shade(.strong), variants: peerChecked),
        .textColor(PinesColor.neutral.shade(.dark), variants: peerChecked),
        .backgroundColor(resolvedColor.shade(.tint1), opacity: 50, variants: peerChecked),
    ]

    let html = div(.position(.relative)) {
        input(attributes: inputAttrs)
        label(attributes: labelAttrs) {
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
///     span(.class("flex items-center justify-center w-5 h-5 border-2 rounded-sm custom-checkbox text-neutral-900")) {
///         // svg checkmark
///     }
///     span { "Custom Checkbox" }
/// }
/// ```
public func pinesCheckbox(
    color: PinesColor? = nil,
    checked: Bool = false,
    disabled: Bool = false,
    required: Bool = false,
    name: String? = nil,
    id: String,
    labelClasses: String,
    attributes: () -> [HTMLAttribute<HTMLTag.input>] = { [] },
    @ContentBuilder content: () -> some HTML
) -> some HTML {
    let resolvedColor = color ?? .blue

    var inputAttrs: [HTMLAttribute<HTMLTag.input>] = [
        HTMLAttribute(name: "type", value: "checkbox"),
        .peer(.bare),
        .display(.hidden),
    ]
    if disabled {
        inputAttrs.append(.opacity(.value(50), variants: [.disabled]))
        inputAttrs.append(.cursor(.notAllowed, variants: [.disabled]))
    }
    inputAttrs += buildCheckboxAttributes(
        classes: "",
        name: name,
        id: id,
        checked: checked,
        disabled: disabled,
        required: required,
        extra: attributes()
    )

    let peerCheckedPrefix = TWVariant.apply(
        [.arbitrary("peer-checked")],
        to: twValue(.textColor(resolvedColor.shade(.strong)))
    )
    let fullLabelClasses = "\(peerCheckedPrefix) select-none \(labelClasses)"

    let html = div(
        .display(.flex),
        .items(.start),
        .marginBottom(.size(6))
    ) {
        div(
            .display(.flex),
            .items(.center),
            .height(.size(5))
        ) {
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
        HTMLAttribute(name: "type", value: "checkbox")
    ]
    if !classes.isEmpty { attrs.append(.class(classes)) }
    if let name { attrs.append(.name(name)) }
    attrs.append(.id(id))
    if checked { attrs.append(.checked) }
    if disabled { attrs.append(.disabled) }
    if required { attrs.append(.required) }
    attrs.append(contentsOf: extra)
    return attrs
}
