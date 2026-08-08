import Foundation

/// Where the `pinesPopover` panel prefers to open relative to the trigger.
///
/// The panel auto-flips to the other side when there is not enough viewport
/// space, mirroring Pines UI. Defaults to `.bottom`.
public enum PinesPopoverPosition: String, Sendable {
    case top
    case bottom
}
