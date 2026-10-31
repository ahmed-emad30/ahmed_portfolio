# Implementation plan: remaining work

Snapshot: **2026-10-31**, `main` @ `7b478e8` (PR #1 merged).
Supersedes the "Execution order" in `docs/MOBILE_AUDIT_AND_MIGRATION_PLAN.md`.

## Where things stand

| Area | State |
|------|-------|
| Code: `portfolio` schema, fallback content, mobile fixes H1–H5 / M1–M9 | ✅ merged in PR #1 |
| Old Supabase project `tptaqfbmqifzewewnudg` | ❌ still NXDOMAIN (paused or deleted) on 2026-10-31 |
| Active project: schema created, data loaded, schema exposed | ⏳ owner, not done (nothing in the repo shows it) |
| Live site `https://ahmed-emad30.github.io/ahmed_portfolio/` | ❌ stale: `gh-pages` was last deployed **2026-08-07**, still points at the dead project and predates PR #1, so visitors see empty sections |
| UI after PR #1 | ⚠️ new defects found at tablet width / dark mode / fallback content, see `docs/design/05-open-design-issues.md` |

**Does the UI still need design work? Yes.** Three High issues (UI-01
empty Portfolio, UI-02 tablet hero overlap, UI-03 dark-mode photo box) plus a
light-mode contrast problem that needs a brand decision (UI-09). Every UI task
below is gated by **`docs/design/README.md`**.

---

## Rules for whoever picks up a task (human or agent)

1. Take tasks **in phase order**. Inside a phase, take them in the order listed unless a dependency says otherwise.
2. Every task marked **Design gate: REQUIRED** follows `docs/design/README.md`
   §"Design gate" in full: read the listed spec files, cite the spec IDs, verify
   with `docs/design/04-verification.md`, and update the spec and reference images in the same PR.
   **No screenshots, no "done".**
3. Tasks marked **Owner** need the owner's dashboard access or decisions.
   Never ask for, store or handle the database password or service-role key.
   The publishable key is public and is fine in build defines.
4. One task per commit where practical. PRs go to `main` and are never pushed to `main` directly.

---

## Phase 0: Owner actions (unblock the backend and the live site)

| ID | Task | How | Done when |
|----|------|-----|-----------|
| O-01 | Decide the data source | Supabase Dashboard → old project "Ahmed Portfolio". If **Restore** is offered, restore it (→ O-02a). If the project is gone, use the seed (→ O-02b) | Choice recorded in this file |
| O-02a | Dump the real data | On your machine: `supabase db dump --db-url "$OLD_DB_URL" --schema public --data-only -f old_data.sql`, then `./scripts/rewrite_dump_to_portfolio.sh old_data.sql > portfolio_data.sql` | `portfolio_data.sql` exists |
| O-02b | Or rebuild from the repo | Use `supabase/seed/portfolio_seed_from_repo.sql`. Contact history, store links and Storage URLs are lost | – |
| O-03 | Create the schema | Active project → SQL Editor → run `supabase/migrations/20261003_portfolio_schema.sql`, then `portfolio_data.sql` **or** the seed | `select count(*) from portfolio.projects` > 0 |
| O-04 | Expose the schema | Settings → API → Exposed schemas → add `portfolio` | `curl "$URL/rest/v1/profile?select=display_name" -H "apikey: $KEY" -H "Accept-Profile: portfolio"` returns the row |
| O-05 | Re-host files | Upload the CV and any project images to the active project's Storage (or elsewhere). Update `profile.resume_url`, the `social_links` row `cv`, and `projects.*_url` | The CV icon opens the PDF |
| O-06 | Give the build its config | Provide the active project URL and **publishable** key, either as GitHub repo secrets `SUPABASE_URL` / `SUPABASE_ANON_KEY` (for C-02) or in your local env for `scripts/deploy_github_pages.sh` | – |
| O-07 | Decide pending design questions | Edit `docs/design/05-open-design-issues.md`: set **UI-04** and **UI-09** to `APPROVED` or `REJECTED`, and pick an option for **UI-08**, **UI-11** and **UI-12** | No entry left in NEEDS OWNER APPROVAL or QUESTION |

---

## Phase 1: Code tasks with no visual change

| ID | Task | Details | Design gate |
|----|------|---------|-------------|
| C-01 | **Theme choice isn't persisted** | `ThemeCubit.changeTheme` → `PrefHelper.save` throws on web, and the `catch (_) {}` swallows it (localStorage stays empty after toggling, verified in headless Chromium). Find the failure (likely `Encryptor.encryptData` on web), fix it or store the bool unencrypted for this key, and log in debug instead of swallowing. Add a unit test | Verification only: toggle, reload, still dark |
| C-02 | CI deploy | Add `.github/workflows/deploy.yml`: on push to `main` → Flutter stable → `flutter build web --release --base-href=/ahmed_portfolio/` with `--dart-define`s from repo secrets (`SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SUPABASE_SCHEMA=portfolio`) → copy `index.html` to `404.html` → `.nojekyll` → publish to `gh-pages`. Mirror `scripts/deploy_github_pages.sh`. Depends on O-06 | – |
| C-03 | Real tests | Replace the template counter test in `test/widget_test.dart` (fails on `main`) with: (1) `PortfolioContentCubit` starts with `PortfolioContent.fallback` and keeps it when the repository throws; (2) pumping `PortfolioApp` with no Supabase config renders the hero name "Ahmed"; (3) `ServicesBody` with 0, 3 and 4 services doesn't throw. Needs `PrefHelper.init()` and the `ServiceLocator` set up in tests | – |
| C-04 | Stop tracking generated files | `build/` (iOS caches, stale `build/web/404.html`) and `scripts/node_modules/` are committed. `git rm -r --cached build scripts/node_modules` and add both to `.gitignore`. Until then, `npm install --no-save playwright` in `scripts/` (see `docs/design/04-verification.md`) shows up as changes, so don't commit them | – |
| C-05 | SEO / social meta | In `web/index.html` `<head>`: real `description`, `og:title`, `og:description`, `og:image` (add a 1200×630 image under `web/`), `og:url`, `twitter:card`, `<link rel="canonical">`. Optionally add a `<noscript>` text summary, since canvas text isn't indexable. No visible change | Verification only: splash unchanged |
| C-06 | Trim fonts | Remove the unused Poppins 100/200/300 from `pubspec.yaml` (and the TTFs) | Verification: capture all references, no visual diff |
| C-07 | README | Replace the Flutter template `README.md` with what the project is, how to run it, the build defines, links to `docs/SUPABASE_AND_DEPLOY.md`, `docs/design/README.md` and this plan | – |
| C-08 | Contact form without a backend | When `!SupabaseConfig.isConfigured`, `ContactRemoteDataSourceUnavailable` makes the form fail with the generic toast. Make the failure message say "Messaging is unavailable right now. Please use email or WhatsApp below." (copy-only change in the toast) | Verification: toast text |

---

## Phase 2: UI tasks (design gate REQUIRED for every row)

Read `docs/design/README.md` first. Each row's **Spec** column lists the
minimum files and IDs to read. The full target and acceptance criteria are in
`docs/design/05-open-design-issues.md`.

| Order | ID | Sev | Status gate | Task | Spec to read |
|-------|----|-----|-------------|------|--------------|
| 1 | UI-01 | High | READY | Portfolio shows previews with fallback content, and the empty state links to All Projects | `03` SCR-PORTFOLIO, `02` CMP-CAROUSEL, CMP-BTN-OUTLINE, refs `*_portfolio_with_previews.jpg` |
| 2 | UI-02 | High | READY | Tablet hero layout without the overlap | `03` SCR-HERO-T, `02` CMP-CONTACT-ICONS, `01` TOK-BP, ref `tablet_light_home.jpg` |
| 3 | UI-03 | High | READY | Dark-mode hero photo keeps transparency | `03` SCR-HERO-*, `01` TOK-COLOR-12, TOK-IMG-01, refs `*_dark_home.jpg` |
| 4 | UI-05 | Med | READY | About: line-height 1.5 everywhere, full-width text on tablet | `03` SCR-ABOUT, `01` TOK-TYPE-10 |
| 5 | UI-10 | Med | READY | Contact inputs: floating labels, error colors, autofill | `02` CMP-INPUT, `01` contrast table |
| 6 | UI-04 (mobile part) | Med | READY | "Projects" heading filled on mobile | `02` CMP-HEADING, `03` SCR-ALLPROJECTS |
| 7 | UI-06 | Low | READY | Contact tablet uses the side-by-side layout | `03` SCR-CONTACT-T |
| 8 | UI-07 | Low | READY (color waits on UI-09) | Footer: dynamic year, link semantics and hit area | `02` CMP-FOOTER |
| 9 | UI-09 | High a11y | **NEEDS OWNER APPROVAL** | `accentText` / `onPrimary` tokens for light mode | `01` TOK-COLOR contrast + TOK-COLOR-30/31 |
| 10 | UI-04 (rest) | Med | **NEEDS OWNER APPROVAL** | Filled + stroke headings on tablet/desktop | `02` CMP-HEADING |
| 11 | UI-08 / UI-11 / UI-12 | Low | **QUESTION** | Implement the option the owner picked | the entry itself |

Dependencies: UI-07's link color waits on UI-09. UI-04 (rest) and UI-09 can ship together. UI-01 also changes the seed SQL.

Per task, the PR must contain:
```
Design: <IDs>
Verified: <bp × theme list>   (screenshots from scripts/design/capture.mjs)
Spec updated: <docs/design files / reference images replaced>
```

---

## Phase 3: Release

| ID | Task | Done when |
|----|------|-----------|
| R-01 | Deploy | `main` built with the real defines and published to `gh-pages` (C-02, or `./scripts/deploy_github_pages.sh`) |
| R-02 | Live verification | On the live URL at 375 / 768 / 1280: every section shows **database** content (edit a row and see it change); the contact form inserts a row; anon can't read `portfolio.contact_messages`; CV opens; deep-link refresh works |
| R-03 | Real devices | iPhone Safari + Android Chrome: drawer, wheel/touch section chaining, form with the on-screen keyboard (footer must not cover the focused field), dark mode persists |
| R-04 | Refresh the design baseline | Re-run `scripts/design/capture.mjs` against the release build and replace `docs/design/reference/`. Update the capture date in `docs/design/README.md` |

---

## Not planned (recorded decisions)

- **Pinch-zoom on mobile web**: blocked by the Flutter engine's own viewport meta, not app-configurable. Accepted. Text sizes meet the 16 px body minimum instead.
- **Supabase Storage migration / cloud functions**: out of scope by the owner's decision.
- **Firebase**: not used; the backend stays on Supabase (`portfolio` schema).
