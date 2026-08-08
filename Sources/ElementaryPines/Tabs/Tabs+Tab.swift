import Elementary

/// A tab title and its rendered content.
public struct PinesTab: Sendable {
    /// The label shown in the tab button.
    public let title: String
    let content: @Sendable () -> HTMLRaw

    /// Creates a tab.
    public init(title: String, @ContentBuilder content: @escaping @Sendable () -> any HTML) {
        self.title = title
        self.content = { HTMLRaw(content().render()) }
    }
}
