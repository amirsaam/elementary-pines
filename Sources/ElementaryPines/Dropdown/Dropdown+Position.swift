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
        let above = self == .aboveStart || self == .aboveCenter || self == .aboveEnd
        var attrs: [HTMLAttribute<HTMLTag.div>] = []
        if above {
            attrs.append(.insetBottom(.full))
            attrs.append(.marginBottom(.size(12)))
        } else {
            attrs.append(.insetTop(.zero))
            attrs.append(.marginTop(.size(12)))
        }
        switch self {
        case .belowStart, .aboveStart:
            attrs.append(.insetLeft(.zero))
        case .belowCenter, .aboveCenter:
            attrs.append(.insetLeft(.fraction("1/2")))
            attrs.append(.translate(.x("1/2"), negative: true))
        case .belowEnd, .aboveEnd:
            attrs.append(.insetRight(.zero))
        }
        return attrs
    }
}
