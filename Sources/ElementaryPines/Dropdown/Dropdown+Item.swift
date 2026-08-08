import Foundation

/// A single entry in a `pinesDropdown` menu.
///
/// Renders a `<a>` when `href` is provided, otherwise a `<div>`. `icon` is a
/// Heroicon rendered via ``pinesIcon(_:size:color:attributes:)``; `shortcut`
/// is a right-aligned keyboard hint. `disabled` items render with
/// `data-disabled` and the Pines `data-[disabled]` utilities. `danger` items
/// override the dropdown's color with red text and a red hover. Items are
/// focusable and participate in the dropdown's arrow-key navigation.
public struct PinesDropdownItem: Sendable {
    public let title: String
    public let icon: PinesIconKind?
    public let shortcut: String?
    public let disabled: Bool
    public let href: String?
    public let action: String?
    public let closeOnSelect: Bool
    public let danger: Bool

    public init(
        title: String,
        icon: PinesIconKind? = nil,
        shortcut: String? = nil,
        disabled: Bool = false,
        href: String? = nil,
        action: String? = nil,
        closeOnSelect: Bool = true,
        danger: Bool = false
    ) {
        self.title = title
        self.icon = icon
        self.shortcut = shortcut
        self.disabled = disabled
        self.href = href
        self.action = action
        self.closeOnSelect = closeOnSelect
        self.danger = danger
    }
}
