import Elementary
import ElementaryAlpine

/// Renders a rating component matching the Pines UI rating design.
///
/// The component uses Alpine.js for interactive star/heart selection,
/// hover previews, and a reset button. Icons are rendered via `x-for`
/// with filled/unfilled SVGs toggled by `x-show`.
///
/// **Generated HTML:**
/// ```html
/// <div x-data="{ disabled: false, max_stars: 5, stars: 0, value: 0, ... }"
///      x-init="this.stars = this.value">
///   ...
/// </div>
/// ```
///
/// **Examples:**
/// ```swift
/// pinesRating()
/// pinesRating(icon: .heart, color: .pink)
/// pinesRating(emptyStyle: .filled)
/// pinesRating(compactReset: true)
/// pinesRating(icon: .heart, color: .pink, compactReset: true)
/// ```
///
/// - Parameters:
///   - icon: The icon shape for rating. Defaults to `.star`.
///   - color: The accent color for filled icons. Defaults to yellow.
///   - emptyStyle: How unfilled icons are rendered. Defaults to `.outlined`.
///   - maxStars: The maximum number of icons. Defaults to 5.
///   - value: The initial rating value. Defaults to 0.
///   - disabled: Whether the rating is disabled. Defaults to false.
///   - compactReset: When true, shows an inline circle-x reset button
///     instead of a separate button below. Defaults to false.
///   - attributes: Extra HTML attributes (reserved for future use).
public func pinesRating(
    icon: PinesRatingIcon = .star,
    color: PinesColor = .yellow,
    emptyStyle: PinesRatingEmptyStyle = .outlined,
    maxStars: Int = 5,
    value: Int = 0,
    disabled: Bool = false,
    compactReset: Bool = false,
    attributes: [HTMLAttribute<HTMLTag.input>] = []
) -> some HTML {
    let xData = ratingXData(
        disabled: disabled,
        maxStars: maxStars,
        value: value
    )
    let classes = ratingClasses(
        color: color,
        emptyStyle: emptyStyle,
        compactReset: compactReset
    )

    return div(
        .class(classes.container),
        .x.data(xData),
        .x.setup("this.stars = this.value")
    ) {
        ratedTextView(text: classes.ratedText, suffix: classes.ratedSuffix)

        ul(.class("flex items-center")) {
            ratingStars(
                iconPath: icon.kind.path,
                emptyColor: classes.emptyColor,
                emptySvg: classes.emptySvg,
                filledColor: classes.filledColor
            )

            if compactReset {
                compactResetButton(color: color)
            }
        }

        if !compactReset {
            fullResetButton()
        }
    }
}

private func ratingXData(
    disabled: Bool,
    maxStars: Int,
    value: Int
) -> String {
    """
    { \
    disabled: \(disabled), \
    max_stars: \(maxStars), \
    stars: \(value), \
    value: \(value), \
    hoverStar(star){ \
    if (this.disabled) { return; } \
    this.stars = star; \
    }, \
    mouseLeftStar(){ \
    if (this.disabled) { return; } \
    this.stars = this.value; \
    }, \
    rate(star){ \
    if (this.disabled) { return; } \
    this.stars = star; \
    this.value = star; \
    $refs.rated.classList.remove('opacity-0'); \
    setTimeout(function(){ \
    $refs.rated.classList.add('opacity-0'); \
    }, 2000); \
    }, \
    reset(){ \
    if (this.disabled) { return; } \
    this.value = 0; \
    this.stars = 0; \
    } \
    }
    """
}

private struct RatingClasses {
    let container: String
    let emptyColor: String
    let emptySvg: String
    let filledColor: String
    let ratedText: String
    let ratedSuffix: String
}

private func ratingClasses(
    color: PinesColor,
    emptyStyle: PinesRatingEmptyStyle,
    compactReset: Bool
) -> RatingClasses {
    let emptyColor: String = {
        switch emptyStyle {
        case .outlined: return "text-gray-900"
        case .filled: return "text-gray-300 fill-current"
        }
    }()

    let emptySvg: String = {
        switch emptyStyle {
        case .outlined:
            return #"fill="none" stroke="currentColor""#
                + #" stroke-linecap="round""#
                + #" stroke-linejoin="round""#
                + #" stroke-width="16""#
        case .filled: return ""
        }
    }()

    let filledColor =
        color == .yellow
        ? "text-yellow-400 fill-current"
        : "text-\(color.rawValue)-600 fill-current"

    let container =
        compactReset
        ? "relative flex items-center w-auto mx-auto jusitfy-center pt-4"
        : "relative flex flex-col items-center max-w-6xl mx-auto jusitfy-center"

    let ratedTextColor =
        color == .yellow
        ? "text-gray-900"
        : "text-\(color.rawValue)-500"

    let ratedTextFallback =
        color == .yellow
        ? "text-gray-900"
        : "text-gray-400"

    let ratedText =
        compactReset
        ? "absolute top-0 left-0 pl-1 -mt-1 text-sm \(ratedTextColor)"
            + " duration-300 ease-out -translate-y-full opacity-0"
        : "absolute -mt-6 text-xs font-medium \(ratedTextFallback)"
            + " duration-300 ease-out -translate-y-full opacity-0"

    let ratedSuffix = compactReset ? "" : " Stars"

    return RatingClasses(
        container: container,
        emptyColor: emptyColor,
        emptySvg: emptySvg,
        filledColor: filledColor,
        ratedText: ratedText,
        ratedSuffix: ratedSuffix
    )
}

