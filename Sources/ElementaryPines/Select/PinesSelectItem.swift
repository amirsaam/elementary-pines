/// A single option in a `pinesSelect` dropdown.
///
/// The fields map directly to the shape the Pines Select Alpine state
/// expects: `title` is the human-readable label, `value` is the form
/// submission value (also used to build the per-item `id` attribute), and
/// `disabled` marks the option as non-selectable.
///
/// `PinesSelectItem` is `Codable` so `pinesSelect` can JSON-encode the
/// items array into the `x-data` attribute.
public struct PinesSelectItem: Equatable, Codable {
    public let title: String
    public let value: String
    public let disabled: Bool

    public init(title: String, value: String, disabled: Bool = false) {
        self.title = title
        self.value = value
        self.disabled = disabled
    }
}
