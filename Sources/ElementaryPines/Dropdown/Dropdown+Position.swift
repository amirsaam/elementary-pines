import Elementary
import ElementaryTailwind

/// Where the dropdown panel is anchored relative to the trigger button.
public enum PinesDropdownPosition: Sendable {
    case belowStart
    case belowCenter
    case belowEnd
    case aboveStart
    case aboveCenter
    case aboveEnd

    /// Positional Tailwind attributes for the panel.
    var attributes: [HTMLAttribute<HTMLTag.div>] {
        let isAbove = self == .aboveStart || self == .aboveCenter || self == .aboveEnd
        var attrs = pinesOverlayVerticalAttributes(isAbove: isAbove)
        let alignment: PinesOverlayHorizontalAlignment =
            switch self {
            case .belowStart, .aboveStart: .start
            case .belowCenter, .aboveCenter: .center
            case .belowEnd, .aboveEnd: .end
            }
        attrs += pinesOverlayHorizontalAttributes(for: alignment)
        return attrs
    }
}
