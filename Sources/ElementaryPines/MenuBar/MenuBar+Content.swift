import Foundation

/// An entry inside a `PinesMenuBarMenu` — either an item or a separator.
public enum PinesMenuBarContent: Sendable {
    case item(PinesMenuBarItem)
    case separator
}
