# 04 — Folder Structure

## Target `lib/` tree

```
lib/
├── main.dart                       # runApp, path URL strategy, ThemeScope
├── app.dart                        # MaterialApp.router + theme mode wiring
│
├── router/
│   └── app_router.dart             # GoRouter config (new; old lib/app_router.dart kept as legacy)
│
├── core/
│   ├── theme/
│   │   ├── app_colors.dart         # AppColors.primary = #af3a4a + palette (light/dark)
│   │   ├── app_theme.dart          # AppTheme.light / AppTheme.dark (ThemeData)
│   │   ├── app_typography.dart     # AppText.* text styles + responsive sizes
│   │   ├── app_spacing.dart        # AppSpacing / AppRadius scales
│   │   └── theme_controller.dart   # ThemeController + ThemeScope (InheritedNotifier)
│   │
│   ├── constants/
│   │   ├── app_strings.dart        # site name, section headings, footer text (TODO(copy) where placeholder)
│   │   ├── app_links.dart          # X url, email, reference urls
│   │   └── breakpoints.dart        # DeviceClass + ResponsiveContext extension on BuildContext
│   │
│   ├── navigation/
│   │   └── app_navigation.dart     # LandingSection enum, goToLandingSection(), openExternalUrl()
│   │
│   ├── models/
│   │   ├── app_flow.dart           # AppFlow  (not `Flow` — collides with Flutter's Flow widget)
│   │   ├── sub_flow.dart           # SubFlow + SubFlowStatus
│   │   ├── faq_item.dart           # FaqItem
│   │   └── pricing_plan.dart       # PricingPlan + PricingVariant
│   │
│   ├── data/
│   │   ├── flows_data.dart         # kAllFlows: List<AppFlow> — 6 flows / 71 subflows + lookups
│   │   ├── faq_data.dart           # kFaqItems — TODO(copy)
│   │   └── pricing_data.dart       # kFreePlan / kPlusPlan — TODO(copy)
│   │
│   ├── widgets/
│   │   ├── page_scaffold.dart      # fixed header + scroll body + optional footer      [P1]
│   │   ├── site_header.dart        # Slot 1 (defaultNav + preview variants)             [P1]
│   │   ├── site_footer.dart        # Slot 7 (3 cols -> stacked, copyright)              [P1]
│   │   ├── responsive_layout.dart  # per-DeviceClass builder                            [P1]
│   │   ├── max_width_container.dart # centered, max-width, gutter padding               [P1]
│   │   ├── theme_toggle_button.dart #                                                   [P1]
│   │   ├── app_logo.dart           # logo.png on a white tile (decision R16)            [P1]
│   │   ├── grid_background.dart     # CustomPainter grid behind PageScaffold (R19)      [P7+]
│   │   ├── highlighted_text.dart   # first match of a substring painted in accent       [P2]
│   │   ├── section_heading.dart    # optional eyebrow + h1                              [P2]
│   │   ├── flow_card.dart          # Slot 3 grid card -> /flows/<slug>                  [P2]
│   │   ├── sub_flow_card.dart      # Slot 3a grid card + Live/Soon chip                 [P3]
│   │   ├── device_frame_preview.dart  # 390x844 phone frame, nested MaterialApp        [P4]
│   │   ├── coming_soon_screen.dart  # placeholder shown inside the frame               [P4]
│   │   ├── pricing_card.dart       # Slot 4 free/plus card                             [P5]
│   │   ├── faq_tile.dart           # Slot 5 accordion row (AnimatedCrossFade)          [P5]
│   │   ├── info_page_scaffold.dart # shared shell for contact/support/privacy/terms    [P6]
│   │   └── prose_sections.dart     # (heading, body) list for the legal pages          [P6]
│   │
│   └── mock_data/
│       └── profile_images/         # EXISTING — untouched
│
├── features/
│   ├── landing/
│   │   ├── landing_page.dart       # route '/', ScrollController + section keys   [P2]
│   │   └── sections/
│   │       ├── intro_section.dart      # Slot 2                                   [P2]
│   │       ├── flows_section.dart      # Slot 3                                   [P2]
│   │       ├── pricing_section.dart    # Slot 4 (IntrinsicHeight row / stack)     [P5]
│   │       ├── faq_section.dart        # Slot 5 (stateful accordion)              [P5]
│   │       └── social_cta_section.dart # Slot 6                                   [P6]
│   │
│   ├── flow_detail/
│   │   └── flow_detail_page.dart   # route '/flows/:flowSlug'                           [P3]
│   │
│   ├── subflow_editor/
│   │   ├── subflow_editor_page.dart # route '/flows/:flowSlug/:subFlowSlug' + _ChipStrip [P4]
│   │   └── widgets/
│   │       └── subflow_list_panel.dart  # the left 20%-width rail                        [P4]
│   │
│   ├── contact/
│   │   └── contact_page.dart       # route '/contact' (EMAIL/FOLLOW rows)               [P6]
│   ├── support/
│   │   └── support_page.dart       # route '/support' (ProseSections)                   [P6]
│   ├── privacy/
│   │   └── privacy_page.dart       # route '/privacy' (ProseSections)                   [P6]
│   └── terms/
│       └── terms_page.dart         # route '/terms' (ProseSections)                     [P6]
│
└── flows/                          # EXISTING demo implementations — untouched
    ├── 01_account_management/…
    └── 02_commerce&finance/…
```

## What changes vs. today

| Path | Action |
| --- | --- |
| `lib/main.dart` | Rewritten (theme + router + url strategy) |
| `lib/app_router.dart` | **Kept, untouched** (legacy `AppRouter`, referenced by ~11 demo screens). New router added at `router/app_router.dart`; flow names copied into `core/data/flows_data.dart` |
| `lib/core/theme/**` | New |
| `lib/core/constants/**` | New |
| `lib/core/models/**` | New |
| `lib/core/data/**` | New |
| `lib/core/widgets/**` | New |
| `lib/features/**` | New |
| `lib/flows/**` | Unchanged |
| `lib/core/mock_data/**` | Unchanged |
| `test/widget_test.dart` | Rewritten (default counter test no longer compiles) |
| `pubspec.yaml` | Add `go_router`, `url_launcher`, `shared_preferences`, `google_fonts` |

## Naming conventions

- Files: `snake_case.dart`. One primary public class per file, named in `PascalCase`.
- Folders: `snake_case`. Feature folders are singular nouns (`contact`, not `contacts`).
- Route slugs: `kebab-case`, defined only in `flows_data.dart`.
- Shared constants: `SCREAMING`? No — Dart style: `lowerCamelCase` with `k` prefix for
  top-level compile-time constants (`kAllFlows`, `kFaqItems`), `AppColors.primary` etc.
  for grouped statics.
- No `&` in new folder names. The existing `02_commerce&finance` keeps its name (not our
  change to make) — noted in [`11-open-questions.md`](11-open-questions.md).
- Widgets that are reused ≥ 2 places live in `core/widgets/`; single-use widgets stay in
  their feature folder.
