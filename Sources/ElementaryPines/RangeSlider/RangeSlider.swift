import Elementary
import ElementaryTailwind

/// Renders a styled range slider matching the Pines UI range slider design.
///
/// The component is a single `<input type="range">` with Tailwind
/// pseudo-element classes for custom thumb and track styling.
///
/// **Generated HTML:**
/// ```html
/// <input type="range" min="0" max="100" value="50" step="any" name="..." id="..."
///        class="w-full h-full appearance-none flex items-center cursor-pointer bg-transparent z-30
///               [&::-webkit-slider-thumb]:rounded-full [&::-webkit-slider-thumb]:border-0 ...">
/// ```
///
/// **Examples:**
/// ```swift
/// pinesRangeSlider(name: "volume", id: "volume")
/// pinesRangeSlider(name: "price", id: "price", color: .green, min: 0, max: 200, value: 50)
/// pinesRangeSlider(name: "volume", id: "volume", attributes: [.x.model("volume")])
/// ```
///
/// - Parameters:
///   - color: The accent color for the thumb and progress. Defaults to blue.
///   - name: The name attribute for the input.
///   - id: The id attribute for the input.
///   - min: The minimum value. Defaults to 0.
///   - max: The maximum value. Defaults to 100.
///   - value: The initial value. Defaults to 50.
///   - step: The step increment. Defaults to "any".
///   - disabled: Whether the input is disabled. Defaults to `false`.
///   - attributes: Extra HTML attributes merged into the input element. Defaults to an empty array.
public func pinesRangeSlider(
    color: PinesColor? = nil,
    name: String,
    id: String,
    min: Int = 0,
    max: Int = 100,
    value: Int = 50,
    step: String = "any",
    disabled: Bool = false,
    attributes: [HTMLAttribute<HTMLTag.input>] = []
) -> some HTML {
    let resolvedColor = color ?? .blue
    let webkitThumb: [TWVariant] = [.arbitrary("[&::-webkit-slider-thumb]")]
    let webkitTrack: [TWVariant] = [.arbitrary("[&::-webkit-slider-runnable-track]")]
    let mozThumb: [TWVariant] = [.arbitrary("[&::-moz-range-thumb]")]
    let mozTrack: [TWVariant] = [.arbitrary("[&::-moz-range-track]")]
    let mozProgress: [TWVariant] = [.arbitrary("[&::-moz-range-progress]")]
    let msThumb: [TWVariant] = [.arbitrary("[&::-ms-thumb]")]
    let msTrack: [TWVariant] = [.arbitrary("[&::-ms-track]")]
    let msFill: [TWVariant] = [.arbitrary("[&::-ms-fill-lower]")]

    var inputAttributes: [HTMLAttribute<HTMLTag.input>] = [
        HTMLAttribute(name: "type", value: "range"),
        HTMLAttribute(name: "min", value: "\(min)"),
        HTMLAttribute(name: "max", value: "\(max)"),
        HTMLAttribute(name: "value", value: "\(value)"),
        HTMLAttribute(name: "step", value: step),
        .name(name),
        .id(id),
        .width(.full),
        .height(.full),
        .appearance(.none),
        .display(.flex),
        .items(.center),
        .cursor(.pointer),
        .backgroundColor(.transparent),
        .zIndex(.number(30)),
        // Thumb styles
        .borderRadius(.full, variants: webkitThumb),
        .borderWidth(.size(0), variants: webkitThumb),
        .width(.size(5), variants: webkitThumb),
        .height(.size(5), variants: webkitThumb),
        .appearance(.none, variants: webkitThumb),
        .borderRadius(.full, variants: mozThumb),
        .borderWidth(.size(0), variants: mozThumb),
        .width(.size(2.5), variants: mozThumb),
        .height(.size(2.5), variants: mozThumb),
        .appearance(.none, variants: mozThumb),
        .borderRadius(.full, variants: msThumb),
        .borderWidth(.size(0), variants: msThumb),
        .width(.size(2.5), variants: msThumb),
        .height(.size(2.5), variants: msThumb),
        .appearance(.none, variants: msThumb),
        // Track styles
        .backgroundColor(PinesColor.neutral.shade(.subtle), variants: webkitTrack),
        .borderRadius(.full, variants: webkitTrack),
        .overflow(.hidden, variants: webkitTrack),
        .backgroundColor(PinesColor.neutral.shade(.subtle), variants: mozTrack),
        .borderRadius(.full, variants: mozTrack),
        .backgroundColor(PinesColor.neutral.shade(.subtle), variants: msTrack),
        .borderRadius(.full, variants: msTrack),
        // Color-based styles
        .backgroundColor(resolvedColor.shade(.strong), variants: webkitThumb),
        .backgroundColor(resolvedColor.shade(.strong), variants: mozThumb),
        .backgroundColor(resolvedColor.shade(.strong), variants: msThumb),
        .backgroundColor(resolvedColor.shade(.accent), variants: mozProgress),
        .borderRadius(.full, variants: mozProgress),
        .backgroundColor(resolvedColor.shade(.accent), variants: msFill),
        .borderRadius(.full, variants: msFill),
        .boxShadow(.arbitrary("-999px_0px_0px_990px_#" + resolvedColor.cssHex), variants: webkitThumb),
    ]
    if disabled {
        inputAttributes.append(.disabled)
        inputAttributes.append(.opacity(.value(50), variants: [.disabled]))
        inputAttributes.append(.cursor(.notAllowed, variants: [.disabled]))
    }

    return input(attributes: inputAttributes + attributes)
}
