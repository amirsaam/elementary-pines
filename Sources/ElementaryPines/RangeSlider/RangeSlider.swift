import Elementary

/// Renders a styled range slider matching the Pines UI range slider design.
///
/// The component is a single `<input type="range">` with Tailwind
/// pseudo-element classes for custom thumb and track styling.
///
/// **Generated HTML:**
/// ```html
/// <input type="range" min="0" max="100" value="50" step="any" name="..." id="..."
///        class="w-full h-full appearance-none flex items-center cursor-pointer bg-transparent z-30
///               [&::-webkit-slider-thumb]:bg-blue-600 [&::-webkit-slider-thumb]:rounded-full ...">
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
///   - name: The name attribute for the input.
///   - id: The id attribute for the input.
///   - color: The accent color for the thumb and progress. Defaults to blue.
///   - min: The minimum value. Defaults to 0.
///   - max: The maximum value. Defaults to 100.
///   - value: The initial value. Defaults to 50.
///   - step: The step increment. Defaults to "any".
///   - disabled: Whether the input is disabled. Defaults to `false`.
///   - attributes: Extra HTML attributes merged into the input element. Defaults to an empty array.
public func pinesRangeSlider(
    name: String,
    id: String,
    color: PinesColor? = nil,
    min: Int = 0,
    max: Int = 100,
    value: Int = 50,
    step: String = "any",
    disabled: Bool = false,
    attributes: [HTMLAttribute<HTMLTag.input>] = []
) -> some HTML {
    let accentColor = color?.rawValue ?? "blue"
    let thumbColor =
        "[&::-webkit-slider-thumb]:bg-\(accentColor)-600 "
        + "[&::-moz-range-thumb]:bg-\(accentColor)-600 "
        + "[&::-ms-thumb]:bg-\(accentColor)-600"
    let progressColor =
        "[&::-moz-range-progress]:bg-\(accentColor)-400 "
        + "[&::-ms-fill-lower]:bg-\(accentColor)-400"
    let webkitProgress =
        "[&::-webkit-slider-thumb]:shadow-[-999px_0px_0px_990px_#\(color?.hexValue ?? PinesColor.blue.hexValue)]"

    let baseClasses = "w-full h-full appearance-none flex items-center cursor-pointer bg-transparent z-30"
    let thumbClasses =
        "[&::-webkit-slider-thumb]:rounded-full "
        + "[&::-webkit-slider-thumb]:border-0 "
        + "[&::-webkit-slider-thumb]:w-5 "
        + "[&::-webkit-slider-thumb]:h-5 "
        + "[&::-webkit-slider-thumb]:appearance-none "
        + "[&::-moz-range-thumb]:rounded-full "
        + "[&::-moz-range-thumb]:border-0 "
        + "[&::-moz-range-thumb]:w-2.5 "
        + "[&::-moz-range-thumb]:h-2.5 "
        + "[&::-moz-range-thumb]:appearance-none "
        + "[&::-ms-thumb]:rounded-full "
        + "[&::-ms-thumb]:border-0 "
        + "[&::-ms-thumb]:w-2.5 "
        + "[&::-ms-thumb]:h-2.5 "
        + "[&::-ms-thumb]:appearance-none"
    let trackClasses =
        "[&::-webkit-slider-runnable-track]:bg-neutral-200 "
        + "[&::-webkit-slider-runnable-track]:rounded-full "
        + "[&::-webkit-slider-runnable-track]:overflow-hidden "
        + "[&::-moz-range-track]:bg-neutral-200 "
        + "[&::-moz-range-track]:rounded-full "
        + "[&::-ms-track]:bg-neutral-200 "
        + "[&::-ms-track]:rounded-full"

    var allClasses = "\(baseClasses) \(thumbClasses) \(trackClasses) \(thumbColor) \(progressColor) \(webkitProgress)"
    if disabled {
        allClasses += " disabled:opacity-50 disabled:cursor-not-allowed"
    }

    var inputAttributes: [HTMLAttribute<HTMLTag.input>] = [
        HTMLAttribute(name: "type", value: "range"),
        HTMLAttribute(name: "min", value: "\(min)"),
        HTMLAttribute(name: "max", value: "\(max)"),
        HTMLAttribute(name: "value", value: "\(value)"),
        HTMLAttribute(name: "step", value: step),
        .name(name),
        .id(id),
        .class(allClasses),
    ]
    if disabled {
        inputAttributes.append(.disabled)
    }

    return input(attributes: inputAttributes + attributes)
}
