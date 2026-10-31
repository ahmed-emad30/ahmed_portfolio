# 04: Visual verification procedure

Every UI task runs this procedure before it can be marked done (design gate
step 5). It takes about 5 minutes once the SDK is installed.

## 1. Static checks

```bash
flutter pub get
flutter analyze          # must not add issues (baseline on main: 19, all pre-existing)
flutter test
```

Formatting: the repo is **not** in the Dart 3.7 "tall" style. Don't run
`dart format` on the whole tree. To format only the files you touched, use
`dart format --language-version=3.6 <files>`.

## 2. Build and serve

```bash
# Bundled content only (what the reference images show):
flutter build web --release --no-web-resources-cdn

# Or against the live backend:
flutter build web --release --no-web-resources-cdn \
  --dart-define=SUPABASE_URL=https://<ref>.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=<publishable key>

node scripts/design/serve_spa.mjs build/web 8765
```

`--no-web-resources-cdn` bundles CanvasKit locally, so the build also works
where `gstatic.com` is blocked.

## 3. Capture

```bash
cd scripts && npm install --no-save playwright   # don't commit: scripts/node_modules is tracked until C-04
node design/capture.mjs http://localhost:8765 ../build/design-shots
# Subsets:
ONLY=contact,home BREAKPOINTS=mobile,tablet THEMES=light,dark \
  node design/capture.mjs http://localhost:8765 ../build/design-shots
```

The output file names match `docs/design/reference/`, so you can compare them
pairwise. The script uses locale `en-US`, because headless Chromium's default
locale makes the app throw `Incorrect locale information provided`.

Manual extras that the script doesn't cover:
- open the drawer (menu icon) on mobile and tablet;
- for the Contact screen, submit an empty form (validation), then a valid one (toast);
- scroll each section to its end with the mouse wheel. The first tick must scroll the section, and only scrolling past the end moves to the next section;
- resize 375 → 768 → 1280 without reloading. The route and scroll position must be kept.

## 4. Compare and accept

For every screen × breakpoint × theme the change touches:

| Check | Pass condition |
|-------|----------------|
| Matches spec | Measurements, colors and type match `01`–`03`, or the `UI-xx` target if the task is one |
| No regressions elsewhere | The other captured screens are pixel-similar to `reference/` (except intended changes) |
| No overflow | No yellow/black overflow stripes, no grey error boxes (release-mode build errors) |
| Above the fold | SCR-HERO-M name, title and icons are visible at 375×812 |
| Contrast | New or changed text meets A11Y-04, checked against the contrast table in `01` (or computed) |
| Hit areas | New or changed tappables are ≥ 48×48 (A11Y-01) |
| Semantics | New icon-only controls have a tooltip and a label (A11Y-02). Spot-check with `page.getByRole('button', { name })` |
| Dark mode | Same layout. No light-only colors leak (white boxes, grey photo backgrounds) |

## 5. Record

In the PR description:

```
Design: <spec IDs implemented, e.g. UI-02, SCR-HERO-T, CMP-CONTACT-ICONS>
Verified: <breakpoints × themes captured>
Before/after: <paths or attached images>
Spec updated: <files changed under docs/design, or "no as-built change">
```

If a screen's as-built look changed on purpose, replace its file in
`docs/design/reference/` in the same PR.
