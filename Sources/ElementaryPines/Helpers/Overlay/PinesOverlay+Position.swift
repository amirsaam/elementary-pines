import Elementary
import ElementaryTailwind

func pinesOverlayVerticalAttributes(isAbove: Bool) -> [HTMLAttribute<HTMLTag.div>] {
    if isAbove {
        return [.insetBottom(.full), .marginBottom(.size(1))]
    }
    return [.insetTop(.full), .marginTop(.size(1))]
}

func pinesOverlayHorizontalAttributes(
    for alignment: PinesOverlayHorizontalAlignment
) -> [HTMLAttribute<HTMLTag.div>] {
    switch alignment {
    case .start: return [.insetLeft(.zero)]
    case .center: return [.insetLeft(.fraction("1/2")), .translate(.x("1/2"), negative: true)]
    case .end: return [.insetRight(.zero)]
    }
}

/// Horizontal alignment of an overlay panel relative to its trigger.
public enum PinesOverlayHorizontalAlignment: Sendable, CaseIterable, Equatable {
    /// Aligns the panel's leading edge with the trigger.
    case start
    /// Centers the panel over the trigger.
    case center
    /// Aligns the panel's trailing edge with the trigger.
    case end
}
