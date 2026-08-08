import Elementary
import ElementaryAlpine
import ElementaryTailwind

/// Renders a styled date picker matching the Pines UI date picker design.
///
/// The component is a fully custom Alpine.js driven calendar dropdown.
/// A readonly text input shows the formatted date; clicking the input or the
/// calendar icon toggles a dropdown calendar with month/year navigation,
/// day-of-week headers, and a clickable day grid.
///
/// **Example:**
/// ```swift
/// pinesDatePicker()
///
/// pinesDatePicker(labelText: "Birthday", format: .mmDdYyyy)
///
/// pinesDatePicker(labelText: "Start Date", placeholder: "Pick a date", width: .size(72))
/// ```
///
/// - Parameters:
///   - labelText: Label text above the input. Defaults to `"Select Date"`.
///   - placeholder: Placeholder text shown when no date is selected.
///     Defaults to `"Select date"`.
///   - format: Date display format. Defaults to `.monthDayYear` (`"M d, Y"`).
///   - width: Tailwind width token. Defaults to `.arbitrary("17rem")`.
///   - disabled: Whether the input is disabled. Defaults to `false`.
///   - attributes: Extra HTML attributes (e.g. Alpine directives) applied
///     to the outer `<div>`.
public func pinesDatePicker(
    labelText: String = "Select Date",
    placeholder: String = "Select date",
    format: PinesDatePickerFormat = .monthDayYear,
    width: TWTWidth = .arbitrary("17rem"),
    disabled: Bool = false,
    attributes: [HTMLAttribute<HTMLTag.div>] = []
) -> some HTML {
    let xData = PinesDatePickerState.xData(format: format.rawValue)
    let xInit = PinesDatePickerState.xInit

    var inputAttributes: [HTMLAttribute<HTMLTag.input>] =
        [
            .x.ref("datePickerInput"),
            .x.bind("id", "$id('datepicker')"),
            .type(.text),
            .x.on("click", "datePickerOpen=!datePickerOpen"),
            .x.model("datePickerValue"),
            .x.on("keydown", "datePickerOpen=false", modifiers: [.escape]),
            .display(.flex),
            .paddingX(.size(3)),
            .paddingY(.size(2)),
            .width(.full),
            .height(.size(10)),
            .fontSize(.sm),
            .class(PinesSurface.background),
            .borderRadius(.md),
            .borderWidth(.bare),
            .class(PinesSurface.foreground),
        ]
        + pinesTextFieldAttributes(
            borderColor: PinesColor.neutral.shade(.light),
            placeholderColor: PinesColor.neutral.shade(.accent),
            focusRingColor: PinesColor.neutral.shade(.accent),
            surface: true
        ) + [
            .placeholder(placeholder),
            HTMLAttribute(name: "readonly", value: ""),
        ]
    if disabled { inputAttributes.append(.disabled) }

    let rootAttributes: [HTMLAttribute<HTMLTag.div>] =
        [
            .marginBottom(.size(5)),
            .width(.full),
            .x.data(xData),
            .x.setup(xInit),
            .x.id("['datepicker']"),
            .x.cloak,
        ] + attributes

    return div(attributes: rootAttributes) {
        // Label
        label(
            .x.bind("for", "$id('datepicker')"),
            .marginBottom(.size(1)),
            .display(.block),
            .fontSize(.sm),
            .fontWeight(.medium),
            .class(PinesSurface.mutedForeground)
        ) {
            labelText
        }

        // Input + calendar icon + calendar dropdown
        div(.position(.relative), .width(width)) {
            input(attributes: inputAttributes)

            div(
                .x.on(
                    "click",
                    "datePickerOpen=!datePickerOpen; if(datePickerOpen){ $refs.datePickerInput.focus() }"
                ),
                .position(.absolute),
                .insetTop(.zero),
                .insetRight(.zero),
                .paddingX(.size(3)),
                .paddingY(.size(2)),
                .cursor(.pointer),
                .textColor(PinesColor.neutral.shade(.accent)),
                .textColor(PinesColor.neutral.shade(.base), variants: [.hover])
            ) {
                pinesIcon(.calendar, size: .lg)
            }

            // Calendar dropdown
            div(
                .x.show("datePickerOpen"),
                .x.transition(),
                .x.on("click", "datePickerOpen = false", modifiers: [.outside]),
                .position(.absolute),
                .insetTop(.zero),
                .insetLeft(.zero),
                .maxWidth(.lg),
                .padding(.size(4)),
                .marginTop(.size(12)),
                .fontSmoothing(.antialiased),
                .class(PinesSurface.background),
                .borderWidth(.bare),
                .borderRadius(.lg),
                .boxShadow(.sm),
                .width(.arbitrary("17rem")),
                .class(PinesSurface.borderSubtle)
            ) {
                // Month/year header with navigation
                div(
                    .display(.flex),
                    .justify(.between),
                    .items(.center),
                    .marginBottom(.size(2))
                ) {
                    div {
                        span(
                            .x.text("datePickerMonthNames[datePickerMonth]"),
                            .fontSize(.lg),
                            .fontWeight(.bold),
                            .textColor(PinesColor.gray.shade(.deep))
                        ) {
                            ""
                        }
                        span(
                            .x.text("datePickerYear"),
                            .marginLeft(.size(1)),
                            .fontSize(.lg),
                            .fontWeight(.normal),
                            .textColor(PinesColor.gray.shade(.strong))
                        ) {
                            ""
                        }
                    }
                    div {
                        button(
                            .type(.button),
                            .x.on("click", "datePickerPreviousMonth()"),
                            .display(.inlineFlex),
                            .padding(.size(1)),
                            .borderRadius(.full),
                            .transition(.all),
                            .transitionDuration(.ms(100)),
                            .transitionTimingFunction(.easeInOut),
                            .cursor(.pointer),
                            .outlineStyle(.hidden, variants: [.focus]),
                            .class("shadow-outline", variants: [.focus]),
                            .backgroundColor(
                                PinesColor.gray.shade(.tint2),
                                variants: [.hover]
                            )
                        ) {
                            pinesIcon(.chevronLeft, size: .md)
                        }
                        button(
                            .type(.button),
                            .x.on("click", "datePickerNextMonth()"),
                            .display(.inlineFlex),
                            .padding(.size(1)),
                            .borderRadius(.full),
                            .transition(.all),
                            .transitionDuration(.ms(100)),
                            .transitionTimingFunction(.easeInOut),
                            .cursor(.pointer),
                            .outlineStyle(.hidden, variants: [.focus]),
                            .class("shadow-outline", variants: [.focus]),
                            .backgroundColor(
                                PinesColor.gray.shade(.tint2),
                                variants: [.hover]
                            )
                        ) {
                            pinesIcon(.chevronRight, size: .md)
                        }
                    }
                }

                // Day-of-week headers
                div(
                    .display(.grid),
                    .gridTemplateColumns(.value(7)),
                    .marginBottom(.size(3))
                ) {
                    template(
                        .x.loop("(day, index) in datePickerDays"),
                        .x.bind("key", "index")
                    ) {
                        div(.paddingX(.size(0.5))) {
                            div(
                                .x.text("day"),
                                .paddingX(.size(0.5)),
                                .fontSize(.xs),
                                .fontWeight(.medium),
                                .textAlign(.center),
                                .textColor(PinesColor.gray.shade(.deep))
                            ) {
                                ""
                            }
                        }
                    }
                }

                // Day grid
                div(.display(.grid), .gridTemplateColumns(.value(7))) {
                    template(
                        .x.loop("blankDay in datePickerBlankDaysInMonth")
                    ) {
                        div(
                            .padding(.size(1)),
                            .fontSize(.sm),
                            .textAlign(.center),
                            .borderWidth(.bare),
                            .borderColor(.transparent)
                        ) {
                            ""
                        }
                    }
                    template(
                        .x.loop("(day, dayIndex) in datePickerDaysInMonth"),
                        .x.bind("key", "dayIndex")
                    ) {
                        div(
                            .paddingX(.size(0.5)),
                            .marginBottom(.size(1)),
                            .aspect(.square)
                        ) {
                            div(
                                .x.text("day"),
                                .x.on("click", "datePickerDayClicked(day)"),
                                .x.bindClass(
                                    pinesAlpineBindClass([
                                        (
                                            twValue(.backgroundColor(PinesColor.neutral.shade(.subtle))),
                                            "datePickerIsToday(day) == true"
                                        ),
                                        (
                                            twValue(
                                                .textColor(PinesColor.gray.shade(.strong)),
                                                .backgroundColor(PinesColor.neutral.shade(.subtle), variants: [.hover])
                                            ),
                                            "datePickerIsToday(day) == false && datePickerIsSelectedDate(day) == false"
                                        ),
                                        (
                                            twValue(
                                                .backgroundColor(PinesColor.neutral.shade(.deep)),
                                                .textColor(.white),
                                                .backgroundColor(PinesColor.neutral.shade(.deep), opacity: 70, variants: [.hover])
                                            ),
                                            "datePickerIsSelectedDate(day) == true"
                                        ),
                                    ])
                                ),
                                .display(.flex),
                                .justify(.center),
                                .items(.center),
                                .width(.size(7)),
                                .height(.size(7)),
                                .fontSize(.sm),
                                .lineHeight(.none),
                                .textAlign(.center),
                                .borderRadius(.full),
                                .cursor(.pointer)
                            ) {
                                ""
                            }
                        }
                    }
                }
            }
        }
    }
}
