/// Vertical placement for `pinesBanner(label:message:href:icon:dismissible:position:)`.
///
/// Matches the two official Pines banner examples: a white banner fixed to
/// the top of the page that slides down on enter, or a black banner fixed to
/// the bottom that slides up on enter.
public enum PinesBannerPosition: Sendable {
    /// White banner, `fixed top-0`, slides in from above (the default).
    case top
    /// Black banner, `fixed bottom-0`, slides in from below.
    case bottom
}
