import Foundation

/// A single selectable entry in a `pinesCommand` palette.
///
/// `icon` is a Heroicon rendered inside the row; `shortcut` is a right-aligned
/// keyboard hint. `category` groups items under a capitalized heading.
/// `isDefault` controls whether the item shows when the search is empty, and
/// `disabled` marks the row inert. `action` is an Alpine expression run when
/// the item is selected.
public struct PinesCommandItem: Sendable {
    /// The row label, also used for search filtering.
    public let title: String
    /// A stable identifier used for the row's `id` and active detection.
    public let value: String
    /// An optional leading Heroicon.
    public let icon: PinesIconKind?
    /// An optional right-aligned keyboard hint (e.g. `"⌘P"`).
    public let shortcut: String?
    /// The category heading under which the row is grouped.
    public let category: String
    /// When `true`, the item is listed while the search is empty.
    public let isDefault: Bool
    /// When `true`, the row is inert (`data-disabled`) and faded.
    public let disabled: Bool
    /// An optional Alpine expression run on selection.
    public let action: String?

    public init(
        title: String,
        value: String,
        icon: PinesIconKind? = nil,
        shortcut: String? = nil,
        category: String = "",
        isDefault: Bool = true,
        disabled: Bool = false,
        action: String? = nil
    ) {
        self.title = title
        self.value = value
        self.icon = icon
        self.shortcut = shortcut
        self.category = category
        self.isDefault = isDefault
        self.disabled = disabled
        self.action = action
    }
}
