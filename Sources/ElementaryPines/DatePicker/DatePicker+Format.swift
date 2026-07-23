/// Date format patterns supported by `pinesDatePicker`.
///
/// Each case maps to a `datePickerFormat` string in the Pines UI date picker
/// Alpine state. The format controls how the selected date is displayed in
/// the input field.
public enum PinesDatePickerFormat: String, Sendable {
    /// `"M d, Y"` — abbreviated month, e.g. `Jul 21, 2026`.
    case monthDayYear = "M d, Y"
    /// `"MM-DD-YYYY"` — numeric, e.g. `07-21-2026`.
    case mmDdYyyy = "MM-DD-YYYY"
    /// `"DD-MM-YYYY"` — numeric, e.g. `21-07-2026`.
    case ddMmYyyy = "DD-MM-YYYY"
    /// `"YYYY-MM-DD"` — ISO 8601, e.g. `2026-07-21`.
    case iso8601 = "YYYY-MM-DD"
    /// `"D d M, Y"` — full day name, e.g. `Tuesday 21 Jul, 2026`.
    case dayMonthYear = "D d M, Y"
}
