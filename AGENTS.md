# elementary-pines

Server-side Swift wrapper for [Pines UI](https://devdojo.com/pines) — a collection of pre-built Alpine.js + Tailwind CSS components (alerts, badges, banners, breadcrumbs, buttons, cards, modals, and more). This package renders those same components type-safely via [Elementary](https://github.com/elementary-swift/elementary), with full snapshot test coverage. The goal is feature parity with the web Pines library so server-side Swift apps (Vapor, Hummingbird) can use the same UI components.

## Dependency chain

elementary-pines → elementary-alpine → elementary. SPM resolves transitively.

Do not declare elementary or elementary-alpine as direct dependencies in consumer Package.swift files.

## Commands

```bash
swift build --build-tests          # build
swift test                         # run all tests (115 snapshot tests)
swift-format lint --strict --recursive Sources/ Tests/   # lint (must pass with 0 warnings)
swift-format format --recursive Sources/ Tests/          # auto-fix
```

CI runs `swift format lint -prs .` (note: different flag than local). Lint must pass before committing.

## Commit conventions

Conventional commits: `feat(scope):`, `fix(scope):`, `refactor(scope):`, `test(scope):`, `docs(scope):`, `chore(scope):`.

## Commit cycle

When implementing or refactoring a component, follow this 3-step cycle:

1. `feat(scope):` or `refactor(scope):` — implement or refactor the component
2. `test(scope):` — regenerate snapshot fixtures
3. `docs(scope):` — update AGENTS.md, README, or doc comments if needed

Use `fix(scope):` for bug fixes and `chore(scope):` for maintenance tasks (dependencies, CI, tooling).

## Swift format

Config: `.swift-format` — line length 140, 4-space indent, trailing commas in collections.

## Architecture

### Source (`Sources/ElementaryPines/`)

- One directory per component: Alert, Badge, Banner, Breadcrumb, Button, Card, Checkbox, Icons, Input, Progress, Quote, RadioGroup, RangeSlider, Rating, Select, Switch, Textarea
- `Pines.swift` — `setupPines()` entry point (emits `[x-cloak]` style)
- `Icons/Icons.swift` — `pinesIcon()` with 35 Heroicon kinds
- `Icons/Icon+Special.swift` — `PinesSpecialIcon` enum + `pinesSpecialIcon()` for multi-path SVGs (wand, quoteMark)
- `Helpers/Color.swift` — `PinesColor` enum (shared color palette)

### Tests (`Tests/`)

- `ElementaryPinesTests/<Component>/` — snapshot tests per component
- `ElementaryPinesTests/Alpine/` — Alpine directive tests (cross-component)
- `ElementaryPinesTests/<Component>/SnapshotFixtures/*.html` — expected HTML output
- `TestUtilities/` — shared test helpers (`HTMLAssertEqual`)

## Key patterns

- Components are free functions (`pinesCard`, `pinesAlert`) that accept `@ContentBuilder` closures — users control the interior, the component provides outer styling
- Variants are handled through parameters or enums (e.g. `PinesButtonStyle`, `PinesAlertVariant`), not subclasses
- `.pinesButtonStyle(_:color:)` and `.pinesBadgeStyle(_:color:)` are HTMLElement modifiers — they chain after the element
- `PinesColor` provides 11 colors with three scales per color (solid, tonal, outline) used across all components
- Alpine.js directives use typed `.x.*` helpers from ElementaryAlpine (`.x.data()`, `.x.on()`, `.x.text()`, `.x.show()`)
- SVG elements don't conform to `HTMLTrait.Attributes.Global` — use raw `SVGAttribute(name:value:)` for Alpine directives on SVGs
- Snapshot fixtures are single-line HTML files. `swift test` auto-updates them — review the diff before committing

## Testing

- Tests are snapshot-based. Each component has `SnapshotFixtures/*.html` files containing expected HTML output.
- `swift test` auto-updates fixtures when output changes. Review the diff before committing.
- Run `swift test` before any commit. All 115 tests must pass.
- After adding or modifying a component, add corresponding snapshot tests in `Tests/ElementaryPinesTests/<Component>/`.

## Coding standards

- Follow latest APIs from elementary and elementary-alpine — check upstream docs before implementing
- Use `@ContentBuilder` (not deprecated `@HTMLBuilder`)
- Use typed SVG API (`SVG.svg`, `SVG.path`, etc.) — no `HTMLRaw` for SVG rendering

## Do not

- Do not start implementing, refactoring, or changing code without first reading the relevant docs in the upstream packages (elementary, elementary-alpine, Pines UI).
- Do not commit without user review and title approval.
- Do not use `HTMLRaw` for SVG rendering — use typed SVG API.
- Do not use deprecated APIs from Elementary.

## Upstream docs

- [Pines UI](https://devdojo.com/pines) — the web components this package wraps
- [elementary](https://github.com/elementary-swift/elementary) — the Swift HTML rendering framework
- [elementary-alpine](https://github.com/amirsaam/elementary-alpine) — Alpine.js directives for Elementary
