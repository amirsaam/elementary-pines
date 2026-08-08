# AGENTS.md

AI contribution guidelines for `elementary-pines`.

## Project

`elementary-pines` is a server-side Swift wrapper for [Pines UI](https://devdojo.com/pines) — a collection of pre-built Alpine.js + Tailwind CSS components. It renders those same components type-safely via [Elementary](https://github.com/elementary-swift/elementary), with full snapshot test coverage.

- `ElementaryPines` — 26 UI components (Accordion, Alert, Badge, Banner, Breadcrumb, Button, Card, Checkbox, DatePicker, Dropdown, Icons, Input, MenuBar, Modal, Popover, Progress, Quote, RadioGroup, RangeSlider, Rating, Select, Switch, Tabs, Textarea, Toast, Tooltip) + `PinesColor` color system
- `Pines.swift` — `setupPines()` entry point (emits `[x-cloak]` style for Alpine.js animations)

## Dependency chain

elementary-pines → elementary-alpine + elementary-tailwind → elementary. SPM resolves transitively.

Do not declare elementary, elementary-alpine, or elementary-tailwind as direct dependencies in consumer Package.swift files.

## Commands

```bash
 swift test                                         # 130 tests
swift test --filter AlertTests                     # single test class
swift test --parallel                              # parallel execution
swift build --build-tests                          # CI build
swift package clean                                # stale .build fix
```

### Swift format

Config: `.swift-format` — line length 140, 4-space indent, trailing commas in collections.

```bash
swift-format lint --strict --recursive Sources/ Tests/   # local lint (strict + recursive)
swift-format format --recursive Sources/ Tests/          # auto-fix
```

CI runs `swift format lint -prs .` (different flags — CI uses `swift format`, local uses `swift-format`).

Lint must pass before committing.

## Commit conventions

Conventional commits: `feat(scope):`, `fix(scope):`, `refactor(scope):`, `test(scope):`, `docs(scope):`, `chore(scope):`.

## Commit cycle

When implementing or refactoring a component, follow this 3-step cycle:

1. `feat(scope):` or `refactor(scope):` — implement or refactor the component
2. `test(scope):` — regenerate snapshot fixtures
3. `docs(scope):` — update AGENTS.md, README, or doc comments if needed

Use `fix(scope):` for bug fixes and `chore(scope):` for maintenance tasks (dependencies, CI, tooling).

## Architecture

### Source (`Sources/ElementaryPines/`)

- One directory per component: Accordion, Alert, Badge, Banner, Breadcrumb, Button, Card, Checkbox, DatePicker, Dropdown, Icons, Input, MenuBar, Modal, Popover, Progress, Quote, RadioGroup, RangeSlider, Rating, Select, Switch, Tabs, Textarea, Toast, Tooltip
- `Pines.swift` — `setupPines()` entry point (emits `[x-cloak]` style)
- `Icons/Icons.swift` — `pinesIcon()` with 35 Heroicon kinds
- `Icons/Icon+Special.swift` — `PinesSpecialIcon` enum + `pinesSpecialIcon()` for multi-path SVGs (wand, quoteMark)
- `Helpers/Color.swift` — `PinesColor` enum (shared color palette)
- `Helpers/Alpine.swift` — internal Alpine `x-bind:class` builder
- `Helpers/Field.swift` — shared text-field Tailwind attributes

### Tests (`Tests/`)

- `ElementaryPinesTests/<Component>/` — snapshot tests per component
- `ElementaryPinesTests/Alpine/` — Alpine directive tests (cross-component)
- `ElementaryPinesTests/<Component>/SnapshotFixtures/*.html` — expected HTML output
- `TestUtilities/` — shared test helpers (`HTMLAssertEqual`)

## File naming

Extensions use `<Type>+<Name>.swift`. The `+` means "this file extends the prefix type":
- `Banner+Icon.swift` extends the `Banner` component
- `Button+Style.swift` adds style definitions to `Button`
- `Icon+Special.swift` adds special icon types

Modifier enums co-locate in the same file as their component (e.g. `PinesButtonStyle` lives in `Button+Style.swift`).

## Key patterns

- Components are free functions (`pinesCard`, `pinesAlert`) that accept `@ContentBuilder` closures — users control the interior, the component provides outer styling
- Variants are handled through parameters or enums (e.g. `PinesButtonStyle`, `PinesAlertVariant`), not subclasses
- `.pinesButtonStyle(_:color:)` and `.pinesBadgeStyle(_:color:)` are HTMLElement modifiers — they chain after the element
- `PinesColor` provides 11 colors with three scales per color (solid, tonal, outline) used across all components
- Alpine.js directives use typed `.x.*` helpers from ElementaryAlpine (`.x.data()`, `.x.on()`, `.x.text()`, `.x.show()`)
- SVG elements don't conform to `HTMLTrait.Attributes.Global` — use raw `SVGAttribute(name:value:)` for Alpine directives on SVGs
- Snapshot fixtures are single-line HTML files. `HTMLAssertEqual` compares rendered output byte-for-byte against the fixture and prints a diff on failure — fixtures are **not** auto-updated by `swift test`; update the fixture file when output intentionally changes

## Testing

- Tests are snapshot-based. Each component has `SnapshotFixtures/*.html` files containing expected HTML output.
- To add a snapshot: write the expected HTML file first, then write the test that reads it.
- `swift test` compares rendered output against fixtures and fails with a diff on mismatch. Review the diff before updating a fixture file.
- Run `swift test` before any commit. All 130 tests must pass.
- After adding or modifying a component, add corresponding snapshot tests in `Tests/ElementaryPinesTests/<Component>/`.

## Conventions

- `public` for all public API surface.
- `///` doc comments required on all public API (one-line summary + description).
- **No inline comments** unless documenting non-obvious behavior.
- Use typed enums for variants — do not hardcode raw strings.

## Coding standards

- Follow latest APIs from elementary, elementary-alpine, and elementary-tailwind — check upstream docs before implementing
- Use `@ContentBuilder` (not deprecated `@HTMLBuilder`)
- Use typed SVG API (`SVG.svg`, `SVG.path`, etc.) — no `HTMLRaw` for SVG rendering

## Versioning

**Epoch SemVer** ([antfu.me/posts/epoch-semver](https://antfu.me/posts/epoch-semver)) with `100×` multiplier: `Epoch.Major.(Minor×100 + Patch)`.

- `Major` bump → breaking change
- `Minor×100 + Patch` encodes minor (×100) + patch (0–99)
- Tag format: `chore: tag 0.X.YYY` (empty commit + tag)

## Build Quirks

- **Swift 6.1** with `StrictConcurrency=complete` enabled — concurrency violations are real errors.
- `ExistentialAny` upcoming feature is also enabled globally.
- macOS only (CI uses `macos-latest`); no Linux support tested.
- If you see `multiple producers` errors, run `swift package clean` — stale `.build` cache from a folder move.

## Do not

- Do not start implementing, refactoring, or changing code without first reading the relevant docs in the upstream packages (elementary, elementary-alpine, elementary-tailwind, Pines UI).
- Do not commit without user review and title approval.
- Do not use `HTMLRaw` for SVG rendering — use typed SVG API.
- Do not use deprecated APIs from Elementary.
- Do not auto-commit or push — always wait for explicit user confirmation.

## CI/CD

- `.github/workflows/ci.yaml` — `swift build --build-tests` + `swift test` on `macos-latest`
- `.github/workflows/format.yaml` — `swift format lint -prs .` on `**.swift` changes
- `.github/workflows/validate-snapshots.yaml` — validates HTML fixture structure

## Dependencies

- `elementary-alpine` ≥ 0.4.000 (Alpine.js directives for Elementary)
- `elementary-tailwind` ≥ 0.3.700 (Tailwind CSS typed attribute helpers for Elementary)
- `elementary` ≥ 0.8.0 (underlying HTML rendering library, resolved transitively)

## Upstream docs

- [Pines UI](https://devdojo.com/pines) — the web components this package wraps
- [elementary](https://github.com/elementary-swift/elementary) — the Swift HTML rendering framework
- [elementary-alpine](https://github.com/amirsaam/elementary-alpine) — Alpine.js directives for Elementary
- [elementary-tailwind](https://github.com/amirsaam/elementary-tailwind) — Tailwind CSS typed attribute helpers for Elementary
