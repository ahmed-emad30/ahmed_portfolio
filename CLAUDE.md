# Agent instructions: ahmed_portfolio

Flutter web portfolio. The backend is Supabase (`portfolio` schema). Read these first:

- **Remaining work:** `docs/IMPLEMENTATION_PLAN.md` (phases, task IDs, order).
- **Backend and deploy:** `docs/SUPABASE_AND_DEPLOY.md`.
- **UI:** `docs/design/README.md`. This is the design gate.

## Design gate (hard rule)

Before changing anything visual (`lib/**/presentation/**`, `lib/core/widgets/**`,
`lib/core/app_themes/**`, responsive/breakpoint utils, visible parts of
`web/index.html`, `assets/`, or content that changes what renders), you MUST:

1. Read `docs/design/README.md`, `01-foundations.md`, and the `02-components.md`,
   `03-screens.md` and `05-open-design-issues.md` entries for what you touch.
2. Use only the tokens defined there. If a value is missing, add a QUESTION to
   `05-open-design-issues.md` and stop. Don't invent colors, sizes or spacing.
3. Never implement an entry whose status is `NEEDS OWNER APPROVAL` or `QUESTION`.
4. Verify with `docs/design/04-verification.md` (build, serve, capture with
   `scripts/design/capture.mjs`, compare with `docs/design/reference/`).
5. In the commit/PR, list `Design: <spec IDs>`, `Verified: <breakpoints × themes>`,
   and `Spec updated: <files>`. Update the spec and reference images in the same PR
   when the as-built design changes.

If you can't build and screenshot, the UI task is **not done**. Say so.

## Other conventions

- Don't run `dart format` on the whole tree. The repo uses the pre-3.7 style:
  `dart format --language-version=3.6 <changed files>`.
- `flutter analyze` must not add issues (baseline 19 on `main`, 2026-10-31).
- Never handle the database password or service-role key. The publishable key is public.
- Work on a branch and open a PR to `main`. Don't push to `main`.
