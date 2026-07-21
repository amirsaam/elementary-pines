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
            <button class="inline-flex items-center justify-center px-4 py-2 text-sm font-medium tracking-wide text-white transition-colors duration-200 rounded-md bg-blue-600 hover:bg-blue-700 focus:ring-2 focus:ring-offset-2 focus:ring-blue-700 focus:shadow-outline focus:outline-none">Add to cart</button>
        </div>
    </div>
</main>
```

## Use it

Add `ElementaryPines` to your `Package.swift` dependencies:

```swift
// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "MyApp",
    dependencies: [
        .package(url: "https://github.com/amirsaam/elementary-pines.git", from: "0.1.100"),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "ElementaryPines", package: "elementary-pines"),
            ]
        ),
    ]
)
```

`ElementaryPines` depends on `ElementaryAlpine`, which depends on `Elementary`. Swift Package Manager resolves these transitively — no need to declare them as direct dependencies.

This package requires Swift 6.1 with `StrictConcurrency=complete` and targets macOS v14, iOS v15, tvOS v17, watchOS v10.

## Quick tour

```swift
// call `setupPines()` once in your document head — emits the [x-cloak] rule
// that hides elements before Alpine.js hydrates them
import ElementaryPines

var head: some HTML {
    meta(.charset(.utf8))
    script(.src("https://cdn.tailwindcss.com")) {}
    setupPines()
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
// Alpine-animated progress bar; pass a value for a static bar
pinesProgress()                                // auto-animated 0→100, neutral, h-3
pinesProgress(45)                              // static 45%, neutral, h-3
pinesProgress(9, of: 20)                       // static 45%, neutral, h-3
pinesProgress(75, color: .green, size: .lg)    // static 75%, green, h-4
```

```swift
// fixed Alpine banner (top by default)
pinesBanner(
    label: "New Feature",
    message: "Click here to learn about our latest feature",
    href: "#"
)

// black banner fixed to the bottom
pinesBanner(
    label: "New Feature",
    message: "Click here to learn about our latest feature",
    href: "#",
    position: .bottom
)
```

```swift
// input — styled text input (type, placeholder, color, disabled, form attrs)
pinesInput(placeholder: "Name")

pinesInput(type: "email", color: .blue, placeholder: "Email")

pinesInput(type: "text", placeholder: "Search...", name: "q", value: "pine", id: "search")

pinesInput(placeholder: "Disabled", disabled: true)

pinesInput(placeholder: "Email", attributes: [.x.model("email")])
```

```swift
// textarea — styled multi-line input (placeholder, color, rows, form attrs)
pinesTextarea(placeholder: "Type your message here.")

pinesTextarea(color: .blue, placeholder: "Bio")

pinesTextarea(placeholder: "Comment", name: "comment", rows: 4)

pinesTextarea(placeholder: "Disabled", disabled: true)

pinesTextarea(placeholder: "Message", attributes: [.x.model("message")])
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
// checkbox — 3 overloads: .default (labelText), .card (content), .custom (labelClasses + content)
pinesCheckbox(labelText: "Remember me", name: "remember", id: "remember")
pinesCheckbox(labelText: "Terms", required: true, name: "terms", id: "terms")
pinesCheckbox(labelText: "Toggle", name: "opt", id: "opt") {
    [.x.model("isChecked")]
}

// .card — hidden peer input with card-styled label wrapping content
pinesCheckbox(name: "lib", id: "lib") {
    [.x.model("selected")]
} content: {
    pinesIcon(.atSymbol, size: .xl, color: .blue)
    div { "AlpineJS" }
}

// .custom — user provides labelClasses for peer-checked descendant targeting
pinesCheckbox(name: "x", id: "x", labelClasses: "peer-checked:[&_svg]:scale-100 [&_svg]:scale-0") {
    [.x.model("toggle")]
} content: {
    span(.class("custom-checkbox")) { /* svg */ }
    span { "Custom" }
}
```

```swift
// radio group — Alpine-driven, options JSON-encoded into x-data
pinesRadioGroup(options: [
    .init(title: "Small", value: "sm"),
    .init(title: "Medium", value: "md", description: "Recommended"),
    .init(title: "Large", value: "lg"),
], name: "size")

// disabled radio group
pinesRadioGroup(options: options, name: "answer", disabled: true)
```

```swift
// rating — interactive star/heart selection with Alpine.js
pinesRating()
pinesRating(icon: .heart, color: .pink)
pinesRating(emptyStyle: .filled)
pinesRating(compactReset: true)
pinesRating(icon: .heart, color: .pink, compactReset: true)
```

```swift
// range slider — styled <input type="range"> with Tailwind pseudo-element classes
pinesRangeSlider(name: "volume", id: "volume")

pinesRangeSlider(color: .green, name: "price", id: "price", min: 0, max: 200, value: 50, step: "5")

pinesRangeSlider(name: "range", id: "range", disabled: true)
```

```swift
// switch — Alpine-driven toggle with hidden checkbox
pinesSwitch(labelText: "Enable Feature", name: "feature", id: "feature")
pinesSwitch(labelText: "Wi-Fi", color: .green, name: "wifi", id: "wifi", checked: true)
pinesSwitch(labelText: "Small", size: .small, name: "sm", id: "sm")

pinesSwitch(labelText: "Airplane Mode", name: "airplane", id: "airplane", attributes: [.x.model("airplane")])
```

```swift
// breadcrumb — manual items (bordered style; first crumb renders a home icon)
pinesBreadcrumb([
    .link("Home", href: "/"),
    .link("Docs", href: "/docs"),
    .current("Installation"),
])

// text separators
pinesBreadcrumb(items, separator: .slash)
pinesBreadcrumb(items, separator: .arrow)

// no home icon
pinesBreadcrumb(items, homeIcon: .none)

// custom home icon image
pinesBreadcrumb(items, homeIcon: .custom(path: "/icons/home.svg"))

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
pinesQuote(
    quote: "This is a great quote.",
    author: "Author Name",
    role: "Role"
)

pinesQuote(
    quote: "This is a great quote.",
    author: "Author Name",
    role: "Role",
    avatar: "user.jpg"
)
```

## Components

The package ships 17 free functions. Each wraps the matching Pines UI element with type-safe parameters.

| Function                        | Variants                                                                                       | Notes                                                    |
| ------------------------------- | ---------------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| `setupPines()`                 | —                                                                                              | Emits the `<style>[x-cloak]…` rule. Call once in `<head>`. |
| `PinesColor`                   | 11 cases: `amber, blue, gray, green, indigo, neutral, orange, pink, purple, red, yellow`     | Shared enum used by every color-accepting component.       |
| `.pinesButtonStyle(_:color:)`  | 3 styles × 11 colors = 33 variants                                                              | Modifier on `button`.                                    |
| `.pinesBadgeStyle(_:color:)`   | 5 styles × 11 colors = 55 variants                                                              | Modifier on `span`.                                      |
| `pinesCard(_:image:content:)`  | 4 variants: `.basic`, `.image(image:)`, `.horizontal(image:)`, `.stat`                       | `image:` required for `.image` and `.horizontal`.          |
| `pinesIcon(_:size:color:attributes:)`     | 35 kinds × 5 sizes = 175 variants; 11 colors; `attributes:` for extra classes / directives | Heroicons 2.x paths. Classes passed via `attributes:` merge with the default size/color class. |
| `pinesAlert(_:icon:content:)`  | 2 overloads: `pinesAlert { ... }` (basic) and `pinesAlert(.info, icon: .auto, ...) { ... }`    | `.auto` inserts the matching icon; `.none` omits; `.custom(path:)` renders a user-provided SVG file via `<img>`. |
| `pinesProgress(_:of:color:size:)` | Default is the Alpine-animated bar; pass a value for a static bar. `color:` defaults to `.neutral`, `size:` to `.md` (`h-3`). | Percentage clamped to 0–100.                              |
| `pinesQuote(quote:author:role:avatar:)` | Quote text, author name, role, optional avatar image URL.                                     | `avatar:` omitted to render the quote without an avatar.  |
| `pinesBreadcrumb(_:separator:homeIcon:)` | `separator:` `.chevron` (default), `.slash`, `.arrow`; `homeIcon:` `.icon(PinesIconKind)` (default `.home`), `.custom(path:)`, `.none` | See also `pinesBreadcrumbItems(for:in:root:)` for data-driven derivation. |
| `pinesBreadcrumbItems(for:in:root:)` | —                                                                                         | Derives items from a flat `(path, label)` site map and a current path. |
| `pinesBanner(label:message:href:icon:dismissible:position:)` | `PinesBannerPosition` `.top` (white) / `.bottom` (black). `icon:` defaults to `.wand`; pass `nil` to omit. | Alpine-driven fixed banner with show/hide transitions and a dismiss button. |
| `pinesInput(type:color:placeholder:name:value:id:disabled:attributes:)` | `String` type (e.g. `"text"`, `"email"`, `"password"`); color overrides the 300/400 border + ring pair | Tailwind-only — users add `x-data`/`x-model` on the call site for dynamic behavior. |
| `pinesTextarea(color:placeholder:name:id:rows:disabled:attributes:)` | `String?` placeholder; color overrides the 300/400 border + placeholder + ring pair | Tailwind-only — no built-in auto-resize; users add `x-data`/`x-model` on the call site. |
| `pinesSelect(items:placeholder:width:)` | `[PinesSelectItem]` (Codable, with `title`/`value`/`disabled`); any Tailwind width class | Alpine-driven — emits full `x-data` state, `x-init` (`$watch`), 5 `@keydown.*` handlers, `x-transition`, `x-cloak`, `x-for` template. Requires `setupAlpine()` in `<head>`. |
| `pinesCheckbox` | 3 overloads: `.default` (visible input + label), `.card` (peer-checked card), `.custom` (user-supplied `labelClasses` for `peer-checked:[&_...]` targeting) | Use `.default` with `labelText:`; `.card`/`.custom` with `content:` trailing closure; all accept `attributes:` for Alpine directives on the `<input>`. |
| `pinesRadioGroup(options:name:disabled:)` | `[PinesRadioGroupOption]` with `title`/`value`/optional `description`; `name` groups radio inputs; `disabled` disables all | Alpine-driven — emits full `x-data` state with `x-for` template loop; options JSON-encoded. Requires `setupAlpine()` in `<head>`. |
| `pinesRating(icon:color:emptyStyle:maxStars:value:disabled:compactReset:)` | 2 icons (`PinesRatingIcon`) × 2 empty styles (`PinesRatingEmptyStyle`) × 11 colors; `maxStars`/`value`/`disabled`/`compactReset` | Alpine-driven — hover preview, click-to-rate, reset button (compact inline or below). Requires `setupAlpine()` in `<head>`. |
| `pinesRangeSlider(color:name:id:min:max:value:step:disabled:)` | 11 colors; configurable `min`/`max`/`value`/`step`/`disabled` | Tailwind-only — `[&::-webkit-slider-thumb]`, `[&::-moz-range-track]` etc. for custom thumb/track styling. No Alpine dependency. |
| `pinesSwitch(labelText:color:size:name:id:checked:disabled:attributes:)` | `PinesSwitchSize`: `.default` (h-6 w-10), `.small` (h-4 w-6); 11 colors; `checked`/`disabled` | Alpine-driven — hidden checkbox, button toggle, label click. Requires `setupAlpine()` in `<head>`. |

## Alpine integration

Pines UI was designed for [Alpine.js](https://alpinejs.dev/). The standard way to add Alpine directives to Elementary HTML is with the typed `.x.*` attribute helpers from [`ElementaryAlpine`](https://github.com/amirsaam/elementary-alpine) — they compile to the same HTML attributes and are verified by snapshot tests.

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

`ElementaryAlpine` also provides `setupAlpine(plugins:)` which emits the CDN `<script>` tags for Alpine.js core + plugins. Every Pines component preserves Alpine directives passed as attributes — `x-text`, `x-model`, `x-on:click`, `x-data`, `x-show`, and the rest all survive Elementary's renderer.

## Setup

The `setupPines()` function emits a single `<style>` block. Call it once in the document `<head>` — every Pines component that supports animation emits `x-cloak` and breaks visibly without this rule in place.

```swift
var head: some HTML {
    meta(.charset(.utf8))
    setupPines()
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

- [`Sources/ElementaryPines/Pines.swift`](./Sources/ElementaryPines/Pines.swift) — `setupPines()`
- [`Sources/ElementaryPines/Button/Button+Style.swift`](./Sources/ElementaryPines/Button/Button+Style.swift) — `.pinesButtonStyle`
- [`Sources/ElementaryPines/Card/Card.swift`](./Sources/ElementaryPines/Card/Card.swift) — `pinesCard`
- [`Sources/ElementaryPines/Alert/Alert+Variant.swift`](./Sources/ElementaryPines/Alert/Alert+Variant.swift) — `pinesAlert`

The full test suite (115 snapshot and integration tests, including Alpine directive smoke tests) lives in [`Tests/ElementaryPinesTests/`](./Tests/ElementaryPinesTests/).

## Why this exists

The [Pines UI](https://devdojo.com/pines) library is a collection of pre-built Alpine.js and Tailwind CSS UI components — alerts, badges, banners, breadcrumbs, buttons, cards, modals, and more. We use it on the web and wanted the same components available in our server-side Swift applications. This package is that: the same components, rendered type-safely via [Elementary](https://github.com/elementary-swift/elementary) with full snapshot test coverage.

## Current state (v0.1.100+)

17 component functions are implemented and tested:

- `setupPines`, `PinesColor`, `.pinesButtonStyle`, `.pinesBadgeStyle`, `pinesCard`, `pinesIcon`, `pinesAlert`, `pinesProgress`, `pinesQuote`, `pinesRating`, `pinesRangeSlider`, `pinesBreadcrumb`, `pinesBanner`, `pinesInput`, `pinesTextarea`, `pinesSelect`, `pinesCheckbox`, `pinesRadioGroup`, `pinesSwitch`

Alpine directive compatibility is verified by a dedicated smoke suite covering `x-text`, `x-model`, `x-on:click`, `x-data`, `x-show`, and modifiers.

## Future directions

- v0.1.200 form components are done (Date Picker, Textarea auto-resize, Copy to Clipboard remaining).
- v0.1.300 overlay and navigation: modal, slide-over, popover, dropdown, tabs, accordion, toast, tooltip, command, context-menu, hover-card, navigation-menu, image-gallery.
- v0.1.400+ data and media: table, pagination, menu bar, video.
- v0.1.500+ effects: marquee, retro grid, text animation, typing effect.
- Example apps showing real integration in Vapor and Hummingbird.

PRs welcome.

## License

[MIT](./LICENSE)
