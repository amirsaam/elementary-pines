import Foundation

/// A title and body pair rendered by `pinesAccordion`.
public struct PinesAccordionItem: Sendable, Equatable {
    /// The visible accordion heading.
    public let title: String
    /// The content revealed when the item is active.
    public let body: String

    /// Creates an accordion item.
    public init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
