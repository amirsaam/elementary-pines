import Foundation

/// An entry in a `pinesDropdown` menu: either an item or a separator.
public enum PinesDropdownContent: Sendable {
    case item(PinesDropdownItem)
    case separator
}

/// A dropdown menu entry produced by a `pinesDropdown` `items:` closure.
public func pinesDropdownItem(_ item: PinesDropdownItem) -> PinesDropdownContent {
    .item(item)
}

/// A dropdown menu separator produced by a `pinesDropdown` `items:` closure.
public func pinesDropdownSeparator() -> PinesDropdownContent {
    .separator
}
