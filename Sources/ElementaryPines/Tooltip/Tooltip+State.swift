import Elementary
import ElementaryAlpine

enum PinesTooltipState {
    static func positionBinding() -> HTMLAttributeValue.Alpine.BindClass {
        pinesAlpineBindClass([
            ("top-0 left-1/2 -translate-x-1/2 -mt-0.5 -translate-y-full", "tooltipPosition == 'top'"),
            ("top-1/2 -translate-y-1/2 -ml-0.5 left-0 -translate-x-full", "tooltipPosition == 'left'"),
            ("bottom-0 left-1/2 -translate-x-1/2 -mb-0.5 translate-y-full", "tooltipPosition == 'bottom'"),
            ("top-1/2 -translate-y-1/2 -mr-0.5 right-0 translate-x-full", "tooltipPosition == 'right'"),
        ])
    }

    static func arrowBinding() -> HTMLAttributeValue.Alpine.BindClass {
        pinesAlpineBindClass([
            ("bottom-0 -translate-x-1/2 left-1/2 w-2.5 translate-y-full", "tooltipPosition == 'top'"),
            ("right-0 -translate-y-1/2 top-1/2 h-2.5 -mt-px translate-x-full", "tooltipPosition == 'left'"),
            ("top-0 -translate-x-1/2 left-1/2 w-2.5 -translate-y-full", "tooltipPosition == 'bottom'"),
            ("left-0 -translate-y-1/2 top-1/2 h-2.5 -mt-px -translate-x-full", "tooltipPosition == 'right'"),
        ])
    }

    static func arrowSquareBinding() -> HTMLAttributeValue.Alpine.BindClass {
        pinesAlpineBindClass([
            ("origin-top-left -rotate-45", "tooltipPosition == 'top'"),
            ("origin-top-left rotate-45", "tooltipPosition == 'left'"),
            ("origin-bottom-left rotate-45", "tooltipPosition == 'bottom'"),
            ("origin-top-right -rotate-45", "tooltipPosition == 'right'"),
        ])
    }
}
