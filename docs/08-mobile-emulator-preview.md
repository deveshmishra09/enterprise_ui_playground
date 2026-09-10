# 08 — Mobile "Emulator" Preview (`DeviceFramePreview`)

## What it is / is not

**Is:** a phone-shaped container that renders a subflow's **real Flutter widgets** live
in the browser, with a phone-sized `MediaQuery`, its own `Navigator`, and its own
`Theme`, so the demo behaves like it would on a device.

**Is not:** an Android/iOS OS emulator, a `webview`, or Flutter DevTools' device preview.
No extra process, no iframe. No rotate button, no network throttle, no multiple device
skins, no in-frame theme toggle — a single iPhone-style frame.

> Confirmed 2026-09-10 — see [`11-open-questions.md`](11-open-questions.md) R6.

## Widget contract

```dart
DeviceFramePreview({
  required Widget child,        // the subflow screen (or ComingSoonScreen)
  DeviceSpec spec = DeviceSpec.iphone13,  // logical size + safe areas + corner radius
  Brightness brightness,        // defaults to the site theme's brightness
})
```

`DeviceSpec` presets: `iphone13` (390 × 844), `pixel7` (412 × 915), `compact` (360 × 780).
One preset is enough for launch (`iphone13`).

## How it isolates the demo

```mermaid
flowchart TD
    A[SubflowEditorPage] --> B[DeviceFramePreview]
    B --> C[Fitted / scaled box\nlogical 390x844]
    C --> D[MediaQuery override\nsize, devicePixelRatio, padding=safe areas, textScaler=1.0]
    D --> E[Theme\n(demo gets a clean Material theme, not the site theme)]
    E --> F[Navigator (local key)\nonGenerateRoute -> child]
    F --> G[Subflow screen widgets\n(Scaffold, bottom sheets, push/pop all stay inside the frame)]
```

Key points:

1. **Local `Navigator`** — demo screens call `Navigator.push` / show bottom sheets
   (several existing flows do). A nested `Navigator` with its own `GlobalKey` keeps that
   navigation *inside* the frame. A "home" button in the frame chrome pops to root.
2. **`MediaQuery` override** — forces phone metrics regardless of the real window, so
   `LayoutBuilder` / `MediaQuery.of` in the demos behave as on a phone. `textScaler`
   pinned to 1.0 for consistent screenshots.
3. **Clean `Theme`** — the demo is wrapped in its own `Theme` (default Material light, or
   the demo's own) so the site's `#af3a4a` theme does not bleed into screenshots. The
   frame chrome (bezel, notch, home indicator) uses site tokens.
4. **`Overlay` / `Directionality` / `MediaQuery`** ancestors are provided so `showDialog`,
   `SnackBar`, `Tooltip` work without a full `WidgetsApp`. Simplest robust approach:
   host the child in a lightweight `WidgetsApp`/`Navigator` rather than hand-rolling
   every inherited widget. Decide during Phase 4 spike.
5. **Sizing** — the frame scales down (`FittedBox`, `BoxFit.contain`) to fit the right
   panel; never scales up past 1.0. On phone/tablet layouts it fills available width.

## Editor layout (route `/flows/:flowSlug/:subFlowSlug`)

```
Desktop / tablet ≥ 900:
┌──────────────────────────── Preview header ───────────────────────────┐
├───────────┬──────────────────────────────────────────────────────────┤
│  list     │                                                          │
│  (20%     │                    ╭───────────────╮                     │
│  width,   │                    │               │                     │
│  scroll)  │                    │  DeviceFrame  │                     │
│  • item   │                    │   (selected   │                     │
│  • item ◄─active               │    subflow)   │                     │
│  • item   │                    │               │                     │
│           │                    ╰───────────────╯                     │
└───────────┴──────────────────────────────────────────────────────────┘

Phone / narrow:
[ Preview header ]
[ horizontal scrollable chips: subflow ▸ subflow ▸ subflow ]
[            DeviceFrame (fills width)            ]
```

- Left list = `SubflowListPanel`, `width = 20%` of viewport (clamped `min 180 / max 320`),
  vertical `ListView` of the current flow's subflows, active item highlighted in
  `AppColors.primary`. Tapping an item → `context.go` to that subflow slug.
- Confirmed 2026-09-10: the spec's "20% of the screen vertically" means this 20%-**width**
  left side rail (not a 20%-tall list). Collapses to a horizontal chip strip below ~900 px.

## Fallbacks / edge cases

- Unknown `subFlowSlug` → redirect to the flow detail screen.
- `status == soon` → frame shows `ComingSoonScreen(flowTitle, subFlowTitle)`.
- A demo that throws during build → frame shows an inline error card, not a white screen
  (wrap child in an `ErrorWidget.builder` scope for the preview).
- Very small windows → editor switches to the stacked phone layout below ~900 px.
