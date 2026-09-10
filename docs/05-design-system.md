# 05 — Design System

Everything here is defined once in `lib/core/theme/**` and consumed via tokens. No
widget hardcodes a hex value, font size, or raw padding number.

## Color

### Primary

| Token | Value | Use |
| --- | --- | --- |
| `AppColors.primary` | `#af3a4a` | Brand, primary buttons, accent spans, "PRICING" label, Plus card bg, active states |
| `AppColors.onPrimary` | `#FFFFFF` | Text/icons on primary (Plus card foreground, primary buttons) |

`#af3a4a` is a muted crimson. Derived tints/shades (generated, then tuned):

| Token | Approx | Use |
| --- | --- | --- |
| `AppColors.primarySoft` | `#af3a4a` @ 12% alpha | Highlight background behind *"for FlutterUI"*, hover fills |
| `AppColors.primaryHover` | ~`#9c333f` | Button hover/pressed |
| `AppColors.primaryTint` | ~`#e9c4c9` | Subtle borders, dark-mode accent text |

### Neutrals & surfaces

Built from `ColorScheme.fromSeed(seedColor: AppColors.primary, brightness: …)`, then
these explicit overrides so the site reads as "editorial / near-monochrome with one
accent" like the reference site:

| Role | Light | Dark |
| --- | --- | --- |
| `background` | `#F3EFE8` | `#100E0D` |
| `surface` | `#FFFFFF` | `#161618` |
| `surfaceMuted` (cards, footer band) | `#F6F6F5` | `#1D1D20` |
| `outline` / dividers | `#E4E4E2` | `#2C2C30` |
| `textPrimary` | `#1A1A1A` | `#F4F4F5` |
| `textSecondary` | `#5B5B5B` | `#A1A1AA` |
| `textEyebrow` (uppercase labels) | `#8A8A8A` | `#8A8A8A` |

The "Get in touch" / Privacy / Terms hero bands (where the spec asks for **white**
"Get in touch" text) use `AppColors.inkBand` = `#141416` background with white heading
text and `#E4E4E2` body text regardless of theme; the eyebrow stays `AppColors.primary`.
(Decision R8.)

### Themes

- **Default = light.** `ThemeMode.light` on first load.
- **Grid background:** `PageScaffold` paints a faint two-layer grid behind the page in
  **both** themes via `GridBackground` (`CustomPainter`, no asset): minor lines every
  24 px @ 1.75% alpha, major every 120 px @ ~2.3%, tinted from `onSurface`. Base fill and
  grid values match withanimation.app. See [`11`](11-open-questions.md) R19.
- Toggle in the header switches `light ⇄ dark`; persisted to `shared_preferences`
  (`theme_mode`). No "system" option unless requested.
- Both `ThemeData` objects are Material 3 (`useMaterial3: true`).

## Typography

`app_typography.dart` exposes an `AppText` class. Family: **Inter** via `google_fonts`
(decision R12), applied through `AppText` so it is swappable in one place. Sizes are
responsive — each style has phone / tablet / desktop values resolved via `BuildContext`
breakpoints.

| Token | Desktop | Tablet | Phone | Weight | Use |
| --- | --- | --- | --- | --- | --- |
| `display` | 56 | 44 | 34 | 700 | Slot 2 headline "Beautiful flows for FlutterUI" |
| `h1` | 40 | 34 | 28 | 700 | "Explore the flows", "Have any questions?", "Get in touch" |
| `h2` | 28 | 24 | 22 | 700 | Pricing 3-line statement, flow detail titles |
| `h3` | 20 | 19 | 18 | 600 | Card titles, FAQ questions |
| `body` | 16 | 16 | 15 | 400 | Paragraphs |
| `bodySmall` | 14 | 14 | 13 | 400 | Sub-statements ("Try every flow…"), footer |
| `eyebrow` | 13 | 13 | 12 | 600 | "BUILT WITH FLUTTER", "PRICING", "CONTACT", column headings — uppercase, letter-spacing 1.5 |
| `button` | 15 | 15 | 15 | 600 | Buttons, nav links |

## Spacing & radius

`app_spacing.dart`:

| Token | px |
| --- | --- |
| `AppSpacing.xs` | 4 |
| `AppSpacing.sm` | 8 |
| `AppSpacing.md` | 16 |
| `AppSpacing.lg` | 24 |
| `AppSpacing.xl` | 40 |
| `AppSpacing.xxl` | 64 |
| `AppSpacing.section` | 96 desktop / 72 tablet / 56 phone — vertical gap between slots |

| Token | px | Use |
| --- | --- | --- |
| `AppRadius.sm` | 8 | chips, small buttons |
| `AppRadius.md` | 12 | cards (matches existing `_buildGridCard`) |
| `AppRadius.lg` | 20 | pricing cards, device frame outer |
| `AppRadius.device` | 40 | phone frame screen corners |

## Layout & breakpoints

`breakpoints.dart` — single source, matches the current `app_router.dart`:

| Class | Condition | Grid cols | Outer gutter | Content max-width |
| --- | --- | --- | --- | --- |
| phone | `width < 600` | 1 | 16 | full |
| tablet | `600 ≤ width < 1024` | 2 | 24 | 760 |
| desktop | `width ≥ 1024` | 3 | 32 | 1160 |

Helpers: `context.isPhone`, `context.isTablet`, `context.isDesktop`,
`context.deviceClass`, `context.responsive<T>(phone: …, tablet: …, desktop: …)`.

`MaxWidthContainer` applies max-width + gutter and centers content. `ResponsiveLayout`
picks a builder by device class.

## Components (shared)

| Widget | Notes |
| --- | --- |
| `SiteHeader` | Fixed, ~64–72 px tall, `surface` bg with bottom `outline` hairline, subtle blur/opacity on scroll. `variant: {defaultNav, preview}` |
| `SiteFooter` | `surfaceMuted` band, 3 columns → stacked on phone, copyright row |
| `ThemeToggleButton` | Sun/moon `IconButton`, animates icon, calls `ThemeController.toggle()` |
| `HighlightedText` | `RichText` with one span in `AppColors.primary` on `primarySoft` — used for *"for FlutterUI"* |
| `SectionHeading` | eyebrow + h1, consistent bottom margin |
| `FlowCard` / `SubFlowCard` | icon + label, `AppRadius.md`, hover elevation, `onTap` |
| `PricingCard` | `variant: {free, plus}` — free = outlined/transparent, plus = primary bg / white fg |
| `FaqTile` | `ExpansionTile`-style with animated divider, one-open accordion |
| `DeviceFramePreview` | see [`08-mobile-emulator-preview.md`](08-mobile-emulator-preview.md) |
| `ComingSoonScreen` | centered icon + "Coming soon" + flow name, shown in the device frame for unbuilt subflows |

## Motion

- Section anchor scroll: `Curves.easeInOutCubic`, ~450 ms.
- FAQ expand: `AnimatedSize` / `AnimatedCrossFade`, ~250 ms.
- Card hover: 120 ms elevation/scale.
- Theme switch: default `MaterialApp` theme animation (200 ms).
- Respect `MediaQuery.disableAnimations` / reduced-motion.
