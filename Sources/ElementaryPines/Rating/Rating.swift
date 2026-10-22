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
///   - color: The accent color for filled icons. When omitted, the semantic
///     theme accent emitted by `setupPines()` is used.
///   - emptyStyle: How unfilled icons are rendered. Defaults to `.outlined`.
///   - maxStars: The maximum number of icons. Defaults to 5.
///   - value: The initial rating value. Defaults to 0.
///   - disabled: Whether the rating is disabled. Defaults to false.
///   - compactReset: When true, shows an inline circle-x reset button
///     instead of a separate button below. Defaults to false.
///   - attributes: Extra HTML attributes merged into the root element.
public func pinesRating(
    icon: PinesRatingIcon = .star,
    color: PinesColor? = nil,
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
        div(attributes: classes.wrapperAttributes) {
            ratedTextView(
                compactReset: compactReset,
                color: color,
                suffix: classes.ratedSuffix
            )

            ul(attributes: [.display(.flex)]) {
                ratingStars(
                    emptyPath: paths.empty,
                    filledPath: paths.filled,
                    emptyColor: classes.emptyColor,
                    emptyStyle: emptyStyle,
                    filledColor: classes.filledColor,
                    compactReset: compactReset
                )
            }

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
    showRated: false, \
    rate(star){ \
    if (this.disabled) { return; } \
    this.stars = star; \
    this.value = star; \
    this.showRated = true; \
    setTimeout(function(){ \
    this.showRated = false; \
    }.bind(this), 2000); \
    }, \
    reset(){ \
    if (this.disabled) { return; } \
    this.value = 0; \
    this.stars = 0; \
    this.showRated = false; \
    } \
    }
    """
}

private struct RatingClasses {
    let containerAttributes: [HTMLAttribute<HTMLTag.div>]
    let wrapperAttributes: [HTMLAttribute<HTMLTag.div>]
    let emptyColor: String
    let emptyStyle: PinesRatingEmptyStyle
    let filledColor: String
    let ratedSuffix: String
}

private func ratingClasses(
    color: PinesColor?,
    emptyStyle: PinesRatingEmptyStyle,
    compactReset: Bool
) -> RatingClasses {
    let emptyColor: String = {
        if color == nil || color == .neutral {
            return emptyStyle == .outlined
                ? PinesTheme.mutedForeground
                : "\(PinesTheme.mutedForeground) fill-current"
        }
        switch emptyStyle {
        case .outlined: return twValue(.textColor(PinesColor.gray.shade(.dark)))
        case .filled:
            return twValue(.textColor(PinesColor.gray.shade(.light)), .fillCurrent())
                + " " + twValue(.textColor(PinesColor.gray.shade(.base), variants: [.dark]))
        }
    }()

    let filledColor: String = {
        if color == nil {
            return "\(PinesTheme.primaryText) fill-current"
        }
        if color == .neutral {
            return "\(PinesTheme.foreground) fill-current"
        }
        if compactReset {
            return twValue(.textColor(color!.shade(.strong)), .fillCurrent())
        }
        guard color == .yellow else {
            return twValue(.textColor(color!.shade(.strong)), .fillCurrent())
        }
        return twValue(.textColor(PinesColor.yellow.shade(.accent)), .fillCurrent())
    }()

    let containerAttributes: [HTMLAttribute<HTMLTag.div>]
    let wrapperAttributes: [HTMLAttribute<HTMLTag.div>]
    if compactReset {
        containerAttributes = []
        wrapperAttributes = [
            .position(.relative),
            .display(.flex),
            .items(.center),
            .width(.auto),
            .marginX(.auto),
            .justify(.center),
        ]
    } else {
        containerAttributes = [
            .display(.flex),
            .items(.center),
            .flexDirection(.column),
            .maxWidth(.sixxl),
            .marginX(.auto),
            .justify(.center),
        ]
        wrapperAttributes = [.position(.relative)]
    }

    let ratedSuffix = compactReset ? "" : " Stars"

    return RatingClasses(
        containerAttributes: containerAttributes,
        wrapperAttributes: wrapperAttributes,
        emptyColor: emptyColor,
        emptyStyle: emptyStyle,
        filledColor: filledColor,
        ratedSuffix: ratedSuffix
    )
}

private func ratedTextView(
    compactReset: Bool,
    color: PinesColor?,
    suffix: String
) -> some HTML {
    let textTWColor: TWColor = {
        if color == nil { return PinesColor.gray.shade(.dark) }
        if color == .yellow { return PinesColor.gray.shade(.dark) }
        return compactReset ? color!.shade(.base) : PinesColor.gray.shade(.dark)
    }()

    let textClass =
        color == .neutral ? PinesTheme.mutedForeground : twValue(.textColor(textTWColor))
    var attrs: [HTMLAttribute<HTMLTag.div>] = [
        .x.show("showRated"),
        .position(.absolute),
    ]
    if compactReset {
        attrs += [
            .insetTop(.zero),
            .insetLeft(.zero),
            .paddingLeft(.size(1)),
            .marginTop(.size(2), negative: true),
            .fontSize(.sm),
            .class(textClass),
        ]
    } else {
        attrs += [
            .insetBottom(.full),
            .marginBottom(.size(2)),
            .insetLeft(.zero),
            .width(.full),
            .textAlign(.center),
            .zIndex(.number(10)),
            .fontSize(.xs),
            .fontWeight(.medium),
            .class(textClass),
        ]
    }
    attrs += [
        .x.transition(modifiers: [.opacity])
    ]
    if compactReset {
        attrs += [
            .translate(.y("full"), negative: true)
        ]
    }

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
private func compactResetButton(color: PinesColor?) -> some HTML {
    let isSemantic = color == nil
    let isNeutral = color == .neutral
    let twColor: TWColor? = color.map { $0.shade(.strong) }
    let twBg: TWColor? = color.map { $0.shade(.tint2) }
    let twHoverBg: TWColor? = color.map { $0.shade(.accent) }

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
        isSemantic ? .class(PinesTheme.primaryText) : isNeutral ? .class(PinesTheme.foreground) : .textColor(twColor!),
        isSemantic
            ? .class(PinesTheme.utility(PinesTheme.primary, opacity: 10)) : isNeutral ? .class(PinesTheme.muted) : .backgroundColor(twBg!),
        isSemantic
            ? .class(PinesTheme.primary, variants: [.hover])
            : isNeutral ? .class(PinesTheme.foreground, variants: [.hover]) : .backgroundColor(twHoverBg!, variants: [.hover]),
        isSemantic
            ? .class(PinesTheme.primaryForeground, variants: [.hover])
            : isNeutral ? .class(PinesTheme.background, variants: [.hover]) : .textColor(.white, variants: [.hover]),
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
        .class("text-background"),
        .class("bg-foreground"),
        .borderRadius(.full),
        .class(PinesTheme.muted, variants: [.hover]),
        .class(PinesTheme.foreground, variants: [.hover]),
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
