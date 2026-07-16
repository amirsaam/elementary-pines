import Elementary

/// Emits the `<style>` blocks that Pines **always** needs in the document
/// `<head>`. Today that's just the `[x-cloak]` hide rule — every Pines
/// component with an animated reveal (accordion, modal, dropdown, etc.)
/// emits `x-cloak` and breaks visibly without this rule present.
///
/// Tailwind + Alpine wiring is **not** the package's concern — see
/// README → Installation for the snippet you put in your `head` alongside
/// this call.
///
/// **Generated HTML:**
/// ```html
/// <style>[x-cloak] { display: none !important; }</style>
/// ```
///
/// **Example:**
/// ```swift
/// var head: some HTML {
///     meta(.charset(.utf8))
///     setupPines()
///     script(.src("https://cdn.tailwindcss.com")) {}
///     setupAlpine(plugins: [.collapse, .focus, .anchor])
/// }
/// ```
public func setupPines() -> some HTML {
    style { "[x-cloak] { display: none !important; }" }
}
