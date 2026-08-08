import Foundation

/// A single selectable row in a `pinesMenuBar` menu.
public struct PinesMenuBarItem: Sendable {
    /// The row label.
    public let title: String
    /// An optional keyboard-shortcut hint rendered right-aligned.
    public let shortcut: String?
    /// When `true`, the row is inert (`data-disabled`) and faded.
    public let disabled: Bool
    /// An optional Alpine expression run on click, after the menu closes.
    public let action: String?

    public init(title: String, shortcut: String? = nil, disabled: Bool = false, action: String? = nil) {
        self.title = title
        self.shortcut = shortcut
        self.disabled = disabled
        self.action = action
    }
}
