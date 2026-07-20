import Elementary
import ElementaryAlpine

/// Renders the Pines UI progress bar.
///
/// With no `value` (the default), the bar is Alpine-driven and animates from
/// 0 to 100 on page load — exactly matching the official Pines example: an
/// `x-data` scope holding `progress` and `progressInterval`, an `x-init`
/// that increments `progress` by 1 every 100 ms until it reaches 100, and a
/// fill bar whose width is bound reactively via `:style`.
///
/// Passing a `value` renders a static bar at that percentage (clamped to
/// 0–100, computed against `of`) with no Alpine logic.
///
/// **Generated HTML (default):**
/// ```html
/// <div x-data="{ progress: 0, progressInterval: null }" x-init="..."
///      class="relative w-full h-3 overflow-hidden rounded-full bg-neutral-100">
///     <span :style="'width:' + progress + '%'"
///           class="absolute w-24 h-full duration-300 ease-linear bg-neutral-900" x-cloak></span>
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesProgress()                                // auto-animated 0→100, neutral, h-3
/// pinesProgress(45)                              // static 45%, neutral, h-3
/// pinesProgress(9, of: 20)                       // static 45%, neutral, h-3
/// pinesProgress(75, color: .green, size: .lg)    // static 75%, green, h-4
/// ```
///
/// - Parameters:
///   - value: A fixed progress value. When `nil` (the default), renders the
///     Alpine-animated bar from the official example.
///   - max: The value that represents 100%. Defaults to 100.
///   - color: The track/fill color. Defaults to neutral (the official design).
///   - size: The bar height. Defaults to `.md` (`h-3`).
public func pinesProgress(
    _ value: Int? = nil,
    of max: Int = 100,
    color: PinesColor = .neutral,
    size: PinesProgressSize = .md
) -> some HTML {
    let heightClass = size.heightClass
    let containerClass = "relative w-full \(heightClass) overflow-hidden rounded-full bg-\(color.rawValue)-100"
    let barClass = "absolute w-24 \(heightClass) duration-300 ease-linear bg-\(color.rawValue)-900"

    if let value {
        let percent = max > 0 ? Swift.max(0, Swift.min(100, value * 100 / max)) : 0
        let html = div(.class(containerClass)) {
            span(.class(barClass), .style("width: \(percent)%")) {}
        }
        return HTMLRaw(html.render())
    }

    let xData =
        "{\n"
        + "        progress: 0,\n"
        + "        progressInterval: null,\n"
        + "    }"
    let xInit =
        "\n"
        + "        progressInterval = setInterval(() => {\n"
        + "            progress = progress + 1;\n"
        + "            if (progress >= 100) {\n"
        + "                clearInterval(progressInterval);\n"
        + "            }\n"
        + "        }, 100);\n"
        + "    "

    let html = div(
        .x.data(xData),
        .x.setup(xInit),
        .class(containerClass)
    ) {
        span(
            HTMLAttribute(name: ":style", value: "'width:' + progress + '%'"),
            .class(barClass),
            .x.cloak
        ) {}
    }
    return HTMLRaw(html.render())
}
