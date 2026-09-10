# 10 — Deployment

## Build

```bash
flutter build web --release
# output: build/web/
```

- Default web renderer (current Flutter default). Revisit only if CanvasKit payload is a
  concern for the target audience.
- `web/index.html` `<base href="/">` for root-domain hosting. If deployed under a
  sub-path (e.g. GitHub Pages project site `/enterprise_ui_playground/`), set
  `--base-href=/enterprise_ui_playground/` and match it in the host.

## URL strategy

`main()` calls `usePathUrlStrategy()` (from `package:flutter_web_plugins/url_strategy.dart`)
so routes are clean (`/flows/content/drawing`, no `#`). **This requires the host to
rewrite unknown paths to `/index.html`** (SPA fallback), otherwise a hard refresh or
shared deep link 404s.

If a host without rewrite control is chosen (plain GitHub Pages), fall back to hash URLs
(don't call `usePathUrlStrategy()`); routes become `/#/flows/content/drawing`. Decision
tracked in [`11-open-questions.md`](11-open-questions.md).

## Host rewrite config

**Firebase Hosting** — `firebase.json`:

```json
{
  "hosting": {
    "public": "build/web",
    "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
    "rewrites": [{ "source": "**", "destination": "/index.html" }]
  }
}
```

**Netlify** — `build/web/_redirects`:

```
/*  /index.html  200
```

**Vercel** — `vercel.json`:

```json
{ "rewrites": [{ "source": "/(.*)", "destination": "/index.html" }] }
```

**Cloudflare Pages** — SPA fallback is automatic when a `build/web/_redirects` with the
Netlify rule is present, or enable "Single Page Application" in project settings.

## Caching

- `flutter.js`, `main.dart.js`, CanvasKit: long-lived immutable cache (hashed names).
- `index.html`: `Cache-Control: no-cache` so new deploys are picked up.
- `flutter_service_worker.js` handles version rollover; confirm the SW isn't disabled.

## CI (optional, Phase 7)

`.github/workflows/web.yml` sketch:

```yaml
on: { push: { branches: [main] }, pull_request: {} }
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with: { channel: stable }
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test
      - run: flutter build web --release
```

Add a deploy step once the host is chosen. There is no existing CI workflow in `.github/`
(only unrelated `modernize/` hook scripts).

## Pre-launch checklist

- [x] Rewrite config committed — `web/_redirects` (Netlify / Cloudflare Pages, bundled
      into `build/web`) and `firebase.json` (SPA rewrite + cache headers). `vercel.json`
      still to add if Vercel is chosen.
- [ ] **Host chosen** and the deploy step wired into `.github/workflows/web.yml`
- [ ] `base href` matches the deploy path (root `/` today; set `--base-href` for a sub-path)
- [ ] All `TODO(copy)` strings replaced (`grep -rn "TODO(copy)" lib`)
- [ ] Real logo asset added (`assets/images/logo.svg`); swap `AppLogo`'s monogram
- [x] `manifest.json` name / short_name / `theme_color` / `background_color` set
- [x] `web/index.html` `<title>` + meta description set
- [x] OG / Twitter meta tags for link previews
- [x] `#af3a4a` as `manifest.json` `theme_color` and `<meta name="theme-color">`
- [ ] App icons still the Flutter defaults (`web/icons/*`, `web/favicon.png`) — replace
- [ ] Analytics decision (none this milestone)
- [ ] Deep-link hard refresh tested on the real host
- [ ] Lighthouse / contrast pass in a real browser (light + dark)

CI (`.github/workflows/web.yml`) runs `flutter analyze --no-fatal-warnings` — the legacy
`lib/flows/**` code has pre-existing lint warnings, so CI fails only on real errors. Our
own code (`lib/core`, `lib/features`, `lib/router`, `lib/app.dart`, `lib/main.dart`, `test`)
is analyze-clean with no exceptions.
