import Elementary
import ElementaryTailwind

/// Emits the `<style>` blocks that Pines **always** needs in the document
/// `<head>`: the `[x-cloak]` hide rule plus the semantic color tokens that
/// theme every component's surfaces.
///
/// - `accent:` seeds the theme's brand tokens (`--color-ring`,
///   `--color-primary`, and `--color-primary-foreground`). Defaults to
///   `.neutral`.
/// - `bgLight:`/`bgDark:` set `--color-background` in light and dark mode.
///   Defaults to white / near-black (`neutral-950`), the Pines surfaces.
///
/// The remaining tokens (`foreground`, `border`, `muted`, `muted-foreground`)
/// derive from neutral pairs, and dark mode is driven by
/// `prefers-color-scheme`. The tokens are emitted as references to the
/// supported Tailwind palette values inside a Tailwind `@theme` block, so Tailwind registers
/// `bg-background`, `text-foreground`, `border-border`, `bg-muted`,
/// `text-muted-foreground`, and `ring-ring` as real utilities.
///
/// The `@theme` block is processed by the Tailwind v4 **browser** build
/// (`<style type="text/tailwindcss">`). CLI users should add the same tokens
/// to their own `@theme` in CSS — see README → Setup.
///
/// Tailwind + Alpine wiring is **not** the package's concern — see
/// README → Installation for the snippet you put in your `head` alongside
/// this call.
///
/// **Generated HTML:**
/// ```html
/// <style type="text/tailwindcss">
/// @theme {
///   --color-background: #fff;
///   --color-foreground: var(--color-neutral-950);
///   --color-border: var(--color-neutral-200);
///   --color-muted: var(--color-neutral-100);
///   --color-muted-foreground: var(--color-neutral-500);
///   --color-ring: var(--color-neutral-400);
///   --color-primary: var(--color-neutral-950);
///   --color-primary-foreground: #fff;
/// }
/// </style>
/// <style>
/// [x-cloak] { display: none !important; }
/// @media (prefers-color-scheme: dark) {
///   :root {
///     --color-background: var(--color-neutral-950);
///     --color-foreground: var(--color-neutral-50);
///     --color-border: var(--color-neutral-800);
///     --color-muted: var(--color-neutral-900);
///     --color-muted-foreground: var(--color-neutral-400);
///     --color-ring: var(--color-neutral-400);
///     --color-primary: var(--color-neutral-50);
///     --color-primary-foreground: var(--color-neutral-950);
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
    Group {
        style(HTMLAttribute<HTMLTag.style>(name: "type", value: "text/tailwindcss")) {
            pinesThemeTokens(accent: accent, bgLight: bgLight, bgDark: bgDark)
        }
        style {
            "[x-cloak] { display: none !important; }\n"
                + pinesThemeDarkOverrides(accent: accent, bgDark: bgDark)
        }
    }
}

private func pinesThemeTokens(accent: PinesColor, bgLight: TWColor, bgDark: TWColor) -> String {
    """
    @theme {
      --color-background: \(pinesCSSColor(bgLight));
      --color-foreground: \(pinesNeutralShade(950));
      --color-border: \(pinesNeutralShade(200));
      --color-muted: \(pinesNeutralShade(100));
      --color-muted-foreground: \(pinesNeutralShade(500));
      --color-ring: \(pinesCSSColor(TWColor(accent.rawValue, 400)));
      --color-primary: \(pinesCSSColor(accent.solidButtonScale.bg));
      --color-primary-foreground: #fff;
    }
    """
}

private func pinesThemeDarkOverrides(accent: PinesColor, bgDark: TWColor) -> String {
    let primary = accent == .neutral ? accent.shade(.tint1) : accent.solidButtonScale.bg
    let primaryForeground = accent == .neutral ? accent.shade(.darkest) : .white

    return """
        @media (prefers-color-scheme: dark) {
          :root {
            --color-background: \(pinesCSSColor(bgDark));
            --color-foreground: \(pinesNeutralShade(50));
            --color-border: \(pinesNeutralShade(800));
            --color-muted: \(pinesNeutralShade(900));
            --color-muted-foreground: \(pinesNeutralShade(400));
            --color-ring: \(pinesCSSColor(TWColor(accent.rawValue, 400)));
            --color-primary: \(pinesCSSColor(primary));
            --color-primary-foreground: \(pinesCSSColor(primaryForeground));
          }
        }
        """
}

/// Resolves a `neutral` palette shade to its Tailwind CSS variable.
private func pinesNeutralShade(_ shade: Int) -> String {
    pinesCSSColor(TWColor("neutral", shade))
}

/// Maps a supported `TWColor` to a CSS variable from the Pines palette.
private func pinesCSSColor(_ color: TWColor) -> String {
    let palette = color.palette
    if palette == "white" { return "#fff" }
    if palette == "black" { return "#000" }
    if palette == "transparent" { return "transparent" }
    if let pinesColor = PinesColor(rawValue: palette), let shade = color.shade {
        return pinesColor.cssValues[shade] ?? "transparent"
    }
    return "transparent"
}
