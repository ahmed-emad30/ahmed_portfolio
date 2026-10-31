# Design Specification: Ahmed Emad Portfolio

This folder is the **single source of truth for the UI**. The original Figma
file is not in the repo. Everything an agent or developer needs to judge a UI
change is written here or shown in `reference/`.

Last captured: **2026-10-31**, from `main` @ `7b478e8` (PR #1 merged), release
web build with bundled content (no backend).

---

## ⛔ Design gate (mandatory for every UI task)

A task is a **UI task** if it changes anything under `lib/**/presentation/**`,
`lib/core/widgets/**`, `lib/core/app_themes/**`, `lib/core/utils/responsive_values.dart`,
`lib/core/utils/screen_size_utils.dart`, the visible parts of `web/index.html`
(splash, body markup; `<head>` meta tags alone don't count), or any asset in
`assets/`. Content-only changes that alter what is rendered (e.g.
`PortfolioContent.fallback`) also count.

A UI task is **not complete** until all of these are true:

1. **Read before coding.** You have read, in full:
   - this README,
   - [`01-foundations.md`](01-foundations.md) (tokens),
   - [`02-components.md`](02-components.md) for every component you touch,
   - [`03-screens.md`](03-screens.md) for every screen you touch,
   - the task's entry in [`05-open-design-issues.md`](05-open-design-issues.md).
2. **Cite the spec.** The commit message or PR body lists the spec IDs you
   implemented against (e.g. `Design: TOK-COLOR-02, CMP-BTN-01, SCR-CONTACT-T, UI-07`).
3. **Stay inside the tokens.** No new hex colors, font sizes, radii or spacing
   values unless the task's `UI-xx` entry explicitly defines them. If a value
   you need is missing, **stop and add it to `05-open-design-issues.md` as a
   question.** Don't invent it.
4. **Respect decisions that need approval.** Entries marked
   `Status: NEEDS OWNER APPROVAL` must not be implemented until the owner
   flips them to `APPROVED` in that file. This applies above all to brand-color changes.
5. **Verify visually.** Run the procedure in
   [`04-verification.md`](04-verification.md). Capture the screenshots for every
   breakpoint × theme you affected. Compare them to `reference/` and to the
   acceptance criteria. Attach or commit them as the PR's before/after.
6. **Update the spec.** If the change alters an as-built value, update the
   relevant line in `01`–`03` **in the same PR**. If it changes a screen's
   appearance, replace its reference image. The spec must never lag the code.

If you cannot do step 5 (no Flutter SDK or browser), the task stays
**incomplete**. Say so explicitly and leave verification to a human.

---

## Files

| File | What it holds |
|------|---------------|
| [`01-foundations.md`](01-foundations.md) | Color, typography, spacing, radius, elevation, breakpoints, motion, imagery tokens, with contrast ratios |
| [`02-components.md`](02-components.md) | Every reusable component: anatomy, sizes, states, a11y rules |
| [`03-screens.md`](03-screens.md) | Every screen at mobile / tablet / desktop: layout, content order, measurements, known deviations |
| [`04-verification.md`](04-verification.md) | How to build, serve, screenshot and check a UI change |
| [`05-open-design-issues.md`](05-open-design-issues.md) | Open UI defects and pending design decisions (`UI-xx`), with the target design for each |
| `reference/` | As-built screenshots: `<breakpoint>_<theme>_<screen>.jpg` |

## Spec ID scheme

| Prefix | Meaning | Example |
|--------|---------|---------|
| `TOK-` | Design token | `TOK-COLOR-01` |
| `CMP-` | Component | `CMP-TOPBAR` |
| `SCR-<SCREEN>-<M/T/D>` | Screen at a breakpoint | `SCR-HERO-M` |
| `A11Y-` | Accessibility rule | `A11Y-03` |
| `UI-` | Open issue / decision | `UI-04` |

## Reference screenshots

`reference/` holds the as-built state. **It includes known defects**, and each
defect is listed in `05-open-design-issues.md`. A reference image shows what
exists. Where an open issue overrides it, the `UI-xx` target wins.

| Breakpoint | Viewport | Files |
|------------|----------|-------|
| mobile | 375 × 812 | `mobile_{light,dark}_*.jpg` |
| tablet | 768 × 1024 | `tablet_{light,dark}_*.jpg` |
| desktop | 1280 × 843 | `desktop_{light,dark}_*.jpg` |

Screens: `home, about, services, portfolio, skills, experience, contact,
all_projects, project_details`. Dark mode is captured for `home, services,
skills, contact`. `*_portfolio_with_previews.jpg` shows the Portfolio section
when Taggz has preview images (target state for UI-01).
`*_portfolio.jpg` shows the current empty-state defect.
