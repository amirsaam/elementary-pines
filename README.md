# Pines + Elementary: The Alpine and Tailwind UI Library in Swift

Type-safe [Pines UI](https://devdojo.com/pines) components for [Elementary](https://github.com/elementary-swift/elementary) — the Alpine.js + Tailwind UI library, rendered directly from Swift on Server.

```swift
import Elementary
import ElementaryPines

struct ProductPage: HTMLDocument {
    var title: String { "Featured product" }

    var body: some HTML {
        main(.class("max-w-2xl mx-auto p-8")) {
            pinesCard {
                div(.class("p-7")) {
                    h2 { "Featured product" }
                    p { "A short description of the product." }
                    button { "Add to cart" }
                        .pinesButtonStyle(.solid, color: .blue)
                }
            }
        }
    }
}
```

**Generated HTML:**

```html
<main class="max-w-2xl mx-auto p-8">
    <div class="rounded-lg overflow-hidden border border-neutral-200/60 bg-white text-neutral-700 shadow-sm">
        <div class="p-7">
            <h2>Featured product</h2>
            <p>A short description of the product.</p>
            <button class="inline-flex items-center justify-center px-4 py-2 text-sm font-medium tracking-wide text-white transition-colors duration-200 rounded-md bg-blue-600 hover:bg-blue-700 focus:ring-4 focus:outline-none focus:ring-blue-700">Add to cart</button>
        </div>
    </div>
</main>
```

## Use it

Add `ElementaryPines` to your `Package.swift` dependencies:

```swift
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "MyApp",
    dependencies: [
        .package(url: "https://github.com/amirsaam/elementary-pines.git", from: "0.1.100"),
        .package(url: "https://github.com/elementary-swift/elementary.git", from: "0.7.0"),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Elementary", package: "elementary"),
                .product(name: "ElementaryPines", package: "elementary-pines"),
            ]
        ),
    ]
)
```

This package requires Swift 6 with `StrictConcurrency=complete` and targets macOS v14, iOS v15, tvOS v17, watchOS v10.

## Quick tour

```swift
// call `pinesSetup()` once in your document head — emits the [x-cloak] rule
// that hides elements before Alpine.js hydrates them
import ElementaryPines

var head: some HTML {
    meta(.charset(.utf8))
    script(.src("https://cdn.tailwindcss.com")) {}
    pinesSetup()
    setupAlpine(plugins: [.collapse, .focus])
}

// 11 colors via the shared `PinesColor` enum
button { "Save" }.pinesButtonStyle(.solid, color: .blue)        // .amber, .blue, .gray, .green, .indigo, .neutral, .orange, .pink, .purple, .red, .yellow
span { "New" }.pinesBadgeStyle(.light, color: .amber)

// 35 icons × 5 sizes, Heroicons paths
pinesIcon(.check, size: .sm)        // .xs, .sm, .md, .lg, .xl
pinesIcon(.warning, color: .red)

// extra attributes — pass Alpine directives or extra classes; classes merge
pinesIcon(.check, attributes: [.class("ml-2")])
pinesIcon(.check, attributes: [.x.show("isVisible")])
```

```swift
// 3 button styles
button { "Save" }.pinesButtonStyle(.solid)              // dark background, white text
button { "Cancel" }.pinesButtonStyle(.tonal, color: .red)  // light tinted background
button { "Delete" }.pinesButtonStyle(.outline)           // transparent, colored border
```

```swift
// 4 card variants — same pattern as the original `pines/elements/card.html`
pinesCard {
    div(.class("p-7")) { h2 { "Title" }; p { "Body" } }
}

pinesCard(.image, image: "photo.jpg") {
    h3 { "Title" }
    p { "Body" }
}

pinesCard(.stat) {
    p(.class("text-3xl font-bold")) { "1,234" }
    p(.class("text-sm text-neutral-500")) { "Total users" }
}
```

```swift
// 4 alert variants — auto-inserts the matching icon, override with `.custom(...)`
pinesAlert(.info) {
    h5 { "Heads up" }
    p { "Something happened." }
}

pinesAlert(.danger, icon: .custom(path: "/icons/spinner.svg")) {
    h5 { "Error" }
    p { "Something went wrong." }
}
```

```swift
// 3 progress sizes, 11 colors; percentage is clamped to 0–100
pinesProgress(75, color: .green)              // default .md (h-2.5)
pinesProgress(30, color: .red, size: .lg)     // h-4
pinesProgress(9, of: 20)                     // 9 out of 20 = 45%
```

```swift
// banner with optional icon and dismiss button
pinesBanner(icon: .kind(.info)) {
    p { "New version available." }
}

pinesBanner(icon: .kind(.warning), dismissible: true) {
    p { "Your session is about to expire." }
}

pinesBanner(icon: .custom(path: "/icons/spinner.svg")) {
    p { "Loading…" }
}
```

```swift
// input — styled text input (type, placeholder, color, disabled, form attrs)
pinesInput(placeholder: "Name")

pinesInput(type: "email", placeholder: "Email", color: .blue)

pinesInput(type: "text", placeholder: "Search...", name: "q", value: "pine", id: "search")

pinesInput(placeholder: "Disabled", disabled: true)
```

```swift
// textarea — styled multi-line input (placeholder, color, rows, form attrs)
pinesTextarea(placeholder: "Type your message here.")

pinesTextarea(placeholder: "Bio", color: .blue)

pinesTextarea(placeholder: "Comment", name: "comment", rows: 4)

pinesTextarea(placeholder: "Disabled", disabled: true)
```

```swift
// select — custom Alpine-driven dropdown (items, placeholder, width)
// Replaces the native <select>. Requires Alpine.js (call setupAlpine() once
// in <head>). Items are JSON-encoded into the x-data state and the dropdown
// uses $refs/$watch/$id for open/close, keyboard nav, and click-away.
pinesSelect(items: [
    .init(title: "Milk", value: "milk"),
    .init(title: "Eggs", value: "eggs"),
    .init(title: "Cheese", value: "cheese", disabled: true),
])

pinesSelect(items: fruits, placeholder: "Choose a fruit", width: "w-72")
```

```swift
// breadcrumb — manual items
pinesBreadcrumb([
    .link("Home", href: "/"),
    .link("Docs", href: "/docs"),
    .current("Installation"),
], separator: .chevron)

// breadcrumb — data-driven from a site map (Vapor, Hummingbird)
// The site map is declared once at app startup and shared across routes.
// The route handler passes the current request's path in.

// Vapor:
let siteMap: [PinesSiteMapEntry] = [
    .init(path: "/", label: "Home"),
    .init(path: "/docs", label: "Docs"),
    .init(path: "/docs/getting-started", label: "Getting Started"),
]
app.get("docs", "**") { req async throws -> View in
    let items = pinesBreadcrumbItems(for: req.url.path, in: siteMap)
    return try await req.view.render("docs", ["breadcrumb": items])
}

// Hummingbird:
let siteMap: [PinesSiteMapEntry] = [
    .init(path: "/", label: "Home"),
    .init(path: "/docs", label: "Docs"),
]
router.get("/docs/{path=}") { request, context -> Response in
    let items = pinesBreadcrumbItems(for: request.uri.path, in: siteMap)
    return try context.render("docs", with: ["breadcrumb": items])
}
```

```swift
// quote with optional avatar
pinesQuote(.withAvatar, avatar: "user.jpg") {
    p { "This is a great quote." }
    cite { "— Author Name" }
}
```

## Components

The package ships 11 free functions. Each wraps the matching Pines UI element with type-safe parameters.

| Function                        | Variants                                                                                       | Notes                                                    |
| ------------------------------- | ---------------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| `pinesSetup()`                 | —                                                                                              | Emits the `<style>[x-cloak]…` rule. Call once in `<head>`. |
| `PinesColor`                   | 11 cases: `amber, blue, gray, green, indigo, neutral, orange, pink, purple, red, yellow`     | Shared enum used by every color-accepting component.       |
| `.pinesButtonStyle(_:color:)`  | 3 styles × 11 colors = 33 variants                                                              | Modifier on `button`.                                    |
| `.pinesBadgeStyle(_:color:)`   | 5 styles × 11 colors = 55 variants                                                              | Modifier on `span`.                                      |
| `pinesCard(_:image:content:)`  | 4 variants: `.basic`, `.image(image:)`, `.horizontal(image:)`, `.stat`                       | `image:` required for `.image` and `.horizontal`.          |
| `pinesIcon(_:size:color:attributes:)`     | 35 kinds × 5 sizes = 175 variants; 11 colors; `attributes:` for extra classes / directives | Heroicons 2.x paths. Classes passed via `attributes:` merge with the default size/color class. |
| `pinesAlert(_:icon:content:)`  | 2 overloads: `pinesAlert { ... }` (basic) and `pinesAlert(.info, icon: .auto, ...) { ... }`    | `.auto` inserts the matching icon; `.none` omits; `.custom(path:)` renders a user-provided SVG file via `<img>`. |
| `pinesProgress(_:of:color:size:)` | 11 colors × 3 sizes (`.sm`, `.md`, `.lg`)                                                   | Percentage clamped to 0–100.                              |
| `pinesQuote(_:avatar:content:)` | 2 variants: `.basic`, `.withAvatar(avatar:)`                                                  | `avatar:` required for `.withAvatar`.                     |
| `pinesBreadcrumb(_:separator:)` | 3 separators: `.slash`, `.chevron` (default), `.arrow`                                       | See also `pinesBreadcrumbItems(for:in:root:)` for data-driven derivation. |
| `pinesBreadcrumbItems(for:in:root:)` | —                                                                                         | Derives items from a flat `(path, label)` site map and a current path. |
| `pinesBanner(icon:dismissible:content:)` | `PinesBannerIcon` with `.kind(PinesIconKind)` or `.custom(path: String)`  | Any of 35 built-in icons or a user-provided SVG file; close button uses `pinesIcon(.x)`. |
| `pinesInput(type:placeholder:color:name:value:id:disabled:)` | `String` type (e.g. `"text"`, `"email"`, `"password"`); color overrides the 300/400 border + ring pair | Tailwind-only — users add `x-data`/`x-model` on the call site for dynamic behavior. |
| `pinesTextarea(placeholder:color:name:id:rows:disabled:)` | `String?` placeholder; color overrides the 300/400 border + placeholder + ring pair | Tailwind-only — no built-in auto-resize; users add `x-data`/`x-model` on the call site. |
| `pinesSelect(items:placeholder:width:)` | `[PinesSelectItem]` (Codable, with `title`/`value`/`disabled`); any Tailwind width class | Alpine-driven — emits full `x-data` state, `x-init` (`$watch`), 5 `@keydown.*` handlers, `x-transition`, `x-cloak`, `x-for` template. Requires `setupAlpine()` in `<head>`. |

## Alpine integration

Pines UI was designed for [Alpine.js](https://alpinejs.dev/). The standard way to add Alpine directives to Elementary HTML is with the typed `.x.*` attribute helpers from [`elementary-alpinejs`](https://github.com/amirsaam/elementary-alpinejs) — they compile to the same HTML attributes and are verified by snapshot tests.

```swift
import Elementary
import ElementaryAlpine
import ElementaryPines

// x-text on a child of pinesAlert
pinesAlert(.info) {
    h5(.x.text("title")) { "Title" }
    p(.x.text("body")) { "Body" }
}

// x-on:click on a button before .pinesButtonStyle
button(.x.on("click", "count++")) { "Increment" }
    .pinesButtonStyle(.solid, color: .blue)

// x-data on a wrapper
div(.x.data("{ progress: 0 }")) {
    pinesProgress(0)
}
```

`elementary-alpinejs` also provides `setupAlpine(plugins:)` which emits the CDN `<script>` tags for Alpine.js core + plugins. Every Pines component preserves Alpine directives passed as attributes — `x-text`, `x-model`, `x-on:click`, `x-data`, `x-show`, and the rest all survive Elementary's renderer.

## Setup

The `pinesSetup()` function emits a single `<style>` block. Call it once in the document `<head>` — every Pines component that supports animation emits `x-cloak` and breaks visibly without this rule in place.

```swift
var head: some HTML {
    meta(.charset(.utf8))
    pinesSetup()
    script(.src("https://cdn.tailwindcss.com")) {}
    setupAlpine(plugins: [.collapse, .focus])
}
```

**Generated HTML:**

```html
<style>[x-cloak] { display: none !important; }</style>
```

If you can't (or don't want to) use a CDN, self-host the `tailwind.min.css` output of your project — the same as you would for any other Tailwind project. The class strings in every component are the standard Tailwind utility classes, not custom CSS.

## Color conventions

The `PinesColor` enum's 11 cases map to Tailwind's default color palette. Each case has a `(solid, hover, ring)` shade triple that follows the original Pines conventions:

| Shade range         | Colors                                            |
| ------------------- | ------------------------------------------------- |
| 600 / 700 (cool)    | `blue, red, green, indigo, pink, purple`         |
| 500 / 600 (warm)    | `amber, orange, yellow`                           |
| 700 / 800 (gray)    | `gray`                                            |
| 950 / 900 (neutral) | `neutral`                                         |

`.pinesButtonStyle(.solid, color: .neutral)` renders `bg-black` (per the original), not `bg-neutral-950`. `.pinesBadgeStyle(.solid, color: .neutral)` and `.icon, color: .neutral` follow the same special case.

## Documentation

The full API is documented in source — every public type and function has doc comments with a code example and a "Generated HTML" snippet showing the rendered output. For example, see:

- [`Sources/ElementaryPines/Pines/Pines.swift`](./Sources/ElementaryPines/Pines/Pines.swift) — `pinesSetup()`
- [`Sources/ElementaryPines/Button/ButtonStyle.swift`](./Sources/ElementaryPines/Button/ButtonStyle.swift) — `.pinesButtonStyle`
- [`Sources/ElementaryPines/Card/Card.swift`](./Sources/ElementaryPines/Card/Card.swift) — `pinesCard`
- [`Sources/ElementaryPines/Alert/AlertVariant.swift`](./Sources/ElementaryPines/Alert/AlertVariant.swift) — `pinesAlert`

The full test suite (60 snapshot tests + 6 Alpine directive smoke tests = 66 tests) lives in [`Tests/ElementaryPinesTests/`](./Tests/ElementaryPinesTests/).

## Why this exists

The [Pines UI](https://devdojo.com/pines) library is a collection of pre-built Alpine.js and Tailwind CSS UI components — alerts, badges, banners, breadcrumbs, buttons, cards, modals, and more. We use it on the web and wanted the same components available in our server-side Swift applications. This package is that: the same components, rendered type-safely via [Elementary](https://github.com/elementary-swift/elementary) with full snapshot test coverage.

## Current state (v0.1.100)

11 components are implemented and tested:

- `pinesSetup`, `PinesColor`, `PinesButtonStyle`, `PinesBadgeStyle`, `pinesCard`, `pinesIcon`, `pinesAlert`, `pinesProgress`, `pinesQuote`, `pinesBreadcrumb`, `pinesBanner`, `pinesInput`, `pinesTextarea`, `pinesSelect`

Alpine directive compatibility is verified by a dedicated 6-test smoke suite covering `x-text`, `x-model`, `x-on:click`, `x-data`, and the modifier variants of `pinesBreadcrumb`.

## Future directions

- Form components: input, select, textarea, checkbox, radio, switch, etc.
- Overlay and navigation: modal, drawer, popover, dropdown, tabs, accordion, etc.
- Example apps showing real integration in Vapor and Hummingbird

PRs welcome.

## License

[MIT](./LICENSE)
