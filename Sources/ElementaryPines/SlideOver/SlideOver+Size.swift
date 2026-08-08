import ElementaryTailwind

/// The panel width of a slide-over.
///
/// `.default` matches the Pines slide-over's `max-w-md`, `.half` is half the
/// viewport width (`max-w-1/2`), and `.full` spans the viewport (`max-w-full`).
public enum PinesSlideOverSize: String, Sendable, Equatable, CaseIterable {
    /// `max-w-md` — the Pines default width.
    case `default`
    /// `max-w-1/2` — half the viewport width.
    case half
    /// `max-w-full` — spans the viewport.
    case full

    var maxWidth: TWTMaxWidth {
        switch self {
        case .default: .md
        case .half: .fraction("1/2")
        case .full: .full
        }
    }
}
