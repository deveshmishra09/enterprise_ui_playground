# 01 — Requirements: Screen Slots

The landing route `/` is a single vertical scroll made of 7 slots. Slots 3 and 6 also
lead to dedicated routes. Every slot is responsive across phone / tablet / desktop.

Legend: **[spec]** = taken verbatim from the task, **[decided]** = interpretation locked
in the decision log ([`11-open-questions.md`](11-open-questions.md)).

---

## Slot 1 — Header (global)

**[spec]** Fixed to the top; does not move on scroll.

Layout (desktop):

```
┌───────────────────────────────────────────────────────────────────────┐
│ [logo] Enterprise UI Playground   Flows  Pricing  FAQ        [☾] [👤] │
└───────────────────────────────────────────────────────────────────────┘
```

- **Left cluster:** logo (placeholder for now) + site name **"Enterprise UI Playground"**.
  - **[spec]** "width = 114mm for web application". **[decided R7]** the brand lock-up
    target width; `mm` is not a web unit, so implemented as ~432 logical px
    (114 mm ≈ 432 px at 96 dpi) and tuned by eye. Scales down on tablet/phone.
- **Nav links** after the brand, left-aligned, with horizontal spacing:
  **Flows**, **Pricing**, **FAQ**. These scroll to Slot 3 / 4 / 5 on `/` (smooth scroll
  to anchor). If the user is on another route, they navigate to `/#flows` etc.
- **Right cluster**, horizontal padding: **theme toggle button** (default = light) and a
  **profile icon**. Profile icon is decorative this milestone.

Responsive:

- **Tablet / phone:** brand stays left; nav links collapse into a menu (icon button →
  drawer or dropdown). Theme toggle stays visible; profile icon may move into the menu on phone.

Header variants:

- **Default** — Flows / Pricing / FAQ (on `/` and legal/contact pages).
- **Preview variant** (used on the subflow editor, Slot 3) — the three links are replaced
  by a single centered label **"Preview"**.

---

## Slot 2 — Introduction

**[spec]** A `Row` split into two columns.

- **Column 1 (text):**
  - Eyebrow: **"BUILT WITH FLUTTER"** (small, uppercase, letter-spaced).
  - Headline (large — this is the primary "what this site does" statement):
    **Beautiful flows `for FlutterUI`** — the single-quoted fragment
    *"for FlutterUI"* is highlighted in a special accent color (primary or a tint).
- **Column 2 (animation):** left empty. A sized placeholder box reserves the space;
  the animation is added later.

Responsive:

- **Phone / tablet:** columns stack — text on top, animation placeholder below. Headline
  font size steps down per breakpoint (see typography scale in
  [`05-design-system.md`](05-design-system.md)).

---

## Slot 3 — Flows

**[spec]** Heading **"Explore the flows"** — bold, large.

Below it: a **grid of the 6 flows**. Data comes from the central flow model
(`lib/core/data/flows_data.dart`, see [`06-data-model.md`](06-data-model.md)). The task
says "get the data from `lib/app_router.dart`" — that file currently has no data, so the
6 flow names/icons it hardcodes are migrated into the new model.

Grid columns: 1 (phone) / 2 (tablet) / 3 (desktop) — consistent with the existing
`app_router.dart` logic.

### 3a — Flow detail screen — route `/flows/:flowSlug`

Opens when a flow card is tapped. Contains:

- Header (default variant) + logo
- Grid of the subflows inside that flow (same 1/2/3 column responsive rule)
- Footer (Slot 7)

### 3b — Subflow editor — route `/flows/:flowSlug/:subFlowSlug`

Opens when a subflow is tapped.

