# 00 — Product Overview

## What it is

**Enterprise UI Playground** is a responsive marketing + showcase web application built
with Flutter for web. It presents a curated library of mobile UI **flows** (e.g.
"Logging In", "Adding to Cart", "Onboarding"). Each flow contains one or more
**subflows** — self-contained, runnable Flutter screens that demonstrate a single
interaction pattern.

Visitors can:

- Browse the 6 flow categories and 71 subflows in a grid.
- Open any subflow and see it running **live inside a phone-shaped frame** in the browser.
- Read pricing, FAQ, and legal pages.
- Download the free flows (mechanism TBD — see [open questions](11-open-questions.md)).

Reference site for tone and layout: <https://www.withanimation.app>.

## Target audience

- Flutter application developers
- Technical audience / engineers evaluating UI patterns
- Company owners and founders
- Freelancers

The copy and density should assume a technical reader — concise, concrete, no marketing fluff.

## Platforms

Primary target is the **web app**. The same codebase must render correctly on:

| Class | Width | Notes |
| --- | --- | --- |
| Phone | `< 600` | Single column, hamburger / condensed header, stacked sections |
| Tablet | `600–1023` | 2–3 column grids, condensed header |
| Desktop | `>= 1024` | Full header nav, multi-column sections, max content width |

These thresholds match the ones already used in the current `lib/app_router.dart`
(`isPhone = width < 600`, `isTablet = 600–1024`) and are formalised in
[`05-design-system.md`](05-design-system.md).

## Goals

1. One responsive Flutter web codebase, no separate mobile build required for launch.
2. A single source of truth for flows/subflows so adding a subflow is a one-line data change.
3. Reusable theme + layout primitives — primary color and shared widgets defined once.
4. Clean, shareable URLs for every flow, subflow, and page.
5. Production-deployable: builds to static assets, works behind a CDN with SPA rewrites.

## Non-goals (for this milestone)

- Building all 71 subflow screens. Only the ~12 that already exist are wired up; the
  rest render a "Coming soon" placeholder. See [`07-flow-catalogue.md`](07-flow-catalogue.md).
- Real user accounts / authentication. The header profile icon is decorative for now
  (see [open questions](11-open-questions.md)).
- A payment system for "Plus". Pricing is presentational only this milestone.
- Native Android/iOS release builds.
- CMS / admin tooling.

## Success criteria for the milestone

- `flutter analyze` is clean; `flutter test` passes.
- `flutter build web --release` succeeds and the built site runs from a static host.
- All 7 slots on `/` render correctly at phone, tablet, and desktop widths.
- Every flow and subflow has a working deep-linkable URL.
- Light theme is default; the theme toggle switches to dark and the choice persists.
- Primary color `#af3a4a` is defined in exactly one place and used everywhere via tokens.
