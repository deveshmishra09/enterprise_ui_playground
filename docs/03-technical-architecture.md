# 03 — Technical Architecture

## Stack

- **Flutter** stable (`.metadata` revision `00b0c91f…`), Dart SDK `^3.11.0`.
- **Material 3** theming.
- Web renderer: default (CanvasKit / skwasm per Flutter's current default). No change.

## Packages

| Package | Purpose | Status |
| --- | --- | --- |
| `go_router` | Declarative routing + path URLs + deep links | **add** |
| `url_launcher` | Open X links and `mailto:` from Slot 6 / footer | **add** |
| `shared_preferences` | Persist the light/dark theme choice | **add** (R13) |
| `google_fonts` | Inter typeface, close to the reference site | **add** (R12) |
| `flutter_svg` | Already present; use for the logo when supplied | keep |
| `portal_labs` `^0.38.0` | Already present; used by existing flow demos | keep, untouched |

No `provider` / `riverpod` / `bloc`. State needs are small (see below).

## State management

Deliberately minimal:

- **Theme:** `ThemeController extends ChangeNotifier` (or `ValueNotifier<ThemeMode>`)
  held above `MaterialApp.router`, exposed via a small `InheritedNotifier`
  (`ThemeScope.of(context)`). Reads/writes `shared_preferences` key `theme_mode`.
- **Routing state:** owned by `go_router` (current location, params).
- **Editor selection:** derived from the route's `subFlowSlug` param — no separate store.
- **FAQ expand/collapse, header menu:** local `StatefulWidget` state.

If requirements grow (accounts, downloads, cart), revisit — not now.

## Layered structure

```mermaid
graph TD
    subgraph Entry
        main[main.dart] --> app[app.dart\nThemeScope + MaterialApp.router]
    end
    app --> router[router/app_router.dart\nGoRouter config]

    subgraph Features
        router --> landing[features/landing]
        router --> flowdetail[features/flow_detail]
        router --> editor[features/subflow_editor]
        router --> contact[features/contact]
        router --> legal[features/support|privacy|terms]
    end

    subgraph Core
        theme[core/theme\ncolors, typography, spacing, ThemeController]
        constants[core/constants\nstrings, links, breakpoints]
        data[core/data\nflows_data, faq_data, pricing_data]
        models[core/models\nFlow, SubFlow, FaqItem, PricingPlan]
        widgets[core/widgets\nSiteHeader, SiteFooter, ResponsiveLayout,\nMaxWidthContainer, ThemeToggleButton,\nDeviceFramePreview, ComingSoonScreen]
    end

    landing --> widgets
    flowdetail --> widgets
    editor --> widgets
    contact --> widgets
    legal --> widgets

    landing --> data
    flowdetail --> data
    editor --> data
    data --> models
    editor --> demos[flows/**  existing demo screens]
    widgets --> theme
    widgets --> constants
```

Dependency rule: `features/*` may depend on `core/*`; `core/*` never depends on
`features/*`. `flows/**` (the existing demo screens) are leaf widgets referenced only by
`flows_data.dart` builders and the editor.

## Routing details

- `usePathUrlStrategy()` (from `flutter_web_plugins`) called in `main()` so URLs have no
  `#`. Requires SPA rewrite on the host — see [`10-deployment.md`](10-deployment.md).
- Single `GoRouter` instance in `router/app_router.dart`.
- `ShellRoute` is **not** used for header/footer because the editor needs a different
  header and no footer; instead each page composes `SiteHeader` / `SiteFooter` itself via
  a `PageScaffold` helper widget.
- `errorBuilder` → redirect to `/`.

## Theme wiring (primary color)

`#af3a4a` is defined **once** as `AppColors.primary` in `core/theme/app_colors.dart`.
`app_theme.dart` builds `ThemeData` for light and dark from a
`ColorScheme.fromSeed(seedColor: AppColors.primary, brightness: …)` plus explicit
overrides. `main.dart` passes `AppTheme.light` / `AppTheme.dark` and the current
`ThemeMode` to `MaterialApp.router`. Nothing else hardcodes a hex color. This replaces
the current blue seed (`Color.fromARGB(255, 22, 8, 222)`) in `main.dart`.

## Existing code migration

- `lib/app_router.dart` (the hand-coded 6-card `GridView` widget) is **kept in place,
  untouched**. Its `AppRouter` class is transitively referenced by ~11 legacy demo
  screens (via the two `*_management_screen.dart` aggregators), so deleting it would
  cascade into rewriting those files — against the surgical-changes rule. The new router
  lives at `lib/router/app_router.dart` (GoRouter) and nothing new imports the old file.
  Its 6 flow names/icons were copied into `flows_data.dart`. (Revised in Phase 0 — the
  original plan was to delete it.)
- `lib/main.dart` gains `ThemeScope`, `MaterialApp.router`, path URL strategy, and the
  `#af3a4a` theme. Note `.metadata` lists `lib/main.dart` under `unmanaged_files` — safe to edit.
- Existing demo screens under `lib/flows/**` are **not modified**; they are only
  referenced as widget builders. Any that assume a full-screen `Scaffold` will be hosted
  inside the device frame's isolated `Navigator` (see
  [`08-mobile-emulator-preview.md`](08-mobile-emulator-preview.md)).

## Testing

- `flutter analyze` must stay clean (`flutter_lints` 6).
- Keep/replace `test/widget_test.dart` (currently the default counter test — will break
  once `MyApp` changes; updated in Phase 0).
- Add widget tests per phase: header renders links, router resolves each route, flow data
  has 71 subflows, device frame mounts a child.
