import Elementary
import ElementaryAlpine

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
/// pinesDatePicker(labelText: "Start Date", placeholder: "Pick a date", width: "w-72")
/// ```
///
/// - Parameters:
///   - labelText: Label text above the input. Defaults to `"Select Date"`.
///   - placeholder: Placeholder text shown when no date is selected.
///     Defaults to `"Select date"`.
///   - format: Date display format. Defaults to `.monthDayYear` (`"M d, Y"`).
///   - width: Tailwind width class. Defaults to `"w-[17rem]"`.
///   - disabled: Whether the input is disabled. Defaults to `false`.
///   - attributes: Extra HTML attributes (e.g. Alpine directives) applied
///     to the outer `<div>`.
public func pinesDatePicker(
    labelText: String = "Select Date",
    placeholder: String = "Select date",
    format: PinesDatePickerFormat = .monthDayYear,
    width: String = "w-[17rem]",
    disabled: Bool = false,
    attributes: [HTMLAttribute<HTMLTag.div>] = []
) -> some HTML {
    let xData = PinesDatePickerState.xData(format: format.rawValue)
    let xInit = PinesDatePickerState.xInit

    var inputAttributes: [HTMLAttribute<HTMLTag.input>] = [
        .x.ref("datePickerInput"),
        .type(.text),
        .x.on("click", "datePickerOpen=!datePickerOpen"),
        .x.model("datePickerValue"),
        .x.on("keydown", "datePickerOpen=false", modifiers: [.escape]),
        .class(
            "flex px-3 py-2 w-full h-10 text-sm bg-white rounded-md border text-neutral-600 border-neutral-300 ring-offset-background placeholder:text-neutral-400 focus:border-neutral-300 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-neutral-400 disabled:cursor-not-allowed disabled:opacity-50"
        ),
        .placeholder(placeholder),
        HTMLAttribute(name: "readonly", value: ""),
    ]
    if disabled { inputAttributes.append(.disabled) }

    return div(
        .class("mb-5 w-full"),
        .x.data(xData),
        .x.setup(xInit),
        .x.cloak
    ) {
        // Label
        label(.for("datepicker"), .class("block mb-1 text-sm font-medium text-neutral-500")) {
            labelText
        }

        // Input + calendar icon + calendar dropdown
        div(.class("relative \(width)")) {
            input(attributes: inputAttributes)

            div(
                .x.on(
                    "click",
                    "datePickerOpen=!datePickerOpen; if(datePickerOpen){ $refs.datePickerInput.focus() }"
                ),
                .class("absolute top-0 right-0 px-3 py-2 cursor-pointer text-neutral-400 hover:text-neutral-500")
            ) {
                pinesIcon(.calendar, size: .md)
            }

            // Calendar dropdown
            div(
                .x.show("datePickerOpen"),
                .x.transition(),
                .x.on("click", "datePickerOpen = false", modifiers: [.outside]),
                .class(
                    "absolute top-0 left-0 max-w-lg p-4 mt-12 antialiased bg-white border rounded-lg shadow w-[17rem] border-neutral-200/70"
                )
            ) {
                // Month/year header with navigation
                div(.class("flex justify-between items-center mb-2")) {
                    div {
                        span(.x.text("datePickerMonthNames[datePickerMonth]"), .class("text-lg font-bold text-gray-800")) {
                            ""
                        }
                        span(.x.text("datePickerYear"), .class("ml-1 text-lg font-normal text-gray-600")) {
                            ""
                        }
                    }
                    div {
                        button(
                            .type(.button),
                            .x.on("click", "datePickerPreviousMonth()"),
                            .class(
                                "inline-flex p-1 rounded-full transition duration-100 ease-in-out cursor-pointer focus:outline-none focus:shadow-outline hover:bg-gray-100"
                            )
                        ) {
                            pinesIcon(.chevronLeft, size: .md)
                        }
                        button(
                            .type(.button),
                            .x.on("click", "datePickerNextMonth()"),
                            .class(
                                "inline-flex p-1 rounded-full transition duration-100 ease-in-out cursor-pointer focus:outline-none focus:shadow-outline hover:bg-gray-100"
                            )
                        ) {
                            pinesIcon(.chevronRight, size: .md)
                        }
                    }
                }

                // Day-of-week headers
                div(.class("grid grid-cols-7 mb-3")) {
                    template(.x.loop("(day, index) in datePickerDays"), .x.bind("key", "index")) {
                        div(.class("px-0.5")) {
                            div(.x.text("day"), .class("text-xs font-medium text-center text-gray-800")) {
                                ""
                            }
                        }
                    }
                }

                // Day grid
                div(.class("grid grid-cols-7")) {
                    template(.x.loop("blankDay in datePickerBlankDaysInMonth")) {
                        div(.class("p-1 text-sm text-center border border-transparent")) {
                            ""
                        }
                    }
                    template(.x.loop("(day, dayIndex) in datePickerDaysInMonth"), .x.bind("key", "dayIndex")) {
                        div(.class("px-0.5 mb-1 aspect-square")) {
                            div(
                                .x.text("day"),
                                .x.on("click", "datePickerDayClicked(day)"),
                                .x.bindClass(
                                    """
                                    { \
                                    'bg-neutral-200': datePickerIsToday(day) == true, \
                                    'text-gray-600 hover:bg-neutral-200': datePickerIsToday(day) == false && datePickerIsSelectedDate(day) == false, \
                                    'bg-neutral-800 text-white hover:bg-neutral-800/70': datePickerIsSelectedDate(day) == true \
                                    }
                                    """
                                ),
                                .class(
                                    "flex justify-center items-center w-7 h-7 text-sm leading-none text-center rounded-full cursor-pointer"
                                )
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
