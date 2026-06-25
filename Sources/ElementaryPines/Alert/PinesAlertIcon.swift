/// Icon policy for `pinesAlert(_:icon:content:)`.
///
/// The variant overload of `pinesAlert` accepts an icon policy to control
/// whether (and which) icon is auto-inserted as the first child of the
/// alert container:
///
/// ```swift
/// pinesAlert(.info)                    // auto-insert pinesIcon(.info, size: .sm)
/// pinesAlert(.info, icon: .none)       // no icon
/// pinesAlert(.info, icon: .custom(.warning))  // override default
/// ```
public enum PinesAlertIcon: Sendable {
    /// Use the default icon for the variant
    /// (info→`.info`, success→`.check`, warning→`.warning`, danger→`.x`).
    case auto
    /// Do not insert an icon. The user provides the entire content.
    case none
    /// Insert a custom icon instead of the variant's default.
    case custom(PinesIconKind)
}
