import Elementary
import ElementaryAlpine
import ElementaryTailwind

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
///   - attributes: Extra HTML attributes merged into the root element.
public func pinesRating(
    icon: PinesRatingIcon = .star,
    color: PinesColor = .yellow,
    emptyStyle: PinesRatingEmptyStyle = .outlined,
    maxStars: Int = 5,
    value: Int = 0,
    disabled: Bool = false,
    compactReset: Bool = false,
    attributes: [HTMLAttribute<HTMLTag.div>] = []
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
    let paths = ratingPaths(icon: icon, emptyStyle: emptyStyle)

    return div(
        attributes: classes.containerAttributes + [
            .x.data(xData),
            .x.setup("this.stars = this.value"),
        ] + attributes
    ) {
        ratedTextView(
            compactReset: compactReset,
            color: color,
            suffix: classes.ratedSuffix
        )

        let listAttributes: [HTMLAttribute<HTMLTag.ul>] =
            compactReset
            ? [.display(.flex)]
            : [.display(.flex), .items(.center)]
        ul(attributes: listAttributes) {
            ratingStars(
                emptyPath: paths.empty,
                filledPath: paths.filled,
                emptyColor: classes.emptyColor,
                emptyStyle: emptyStyle,
                filledColor: classes.filledColor,
                compactReset: compactReset
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
    let containerAttributes: [HTMLAttribute<HTMLTag.div>]
    let emptyColor: String
    let emptyStyle: PinesRatingEmptyStyle
    let filledColor: String
    let ratedSuffix: String
}

private func ratingClasses(
    color: PinesColor,
    emptyStyle: PinesRatingEmptyStyle,
    compactReset: Bool
) -> RatingClasses {
    let emptyColor: String = {
        if compactReset {
            return twValue(.textColor(color.shade(.strong)), .fillCurrent())
        }
        switch emptyStyle {
        case .outlined: return twValue(.textColor(PinesColor.gray.shade(.dark)))
        case .filled: return twValue(.textColor(PinesColor.gray.shade(.light)), .fillCurrent())
        }
    }()

    let filledColor: String = {
        if compactReset {
            return twValue(.textColor(color.shade(.strong)), .fillCurrent())
        }
        guard color == .yellow else {
            return twValue(.textColor(color.shade(.strong)), .fillCurrent())
        }
        return twValue(.textColor(PinesColor.yellow.shade(.accent)), .fillCurrent())
    }()

    let containerAttributes: [HTMLAttribute<HTMLTag.div>] = {
        var attrs: [HTMLAttribute<HTMLTag.div>] = [
            .position(.relative),
            .display(.flex),
            .items(.center),
        ]
        if compactReset {
            attrs += [
                .width(.auto),
                .marginX(.auto),
                .justify(.center),
            ]
        } else {
            attrs += [
                .flexDirection(.column),
                .maxWidth(.sixxl),
                .marginX(.auto),
                .justify(.center),
            ]
        }
        return attrs
    }()

    let ratedSuffix = compactReset ? "" : " Stars"

    return RatingClasses(
        containerAttributes: containerAttributes,
        emptyColor: emptyColor,
        emptyStyle: emptyStyle,
        filledColor: filledColor,
        ratedSuffix: ratedSuffix
    )
}

private func ratedTextView(
    compactReset: Bool,
    color: PinesColor,
    suffix: String
) -> some HTML {
    let textTWColor: TWColor = {
        if color == .yellow { return PinesColor.gray.shade(.dark) }
        return compactReset ? color.shade(.base) : PinesColor.gray.shade(.accent)
    }()

    var attrs: [HTMLAttribute<HTMLTag.div>] = [
        .x.ref("rated"),
        .position(.absolute),
    ]
    if compactReset {
        attrs += [
            .insetTop(.zero),
            .insetLeft(.zero),
            .paddingLeft(.size(1)),
            .marginTop(.size(2), negative: true),
            .fontSize(.sm),
            .textColor(textTWColor),
        ]
    } else {
        attrs += [
            .marginTop(.size(6), negative: true),
            .fontSize(.xs),
            .fontWeight(.medium),
            .textColor(textTWColor),
        ]
    }
    attrs += [
        .transitionDuration(.ms(300)),
        .transitionTimingFunction(.easeOut),
        .translate(.y("full"), negative: true),
        .opacity(.value(0)),
    ]

    return div(attributes: attrs) {
        HTMLRaw("Rated ")
        span(.x.text("value")) { "" }
        HTMLRaw(suffix)
    }
}

/// 256-grid Phosphor paths for the rating icons, matching the Pines
/// rating element. Distinct from the 24-grid
/// Heroicons paths in ``PinesIconKind`` — the rating SVGs use
/// `viewBox="0 0 256 256"`.
private enum RatingIconPaths {
    /// Phosphor "star" outline path.
    static let starOutline =
        "M128,189.09l54.72,33.65a8.4,8.4,0,0,0,12.52-9.17l-14.88-62.79,48.7-42"
        + "A8.46,8.46,0,0,0,224.27,94L160.36,88.8,135.74,29.2a8.36,8.36,0,0,0-15.48,0"
        + "L95.64,88.8,31.73,94a8.46,8.46,0,0,0-4.79,14.83l48.7,42L60.76,213.57"
        + "a8.4,8.4,0,0,0,12.52,9.17Z"
    /// Phosphor "star" fill path.
    static let starFill =
        "M234.29,114.85l-45,38.83L203,211.75a16.4,16.4,0,0,1-24.5,17.82L128,198.49"
        + ",77.47,229.57A16.4,16.4,0,0,1,53,211.75l13.76-58.07-45-38.83A16.46,16.46,0,0,1"
        + ",31.08,86l59-4.76,22.76-55.08a16.36,16.36,0,0,1,30.27,0l22.75,55.08,59,4.76"
        + "a16.46,16.46,0,0,1,9.37,28.86Z"
    /// Phosphor "heart" path (used for both outline and fill).
    static let heart =
        "M128,224S24,168,24,102A54,54,0,0,1,78,48c22.59,0,41.94,12.31,50,32"
        + ",8.06-19.69,27.41-32,50-32a54,54,0,0,1,54,54C232,168,128,224,128,224Z"
}

private struct RatingPaths {
    let empty: String
    let filled: String
}

private func ratingPaths(
    icon: PinesRatingIcon,
    emptyStyle: PinesRatingEmptyStyle
) -> RatingPaths {
    switch (icon, emptyStyle) {
    case (.star, .outlined):
        return RatingPaths(
            empty: RatingIconPaths.starOutline,
            filled: RatingIconPaths.starFill
        )
    case (.star, .filled):
        return RatingPaths(
            empty: RatingIconPaths.starFill,
            filled: RatingIconPaths.starFill
        )
    case (.heart, .outlined), (.heart, .filled):
        return RatingPaths(
            empty: RatingIconPaths.heart,
            filled: RatingIconPaths.heart
        )
    }
}

@ContentBuilder
private func ratingEmptyPath(
    path: String,
    style: PinesRatingEmptyStyle
) -> some SVGContent {
    switch style {
    case .outlined:
        SVG.path(
            .d(path),
            .fill(.none),
            .stroke("currentColor"),
            .strokeWidth(16),
            .strokeLinecap(.round),
            .strokeLinejoin(.round)
        )
    case .filled:
        SVG.path(.d(path))
    }
}

@ContentBuilder
private func ratingStars(
    emptyPath: String,
    filledPath: String,
    emptyColor: String,
    emptyStyle: PinesRatingEmptyStyle,
    filledColor: String,
    compactReset: Bool
) -> some HTML {
    let xmlns: SVGAttribute<SVGTag.svg> = SVGAttribute(
        name: "xmlns",
        value: "http://www.w3.org/2000/svg"
    )
    let viewBox: SVGAttribute<SVGTag.svg> = SVGAttribute(
        name: "viewBox",
        value: "0 0 256 256"
    )

    template(.x.loop("star in max_stars"), .x.bind("key", "star")) {
        li(
            .x.on("mouseover", "hoverStar(star)"),
            .x.on("mouseleave", "mouseLeftStar"),
            .x.on("click", "rate(star)"),
            .paddingX(.size(1)),
            .cursor(.pointer),
            .x.bindClass(
                pinesAlpineBindClass([
                    (twValue(.textColor(PinesColor.gray.shade(.accent)), .cursor(.notAllowed)), "disabled")
                ])
            )
        ) {
            SVG.svg(
                SVGAttribute(name: "x-show", value: "star > stars"),
                .width(.size(6)),
                .height(.size(6)),
                .class(emptyColor),
                xmlns,
                viewBox
            ) {
                SVG.rect(
                    .width(256),
                    .height(256),
                    .fill(.none)
                )
                ratingEmptyPath(path: emptyPath, style: emptyStyle)
            }
            SVG.svg(
                SVGAttribute(name: "x-show", value: "star <= stars"),
                .width(.size(6)),
                .height(.size(6)),
                .class(filledColor),
                xmlns,
                viewBox
            ) {
                SVG.rect(.width(256), .height(256), .fill(.none))
                if compactReset {
                    SVG.path(
                        .d(filledPath),
                        SVGAttribute(name: "opacity", value: "0.2")
                    )
                    SVG.path(
                        .d(filledPath),
                        .fill(.none),
                        .stroke("currentColor"),
                        .strokeWidth(16),
                        .strokeLinecap(.round),
                        .strokeLinejoin(.round)
                    )
                } else {
                    SVG.path(.d(filledPath))
                }
            }
        }
    }
}

@ContentBuilder
private func compactResetButton(color: PinesColor) -> some HTML {
    let twColor: TWColor = color == .yellow ? PinesColor.yellow.shade(.strong) : color.shade(.strong)
    let twBg: TWColor = color == .yellow ? PinesColor.yellow.shade(.tint2) : color.shade(.tint2)
    let twHoverBg: TWColor = color == .yellow ? PinesColor.yellow.shade(.accent) : color.shade(.accent)

    button(
        .x.show("value"),
        .x.on("click", "reset"),
        .type(.button),
        .position(.absolute),
        .insetRight(.zero),
        .display(.inlineFlex),
        .items(.center),
        .justify(.center),
        .width(.size(5)),
        .height(.size(5)),
        .marginRight(.size(1), negative: true),
        .translate(.x("full")),
        .fontSize(.xs),
        .borderRadius(.full),
        .transition(.colors),
        .textColor(twColor),
        .backgroundColor(twBg),
        .backgroundColor(twHoverBg, variants: [.hover]),
        .textColor(.white, variants: [.hover]),
        .x.bindClass(
            pinesAlpineBindClass([
                (twValue(.opacity(.value(50)), .cursor(.notAllowed)), "disabled")
            ])
        )
    ) {
        SVG.svg(
            .width(.size(3)),
            .height(.size(3)),
            SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
            SVGAttribute(name: "viewBox", value: "0 0 256 256")
        ) {
            SVG.rect(.width(256), .height(256), .fill(.none))
            SVG.line(
                .x1(200),
                .y1(56),
                .x2(56),
                .y2(200),
                .stroke("currentColor"),
                .strokeLinecap(.round),
                .strokeLinejoin(.round),
                .strokeWidth(16)
            )
            SVG.line(
                .x1(200),
                .y1(200),
                .x2(56),
                .y2(56),
                .stroke("currentColor"),
                .strokeLinecap(.round),
                .strokeLinejoin(.round),
                .strokeWidth(16)
            )
        }
    }
}

@ContentBuilder
private func fullResetButton() -> some HTML {
    button(
        .type(.button),
        .x.on("click", "reset"),
        .display(.inlineFlex),
        .items(.center),
        .paddingX(.size(2)),
        .paddingY(.size(1)),
        .marginTop(.size(3)),
        .fontSize(.xs),
        .textColor(PinesColor.gray.shade(.strong)),
        .backgroundColor(PinesColor.gray.range(200)),
        .borderRadius(.full),
        .backgroundColor(.black, variants: [.hover]),
        .textColor(.white, variants: [.hover]),
        .x.bindClass(
            pinesAlpineBindClass([
                (twValue(.opacity(.value(50)), .cursor(.notAllowed)), "disabled")
            ])
        )
    ) {
        SVG.svg(
            .width(.size(3)),
            .height(.size(3)),
            .marginRight(.size(0.5)),
            SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
            SVGAttribute(name: "viewBox", value: "0 0 256 256")
        ) {
            SVG.rect(.width(256), .height(256), .fill(.none))
            SVG.polyline(
                .points("24 56 24 104 72 104"),
                .fill(.none),
                .stroke("currentColor"),
                .strokeLinecap(.round),
                .strokeLinejoin(.round),
                .strokeWidth(24)
            )
            SVG.path(
                .d("M67.59,192A88,88,0,1,0,65.77,65.77L24,104"),
                .fill(.none),
                .stroke("currentColor"),
                .strokeLinecap(.round),
                .strokeLinejoin(.round),
                .strokeWidth(24)
            )
        }
        span { "Reset" }
    }
}
