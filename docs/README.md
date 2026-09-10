# Enterprise UI Playground — Planning Docs

Planning and architecture for the **Enterprise UI Playground** web app: a responsive
Flutter (Dart) site that showcases 6 UI flows and their 71 subflows, with a live
in-browser device preview and free downloadable flows.

Reference aesthetic: <https://www.withanimation.app>

## Status

Phase: **planning / awaiting approval**. No app code has been changed yet. Once this
folder is approved, implementation proceeds in the phases described in
[`09-implementation-plan.md`](09-implementation-plan.md).

## How to read these docs

| Doc | What it covers |
| --- | --- |
| [`00-product-overview.md`](00-product-overview.md) | Vision, audience, goals, non-goals |
| [`01-requirements-slots.md`](01-requirements-slots.md) | Slot-by-slot functional spec (Slots 1–7 + sub-pages) + responsive rules |
| [`02-information-architecture.md`](02-information-architecture.md) | Sitemap, routes, navigation model |
| [`03-technical-architecture.md`](03-technical-architecture.md) | Layers, packages, state management, routing |
| [`04-folder-structure.md`](04-folder-structure.md) | Target `lib/` tree and naming conventions |
| [`05-design-system.md`](05-design-system.md) | Primary color `#af3a4a`, tokens, typography, spacing, light/dark themes, breakpoints |
| [`06-data-model.md`](06-data-model.md) | `Flow` / `SubFlow` models, `flows_data.dart` spec |
| [`07-flow-catalogue.md`](07-flow-catalogue.md) | All 6 flows + 71 subflows with route slugs and build status |
| [`08-mobile-emulator-preview.md`](08-mobile-emulator-preview.md) | The in-browser device-frame preview component |
| [`09-implementation-plan.md`](09-implementation-plan.md) | Phased build plan with verifiable checkpoints |
| [`10-deployment.md`](10-deployment.md) | Web build, URL strategy, hosting, CI |
| [`11-open-questions.md`](11-open-questions.md) | Decision log — every question resolved, with rationale and which docs each affects |

Mermaid sources live in [`diagrams/`](diagrams/) and are also embedded inline in the
relevant docs so they render on GitHub.

## Decisions made

All open questions are resolved — see the [decision log](11-open-questions.md) (R1–R18).
Headlines:

1. **Sequencing** — docs + plan first, then build in phases.
2. **Flow data** — one central typed model (`lib/core/data/flows_data.dart`) for all 6
   flows / 71 subflows; grid, flow screens, and editor all read from it.
3. **Routing** — `go_router` with clean path URLs; host with SPA rewrites (R14).
4. **Copy** — placeholder copy for pricing / FAQ / legal, marked `TODO(copy)`.
5. **Deps added** — `go_router`, `url_launcher`, `shared_preferences`, `google_fonts` (Inter).
6. **Device preview** — one iPhone-style frame, live widgets, isolated navigation (R6).
7. **Editor rail** — 20% width (180–320 px), chip strip below ~900 px (R5).
8. **Deferred** — auth, working downloads/payments, the other 61 screens, Slot 2 animation.