@HTMLBuilder
private func ratedTextView(text: String, suffix: String) -> some HTML {
    div(
        .x.ref("rated"),
        .class(text)
    ) {
        HTMLRaw("Rated ")
        span(.x.text("value")) { "" }
        HTMLRaw(suffix)
    }
}

@HTMLBuilder
private func ratingStars(
    iconPath: String,
    emptyColor: String,
    emptySvg: String,
    filledColor: String
) -> some HTML {
    let xmlns: HTMLAttribute<HTMLTag.svg> = HTMLAttribute(
        name: "xmlns",
        value: "http://www.w3.org/2000/svg"
    )
    let viewBox: HTMLAttribute<HTMLTag.svg> = HTMLAttribute(
        name: "viewBox",
        value: "0 0 256 256"
    )
    let emptySvgRaw =
        #"<rect width="256" height="256" fill="none""#
        + #" <path d="\#(iconPath)" \#(emptySvg)/>"#
    let filledSvgRaw =
        #"<rect width="256" height="256" fill="none""#
        + #" <path d="\#(iconPath)"/>"#

    template(.x.loop("star in max_stars"), .x.bind("key", "star")) {
        li(
            .x.on("mouseover", "hoverStar(star)"),
            .x.on("mouseleave", "mouseLeftStar"),
            .x.on("click", "rate(star)"),
            .class("px-1 cursor-pointer"),
            .x.bindClass(
                "{ 'text-gray-400 cursor-not-allowed': disabled }"
            )
        ) {
            svg(
                .x.show("star > stars"),
                .class("w-6 h-6 \(emptyColor)"),
                xmlns,
                viewBox
            ) {
                HTMLRaw(emptySvgRaw)
            }
            svg(
                .x.show("star <= stars"),
                .class("w-6 h-6 \(filledColor)"),
                xmlns,
                viewBox
            ) {
                HTMLRaw(filledSvgRaw)
            }
        }
    }
}

@HTMLBuilder
private func compactResetButton(color: PinesColor) -> some HTML {
    let bgClass =
        color == .yellow
        ? "text-yellow-600 bg-yellow-100 hover:bg-yellow-400 hover:text-white"
        : "text-\(color.rawValue)-600 bg-\(color.rawValue)-100"
            + " hover:bg-\(color.rawValue)-400 hover:text-white"

    button(
        .x.show("value"),
        .x.on("click", "reset"),
        .class(
            "ml-1 inline-flex items-center justify-center"
                + " w-5 h-5 text-xs rounded-full transition-colors"
        ),
        .class(bgClass),
        .x.bindClass(
            "{ 'opacity-50 cursor-not-allowed': disabled }"
        )
    ) {
        pinesIcon(.x, size: .xs)
    }
}

@HTMLBuilder
private func fullResetButton() -> some HTML {
    button(
        .x.on("click", "reset"),
        .class(
            "inline-flex items-center px-2 py-1 mt-3 text-xs"
                + " text-gray-600 bg-gray-200 rounded-full"
                + " hover:bg-black hover:text-white"
        ),
        .x.bindClass(
            "{ 'opacity-50 cursor-not-allowed': disabled }"
        )
    ) {
        svg(
            .class("w-3 h-3 mr-0.5"),
            HTMLAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
            HTMLAttribute(name: "viewBox", value: "0 0 256 256")
        ) {
            HTMLRaw(
                #"<rect width="256" height="256" fill="none"/>"#
                    + #"<polyline points="24 56 24 104 72 104""#
                    + #" fill="none" stroke="currentColor""#
                    + #" stroke-linecap="round""#
                    + #" stroke-linejoin="round""#
                    + #" stroke-width="24"/>"#
                    + #"<path d="M67.59,192A88,88,0,1,0,65.77,65.77L24,104""#
                    + #" fill="none" stroke="currentColor""#
                    + #" stroke-linecap="round""#
                    + #" stroke-linejoin="round""#
                    + #" stroke-width="24"/>"#
            )
        }
        span { "Reset" }
    }
}
