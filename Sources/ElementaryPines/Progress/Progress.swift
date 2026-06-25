import Elementary

/// Renders a horizontal progress bar at the given value (out of `of`).
///
/// The bar consists of a full-width track in a light shade of the color and
/// a fill bar in a medium shade, with the fill width set via inline `style`
/// to the computed percentage (clamped to 0–100).
///
/// **Generated HTML:**
/// ```html
/// <div class="w-full bg-blue-200 rounded-full h-2.5">
///     <div class="bg-blue-500 h-2.5 rounded-full" style="width: 45%"></div>
/// </div>
/// ```
///
/// **Example:**
/// ```swift
/// pinesProgress(45)                                  // 45% blue, md
/// pinesProgress(9, of: 20)                           // 45% blue, md
/// pinesProgress(75, color: .green)                   // 75% green
/// pinesProgress(30, color: .red, size: .lg)          // 30% red, 16px
/// ```
public func pinesProgress(
    _ value: Int,
    of max: Int = 100,
    color: PinesColor = .blue,
    size: PinesProgressSize = .md
) -> some HTML {
    let percent = max > 0 ? Swift.max(0, Swift.min(100, value * 100 / max)) : 0
    let track = "bg-\(color.rawValue)-200"
    let bar = "bg-\(color.rawValue)-500"

    return div(.class("w-full \(track) rounded-full \(size.heightClass)")) {
        div(.class("\(bar) \(size.heightClass) rounded-full"), .style("width: \(percent)%")) {}
    }
}
