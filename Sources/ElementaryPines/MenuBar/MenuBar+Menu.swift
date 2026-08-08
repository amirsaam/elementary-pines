import Foundation

/// A named menu (File, Edit, …) inside a `pinesMenuBar`.
public struct PinesMenuBarMenu: Sendable {
    /// The menu's button label and the key used in the Alpine state.
    public let title: String
    /// The rows shown when the menu is open.
    public let items: [PinesMenuBarContent]

    public init(title: String, items: [PinesMenuBarContent]) {
        self.title = title
        self.items = items
    }
}
