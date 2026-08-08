import Elementary
import ElementaryTailwind

/// Emits the `<style>` blocks that Pines **always** needs in the document
/// `<head>`: the `[x-cloak]` hide rule plus the semantic color tokens that
/// theme every component's surfaces.
///
/// - `accent:` seeds the theme's brand tokens (`--color-ring`,
///   `--color-primary`). Defaults to `.neutral`.
/// - `bgLight:`/`bgDark:` set `--color-background` in light and dark mode.
///   Defaults to white / near-black (`neutral-950`), the Pines surfaces.
///
/// The remaining tokens (`foreground`, `border`, `muted`,
/// `muted-foreground`) derive from neutral pairs, and dark mode is driven by
/// `prefers-color-scheme`. All values chain to Tailwind v4's own palette
/// variables (`var(--color-neutral-400)`, …), so overriding your Tailwind
/// palette re-themes the components automatically. This unlayered `<style>`
/// wins over Tailwind's `@layer theme` defaults.
///
/// Tailwind + Alpine wiring is **not** the package's concern — see
/// README → Installation for the snippet you put in your `head` alongside
/// this call.
///
/// **Generated HTML:**
/// ```html
/// <style>
/// [x-cloak] { display: none !important; }
/// :root {
///   --color-background: var(--color-white);
///   --color-foreground: var(--color-neutral-950);
///   --color-border: var(--color-neutral-200);
///   --color-muted: var(--color-neutral-100);
///   --color-muted-foreground: var(--color-neutral-500);
///   --color-ring: var(--color-neutral-400);
///   --color-primary: var(--color-neutral-600);
///   --color-primary-foreground: var(--color-white);
/// }
/// @media (prefers-color-scheme: dark) {
///   :root {
///     --color-background: var(--color-neutral-950);
///     --color-foreground: var(--color-neutral-50);
///     --color-border: var(--color-neutral-800);
///     --color-muted: var(--color-neutral-900);
///     --color-muted-foreground: var(--color-neutral-400);
///     --color-ring: var(--color-neutral-400);
///     --color-primary: var(--color-neutral-600);
///     --color-primary-foreground: var(--color-white);
///   }
/// }
/// </style>
/// ```
///
/// **Example:**
/// ```swift
/// var head: some HTML {
///     meta(.charset(.utf8))
///     setupPines(accent: .neutral, bgLight: .white, bgDark: .neutral.shade(950))
///     script(.src("https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4")) {}
///     setupAlpine(plugins: [.collapse, .focus, .anchor])
/// }
/// ```
public func setupPines(
    accent: PinesColor = .neutral,
    bgLight: TWColor = .white,
    bgDark: TWColor = .neutral.shade(950)
) -> some HTML {
    style {
        "[x-cloak] { display: none !important; }\n"
            + pinesThemeVariables(accent: accent, bgLight: bgLight, bgDark: bgDark)
    }
}

private func pinesThemeVariables(accent: PinesColor, bgLight: TWColor, bgDark: TWColor) -> String {
    """
    :root {
      --color-background: \(pinesCSSColor(bgLight));
      --color-foreground: var(--color-neutral-950);
      --color-border: var(--color-neutral-200);
      --color-muted: var(--color-neutral-100);
      --color-muted-foreground: var(--color-neutral-500);
      --color-ring: var(--color-\(accent.rawValue)-400);
      --color-primary: var(--color-\(accent.rawValue)-600);
      --color-primary-foreground: var(--color-white);
    }
    @media (prefers-color-scheme: dark) {
      :root {
        --color-background: \(pinesCSSColor(bgDark));
        --color-foreground: var(--color-neutral-50);
        --color-border: var(--color-neutral-800);
        --color-muted: var(--color-neutral-900);
        --color-muted-foreground: var(--color-neutral-400);
        --color-ring: var(--color-\(accent.rawValue)-400);
        --color-primary: var(--color-\(accent.rawValue)-600);
        --color-primary-foreground: var(--color-white);
      }
    }
    """
}

/// Maps a `TWColor` to a CSS value: a `var(--color-*)` reference for palette
/// colors, or the raw value for arbitrary colors.
private func pinesCSSColor(_ color: TWColor) -> String {
    let palette = color.palette
    if palette.hasPrefix("[") && palette.hasSuffix("]") {
        return String(palette.dropFirst().dropLast())
    }
    if let shade = color.shade {
        return "var(--color-\(palette)-\(shade))"
    }
    return "var(--color-\(palette))"
}
