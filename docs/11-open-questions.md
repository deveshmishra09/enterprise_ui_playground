# 11 — Decision Log

All kickoff and follow-up questions are resolved. This file is now the record of what was
decided and why. If a decision needs to change, edit here and in the doc(s) listed under
"Affects".

## Kickoff decisions (from the Q&A)

| # | Decision | |
| --- | --- | --- |
| R1 | Sequencing: write docs + plan first, get approval, then build in phases | |
| R2 | Flows/subflows live in one central typed model `lib/core/data/flows_data.dart` | |
| R3 | Routing: `go_router` with clean path URLs | |
| R4 | Pricing / FAQ / legal copy: draft placeholders marked `TODO(copy)`, replaced later | |

## Follow-up decisions (locked 2026-09-10)

### R5 — Editor left list sizing
20% of viewport width, clamped 180–320 px. Vertical `ListView` side rail; collapses to a
horizontal chip strip below ~900 px. (Spec's "20% vertically" = a 20%-wide left rail.)
**Affects:** `01-requirements-slots.md` §3b, `08-mobile-emulator-preview.md`.

### R6 — "Mobile emulator" scope
A single iPhone-style phone frame (390 × 844) that renders the real subflow Flutter
widgets live, with a phone-sized `MediaQuery` and an isolated `Navigator`/`Theme`. **No**
OS emulator, device rotation, network throttle, multiple device skins, or in-frame theme
toggle. **Affects:** `08-mobile-emulator-preview.md`, `05-design-system.md`.

### R7 — Header brand lock-up "width = 114mm"
`mm` is not a web unit. Treated as the target width of the logo + site-name cluster,
implemented as **~432 logical px** (114 mm ≈ 432 px at 96 dpi) and tuned by eye; scales
down on tablet/phone. **Affects:** `01-requirements-slots.md` §Slot 1, `05-design-system.md`.

### R8 — White "Get in touch" heading
The Contact / Privacy / Terms hero sits on a **dark band** (`AppColors.inkBand` = `#141416`)
so the white heading reads in both themes. The eyebrow ("CONTACT") stays primary color;
body text on the band is `#E4E4E2`. **Affects:** `01-requirements-slots.md` §Get in touch,
`05-design-system.md` (inkBand token), `features/contact` + legal pages.

### R9 — Header profile icon
Decorative placeholder this milestone — a generic person icon, no menu, no link, no auth.
Wiring it is a later milestone. **Affects:** `01-requirements-slots.md` §Slot 1,
`core/widgets/site_header.dart`.

### R10 — "Download the free flows"
Wording only this milestone. No download button is wired; the pricing/intro copy
describes the intent. Mechanism (repo link / per-subflow source / zip) is a later
decision. **Affects:** `00-product-overview.md`, `01-requirements-slots.md` §Slot 4,
`06-data-model.md` (pricing copy).

### R11 — "Plus" tier
Presentational only. The card renders with placeholder price/bullets; its CTA is inert
(or scrolls to contact). Copy is softened so it does not promise a live purchase.
**Affects:** `01-requirements-slots.md` §Slot 4, `06-data-model.md` `pricing_data.dart`.

### R12 — `google_fonts` (Inter)
Added. Body + headings use **Inter** via `google_fonts`; every text style still comes from
`AppText` so the family is swappable in one place. **Affects:** `03-technical-architecture.md`,
`04-folder-structure.md` (`pubspec.yaml`), `05-design-system.md`.

### R13 — `shared_preferences`
Added. Persists the light/dark choice under key `theme_mode`. First visit defaults to
light. **Affects:** `03-technical-architecture.md`, `05-design-system.md`,
`core/theme/theme_controller.dart`.

### R14 — Hosting / URL strategy
Target a host with SPA rewrite support (Firebase Hosting, Netlify, Vercel, or Cloudflare
Pages) and use **clean path URLs** (`usePathUrlStrategy()`). Exact host chosen at deploy
time; `10-deployment.md` carries rewrite configs for all four. If plain GitHub Pages is
chosen instead, drop `usePathUrlStrategy()` for hash URLs — a one-line change.
**Affects:** `03-technical-architecture.md`, `10-deployment.md`.

### R19 — Page grid background (2026-09-10)
`lib/core/widgets/grid_background.dart` — a `CustomPainter`, no image asset, wired into
`PageScaffold` (landing / flow-detail / contact / legal; not the subflow editor).
**Matched to withanimation.app** (read from its `_next/static/css/49034f995a20de6d.css`):
- base fill `#F3EFE8` (light) / `#100E0D` (dark) — `AppColors.lightBackground` /
  `darkBackground` updated to these warm tones.
- two-layer 1px grid tinted from `colorScheme.onSurface`: minor every **24 px** @ 1.75%
  alpha, major every **120 px** @ 2.5% (light) / 2.125% (dark). No mask/fade.

Not copied from their site (bigger palette change, ask if wanted): their landing uses
`--surface` == background (borderless, same-color cards) and near-black hairline borders
(`--border: #171412`). Our cards stay white-on-warm with subtle grey borders.

### R15 — Slot 2 animation
Left as an empty sized placeholder box. No animation dependency added yet; the
library (Lottie / Rive / Flutter-drawn / video) is chosen when the asset is ready.
**Affects:** `01-requirements-slots.md` §Slot 2.

### R16 — Logo asset — RESOLVED
Logo supplied 2026-09-10: a 400×400 "DM" monogram, black on white, with a "DEVESH MISHRA"
caption. The original `logo.jpeg` was a **progressive JPEG**, which Flutter's image
decoder cannot render (it showed the broken-image placeholder on web), so it was converted
to `assets/images/logo.png` (baseline, non-interlaced). `AppLogo` renders it on a **white
rounded tile** with a hairline border so it reads the same in light/dark themes and on the
dark hero band (the image has no transparency). If a transparent PNG/SVG or a
caption-cropped version is provided later, only `AppLogo` changes. Browser favicon / PWA
icons (`web/icons/*`, `web/favicon.png`) are still the Flutter defaults — separate deploy
checklist item. **Affects:** `core/widgets/app_logo.dart`, `pubspec.yaml`.

### R17 — Existing folder names with `&` and typos
`lib/flows/02_commerce&finance/…`, `boopking&reserving`, `purchasing&ordering.dart` (a
folder), `wedgets` — left exactly as-is. They compile today and renaming is out of scope
(surgical-changes rule). A cleanup pass can be scheduled separately later.
**Affects:** nothing in this milestone; `06-data-model.md` references the real paths.

### R18 — `portal_labs`
Kept as-is (used by existing demos). Its web compatibility is verified when the first
`commerce-finance` demo is mounted in the device frame in Phase 4; if a screen breaks on
web, that specific subflow drops to `comingSoon` and is noted here.
**Affects:** `09-implementation-plan.md` Phase 4.

## Things deliberately deferred (not this milestone)

- Real auth / profile menu (R9)
- Working flow downloads + payments (R10, R11)
- Building the remaining 61 subflow screens
- The Slot 2 animation (R15)
- Renaming `&`/typo folders (R17)
- Native Android/iOS release builds
