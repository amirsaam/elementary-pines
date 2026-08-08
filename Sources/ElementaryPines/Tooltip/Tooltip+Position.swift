import Foundation

/// The placement of a Pines tooltip relative to its trigger.
public enum PinesTooltipPosition: String, Sendable {
    /// Places the tooltip above the trigger.
    case top
    /// Places the tooltip to the left of the trigger.
    case left
    /// Places the tooltip below the trigger.
    case bottom
    /// Places the tooltip to the right of the trigger.
    case right
}
