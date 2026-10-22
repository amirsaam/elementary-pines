import Elementary
import ElementaryAlpine
import ElementaryTailwind

/// Renders the Pines UI progress bar.
///
/// With no `value` (the default), the bar is Alpine-driven and animates from
/// 0 to 100 on page load: an
/// `x-data` scope holding `progress` and `progressInterval`, an `x-init`
/// that increments `progress` by 1 every 100 ms until it reaches 100, and a
/// fill bar whose width is bound reactively via `x-bind:style`.
///
/// Passing a `value` renders a static bar at that percentage (clamped to
/// 0–100, computed against `of`) with no Alpine logic.
///
/// **Generated HTML (default):**
/// ```html
/// <div x-data="{ progress: 0, progressInterval: null }" x-init="..."
///      class="relative w-full h-3 overflow-hidden rounded-full bg-muted">
///     <span x-bind:style="'width:' + progress + '%'"
///           class="absolute left-0 w-24 h-3 duration-300 ease-linear bg-primary" x-cloak></span>
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesProgress()                                // auto-animated 0→100, theme accent, h-3
/// pinesProgress(45)                              // static 45%, theme accent, h-3
/// pinesProgress(9, of: 20)                       // static 45%, theme accent, h-3
/// pinesProgress(75, color: .green, size: .lg)    // static 75%, green, h-4
/// ```
///
/// - Parameters:
///   - value: A fixed progress value. When `nil` (the default), renders the
///     Alpine-animated bar.
///   - max: The value that represents 100%. Defaults to 100.
///   - color: The track/fill color. When omitted, the semantic theme accent is used.
///   - size: The bar height. Defaults to `.md` (`h-3`).
public func pinesProgress(
    _ value: Int? = nil,
    of max: Int = 100,
    color: PinesColor? = nil,
    size: PinesProgressSize = .md
) -> some HTML {
    let track: HTMLAttribute<HTMLTag.div> =
        color == nil ? .class(PinesTheme.muted) : .backgroundColor(color!.shade(.subtle))
    let fill: HTMLAttribute<HTMLTag.span> =
        color == nil ? .class(PinesTheme.primary) : .backgroundColor(color!.solidButtonScale.bg)
    let heightToken = size.heightToken

    if let value {
        let percent = max > 0 ? Swift.max(0, Swift.min(100, value * 100 / max)) : 0
        let html = div(
            .position(.relative),
            .width(.full),
            .height(heightToken),
            .overflow(.hidden),
            .borderRadius(.full),
            track
        ) {
            span(
                .position(.absolute),
                .insetLeft(.zero),
                .width(.size(24)),
                .height(.full),
                .transitionDuration(.ms(300)),
                .transitionTimingFunction(.linear),
                fill,
                .style("width: \(percent)%")
            ) {}
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
        .position(.relative),
        .width(.full),
        .height(heightToken),
        .overflow(.hidden),
        .borderRadius(.full),
        track
    ) {
        span(
            .x.bindStyle("'width:' + progress + '%'"),
            .position(.absolute),
            .insetLeft(.zero),
            .width(.size(24)),
            .height(.full),
            .transitionDuration(.ms(300)),
            .transitionTimingFunction(.linear),
            fill,
            .x.cloak
        ) {}
    }
    return HTMLRaw(html.render())
}
