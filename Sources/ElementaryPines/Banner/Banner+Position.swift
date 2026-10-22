/// Vertical placement for `pinesBanner(label:message:href:icon:dismissible:position:)`.
///
/// The placement is purely positional: both variants render the same
/// theme-surface banner, one fixed to the top of the page sliding down on
/// enter, the other fixed to the bottom sliding up on enter.
public enum PinesBannerPosition: Sendable {
    /// Theme-surface banner, `fixed top-0`, slides in from above (the default).
    case top
    /// Theme-surface banner, `fixed bottom-0`, slides in from below.
    case bottom
}
