import Foundation

/// Style variant for `pinesCheckbox`.
///
/// - `.default`: Basic checkbox with sibling label. Requires `labelText`.
/// - `.card`: Peer-checked card — hidden input with card-styled label.
/// - `.custom`: Peer-checked custom — hidden input, user provides `labelClasses`
///   for `peer-checked:` and `[&_...]` Tailwind utilities on the label.
public enum PinesCheckboxStyle: Sendable, CaseIterable {
    case `default`
    case card
    case custom
}
