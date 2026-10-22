import ElementaryTailwind

/// The panel width of a slide-over.
///
/// `.default` matches the Pines slide-over's `max-w-md`, `.half` is half the
/// viewport width, and `.full` uses ninety percent of the viewport.
///
/// The widths are viewport-relative rather than percentages: the panel sits
/// inside a right-anchored, shrink-to-fit container, so a percentage
/// `max-width` would resolve against an indefinite width, collapse to none
/// and let the panel span the whole viewport from the leading edge.
public enum PinesSlideOverSize: String, Sendable, Equatable, CaseIterable {
    /// `max-w-md` — the Pines default width.
    case `default`
    /// Half the viewport width.
    case half
    /// Ninety percent of the viewport width.
    case full

    /// The width utility applied to the panel.
    var width: TWTWidth {
        switch self {
        case .default: .screen
        case .half: .arbitrary("50vw")
        case .full: .arbitrary("90vw")
        }
    }

    /// The `max-width` utility applied to the panel, when it has one.
    var maxWidth: TWTMaxWidth? {
        switch self {
        case .default: .md
        case .half, .full: nil
        }
    }
}
