/// Icon policy for `pinesAlert(_:icon:content:)`.
///
/// The variant overload of `pinesAlert` accepts an icon policy to control
/// whether (and which) icon is auto-inserted as the first child of the
/// alert container:
///
/// ```swift
/// pinesAlert(.info)                                  // auto-insert pinesIcon(.info, size: .sm)
/// pinesAlert(.info, icon: .none)                     // no icon
/// pinesAlert(.info, icon: .custom("/icons/my.svg")) // user-provided SVG file path
/// ```
///
/// Use `.auto` for the variant's default icon. Use `.none` to omit the
/// icon entirely. Use `.custom(path:)` to render a user-provided SVG file
/// (via `<img src="path" class="w-4 h-4">`).
public enum PinesAlertIcon: Sendable {
    /// Use the default icon for the variant
    /// (info→`.info`, success→`.check`, warning→`.warning`, danger→`.x`).
    case auto
    /// Do not insert an icon. The user provides the entire content.
    case none
    /// Render a user-provided SVG file via `<img src="path" class="w-4 h-4">`.
    case custom(path: String)
}
