import Elementary

/// Separator style for `pinesBreadcrumb(_:separator:homeIcon:)`.
public enum PinesBreadcrumbSeparator: Sendable {
    /// Right chevron (`pinesIcon(.chevronRight)`) — the official Pines style.
    case chevron
    /// Forward slash character.
    case slash
    /// Right arrow character.
    case arrow
}