- **Header** = Preview variant (centered "Preview", no Flows/Pricing/FAQ).
- **Left panel** — a `ListView` of every subflow in the current flow, all tappable to
  switch the preview. Sized at **20% of the viewport width**, clamped 180–320 px (a
  vertical strip down the left side); collapses to a horizontal chip strip below ~900 px.
  (Confirmed 2026-09-10 — the spec's "20% vertically" meant a 20%-wide side rail.)
- **Right panel** — a **phone-shaped device frame** that renders the selected subflow
  **live**, behaving like a real device (isolated navigation, phone-sized `MediaQuery`).
  Full spec in [`08-mobile-emulator-preview.md`](08-mobile-emulator-preview.md).

Responsive:

- **Phone / tablet:** the 20% side list becomes a horizontal chip/tab strip or a
  collapsible drawer above the device frame; the frame scales to fit available width.

---

## Slot 4 — Pricing

**[spec]** Centered block:

- **"PRICING"** — medium weight, bold, **primary color**.
- **"Preview every flow live**<br>**Customize and download free**<br>**flows."** —
  bold, larger text (line breaks as written).
- **"Try every flow in the browser, make it your own, then download the free ones"** —
  small, not bold.

Below: **two plan cards** side by side.

| | Card 1 — Free | Card 2 — Plus+ |
| --- | --- | --- |
| Background | transparent (outlined) | **primary color** `#af3a4a` |
| Foreground | default text color | white |
| Content | free-tier feature list | plus-tier feature list + price |

Plan contents are **placeholder / `TODO`** (see [`06-data-model.md`](06-data-model.md)
`pricing_data.dart`). Real amounts and bullets to be supplied later.

Responsive: cards stack vertically on phone/tablet.

---

## Slot 5 — FAQ

**[spec]** Centered heading **"Have any questions?"** — bold, larger.

Below: **5 FAQ items** separated by horizontal dividers. Tapping an item expands it
(smooth height animation) to reveal the answer; tapping again collapses it. **[decided]**
one open at a time (accordion).

FAQ content is **placeholder / `TODO`** (`faq_data.dart`).

Responsive: full-width single column on all sizes, constrained to the content max-width.

---

## Slot 6 — Social / Get in touch CTA

**[spec]** Centered line:

> Still have a question? **Get in touch**

*"Get in touch"* is a `TextButton` in the primary color. Tapping it opens the
**Get in touch** page — route `/contact`.

### Get in touch page — `/contact`

- Left/right page padding ~40–50.
- **Header** = default variant.
- **Logo** centered, larger top padding, smaller bottom padding.
- **"CONTACT"** — medium text, primary color, left-aligned.
- **"Get in touch"** — large, bold, **white** text. **[decided R8]** this hero sits on a
  dark band (`AppColors.inkBand` = `#141416`) so the white heading reads in both themes;
  the "CONTACT" eyebrow stays primary color, body text on the band is `#E4E4E2`.
- Body: *"Questions about the Flows, your account, licensing, or an idea you would like
  to share? Choose the route that fits best."* — small, not bold.
- Horizontal divider.
- A row with label / value pairs, `space-between`, separated by dividers:
  - **EMAIL** — `devesh09269@gmail.com` (opens `mailto:`)
  - **FOLLOW** — `@deveshmishra_09` → <https://x.com/deveshmishra_09>
- **Footer** = Slot 7.

Responsive: the label/value rows stack on phone.

---

## Slot 7 — Footer (global)

**[spec]** A row of three columns:

| PRODUCT | CONNECT | LEGAL |
| --- | --- | --- |
| Flows → scroll to Slot 3 | Support → `/support` page | Privacy → `/privacy` page |
| Pricing → scroll to Slot 4 | Contact → `/contact` page | Terms → `/terms` page |
| FAQ → scroll to Slot 5 | Follow on X → <https://x.com/deveshmishra_09> | |

- **Support page** (`/support`): same header / logo / footer shell; content modelled on
  <https://www.withanimation.app/support> with our data. Copy is `TODO`.
- **Privacy page** (`/privacy`): same shell as the Get in touch page; content modelled on
  <https://www.withanimation.app/privacy>. Copy is `TODO`.
- **Terms page** (`/terms`): same shell; content modelled on
  <https://www.withanimation.app/terms>. Copy is `TODO`.

Below the three columns, a centered line:

> © 2026 EnterpriseUIPlayground.app, Built with ❤️ by Devesh Mishra (@deveshmishra_09)

`@deveshmishra_09` is underlined, clickable → <https://x.com/deveshmishra_09>.

Responsive: the three columns stack vertically on phone; 2-up or stacked on tablet.

---

## Cross-cutting responsive rules

- Content is constrained to a max width (desktop ≈ 1100–1200 px — final value in the
  design system doc) and centered; outer gutters scale by breakpoint (phone 16 /
  tablet 24 / desktop 32, matching current code).
- Grid columns: **1 / 2 / 3** for phone / tablet / desktop everywhere a grid appears.
- The fixed header offsets the scroll position for anchor jumps (Flows / Pricing / FAQ).
- All tap targets ≥ 44 px. All external links open in a new tab on web.
