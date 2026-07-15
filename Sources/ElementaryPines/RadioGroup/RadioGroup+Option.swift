import Foundation

/// A single option in a `pinesRadioGroup`.
///
/// `title` is the human-readable label, `value` is the form submission value,
/// and `description` is an optional explanation shown beneath the title.
///
/// `PinesRadioGroupOption` is `Codable` so `pinesRadioGroup` can JSON-encode
/// the options array into the `x-data` attribute. The custom `encode(to:)`
/// writes an empty string for a missing `description` so Alpine's `x-text`
/// never renders the literal text `"null"`.
public struct PinesRadioGroupOption: Codable, Equatable, Sendable {
    public let title: String
    public let value: String
    public let description: String?
    public let disabled: Bool

    public init(title: String, value: String, description: String? = nil, disabled: Bool = false) {
        self.title = title
        self.value = value
        self.description = description
        self.disabled = disabled
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(value, forKey: .value)
        try container.encode(description ?? "", forKey: .description)
        try container.encode(disabled, forKey: .disabled)
    }
}
