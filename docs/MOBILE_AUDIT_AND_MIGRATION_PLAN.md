# Mobile Web Audit & Supabase Migration Plan

Date: 2026-10-03. Tested `build/web` (and a copy patched to use local fallback content) at a 375×812 phone viewport in Chromium.

---

## 0. Critical: the backend is down

- `tptaqfbmqifzewewnudg.supabase.co` returns **NXDOMAIN** on public DNS (8.8.8.8 and 1.1.1.1). The project is paused or deleted.
- Because of that, every section of the live site renders **empty**. Hero shows only the photo, and About, Portfolio and Skills are blank. Services spins forever because it requires `cards.length >= 4`.
- `PortfolioContentCubit.load()` emits `PortfolioDataEntity.empty` on failure, even though `PortfolioContent.fallback` (lib/core/utils/portfolio_content.dart) already exists and nothing uses it.

## 1. Migration to the existing (active) Supabase project

Decision: move into the user's **active** Supabase project, isolated in its own Postgres schema `portfolio` (the "separate folder"), and keep **structure + real data**.

### 1a. Recover the real data (user action, needs their credentials)
1. Supabase Dashboard → old project "Ahmed Portfolio" (`tptaqfbmqifzewewnudg`). If it shows **Paused**, click **Restore**. Free-tier projects can be restored for a limited window after pausing.
2. Once it is up, the user runs the dump on their own machine (the DB password stays with them):
   ```bash
   supabase db dump --db-url "$OLD_DB_URL" --schema public -f old_schema.sql
   supabase db dump --db-url "$OLD_DB_URL" --schema public --data-only --use-copy -f old_data.sql
   ```
   Tables needed: `profile, social_links, services, skill_categories, skills, experiences, projects, contact_messages`.
3. Download the `portfolio-public` Storage files (CVs, project images) from the Dashboard. Storage itself is **not** being migrated. Re-host the files elsewhere, or keep them as external links.
4. **If the old project can't be restored**, rebuild from the repo. That means the schema documented in `docs/SUPABASE_AND_DEPLOY.md`, the content in `PortfolioContent.fallback`, and `supabase/migrations/20260807_*.sql`. **`contact_messages` history would be lost**, and some project fields would come only from the fallback (only 4 projects are there).

### 1b. Create the schema in the active project
New migration `supabase/migrations/2026100X_portfolio_schema.sql`:
- `create schema if not exists portfolio;`
- Recreate all 8 tables under `portfolio.` with the same columns (from `old_schema.sql`, or from the docs table list if rebuilding).
- `alter table ... enable row level security;` plus policies: content tables get `select` for `anon, authenticated`, and `contact_messages` gets `insert` for `anon` only.
- `grant usage on schema portfolio to anon, authenticated;` plus matching table grants.
- Load `old_data.sql` with `public.` rewritten to `portfolio.`. Then apply the 3 existing `20260807_*` migrations, also rewritten to `portfolio.`, if they were not already in the dump.
- Rewrite the `20260807_*` migrations to target `portfolio.` so they stay re-runnable.

### 1c. Expose the schema
Dashboard → Settings → API → **Exposed schemas**: add `portfolio`. Without this, PostgREST returns 404/406.

### 1d. App changes
- `SupabaseConfig`: new default URL and publishable key (public client values), plus `static const schema = String.fromEnvironment('SUPABASE_SCHEMA', defaultValue: 'portfolio');`.
- `Supabase.initialize(..., postgrestOptions: const PostgrestClientOptions(schema: SupabaseConfig.schema))` in `lib/main.dart`. Or use `_client.schema('portfolio').from(...)` in both data sources.
- `PortfolioContentCubit`: fall back to `PortfolioContent.fallback` instead of `empty`.
- Update `docs/SUPABASE_AND_DEPLOY.md`, `HOSTINGER_DEPLOY.md` and `scripts/*.mjs` (hardcoded old URL).
- Image/CV URLs that pointed at the old Storage must be updated in the data.

### 1e. Verify
- `curl "$NEW_URL/rest/v1/profile?select=*" -H "apikey: $KEY" -H "Accept-Profile: portfolio"` returns the row.
- Build web and check every section renders, the contact form inserts, and anon cannot `select` from `contact_messages`.

---

## 2. Mobile web compatibility & usability findings

Severity is rated against Material 3 guidance, WCAG 2.2 AA and common mobile-web usability heuristics.

### High
| # | Issue | Where | Fix |
|---|-------|-------|-----|
| H1 | Site shows no content when the backend fails, with no error or empty state | `portfolio_content_cubit.dart` | Use the fallback, and show an error/retry state |
| H2 | Services: infinite spinner when fewer than 4 services | `services_body.dart:24` | Show an empty state, and lay out N cards with a grid/Wrap |
| H3 | Hero on mobile: the photo fills the whole first viewport, so name, title and CTAs sit below the fold. The name also renders first, then jumps down when the image loads (layout shift) | `hero_body.dart` | Put name/title/CTA first and constrain the photo height (~45vh) with a fixed aspect ratio |
| H4 | Scroll-jacking: reaching a section edge (48px overscroll) pushes a new route. With a mouse wheel, `_atTop/_atBottom` start as `true`, so the **first wheel tick on a new section skips it entirely** (Services → Portfolio without showing Services) | `section_scroll_navigator.dart` | Start the flags as false and update them from metrics after the first frame. On mobile, prefer one continuous scroll page with anchor navigation |
| H5 | Accessibility: the Flutter semantics tree is off by default, so screen readers see nothing. `user-scalable=no` / `maximum-scale=1` blocks pinch-zoom (fails WCAG 1.4.4) | engine/index.html | Call `SemanticsBinding.instance.ensureSemantics()` on web and add `Semantics` labels to icon buttons |

### Medium
| # | Issue | Where | Fix |
|---|-------|-------|-----|
| M1 | Services cards use 2 columns at 375px, so text is clipped at `maxLines: 4` with no ellipsis ("…architecture, and") | `services_body.dart` (`_ServicesMobile`, `FeatureCard`) | Use 1 column below 400px, drop `maxLines` or add `overflow: TextOverflow.ellipsis` |
| M2 | Shadow alpha bug: `withValues(alpha: 0.3 * 255)` gives 76.5 (alpha is 0–1), so the shadow is fully opaque | `services_body.dart` FeatureCard | `withValues(alpha: 0.3)`. Grep for other `* 255` uses |
| M3 | Outlined (stroke-only) gold headings on a light dotted background have low contrast, below 3:1 for large text | Services, Contact, About headings | Use a solid fill on mobile, or a darker stroke |
| M4 | Contact: "Scan me" QR code shown on a phone, where the user can't scan their own screen | `contact_body.dart` | On mobile, replace it with tappable WhatsApp/email buttons |
| M5 | Fixed footer bar overlaps the contact form's first input on a 812px-tall screen | Contact | Make the footer part of the scroll content, or add bottom padding equal to its height |
| M6 | Header icons (menu, theme) shift position between Home (y≈16) and other sections (y≈23) | `custom_app_bar` / section scaffolds | Use one shared app bar |
| M7 | The drawer marks the active item with a short line *above* the label | `portfolio_navigation_drawer.dart` | Use the M3 `NavigationDrawer` active indicator (pill) |
| M8 | Startup: a blank grey screen with a spinner until all 7 queries finish (the HTML splash is removed at first frame, which is the spinner) | `portfolio_app.dart` | Render the fallback immediately and refresh when remote data arrives (stale-while-revalidate) |
| M9 | `ScreenUtilInit` is keyed by size class, so crossing a breakpoint (rotating a tablet) rebuilds the whole app and resets the route/scroll | `portfolio_app.dart` | Remove the key |

### Low
- `index.html` loads `main.dart.js` directly instead of `flutter_bootstrap.js`, so it misses service-worker/renderer selection. `build/web/404.html` is stale (`<base href="/ahmed_portfolio/">`).
- No SEO or social meta tags (`og:*`, canonical). Flutter canvas text isn't indexable.
- First load downloads every Poppins weight (8 TTFs). Ship only the weights you use, as WOFF2 if possible.
- `README.md` is still the Flutter template.

### Works well
- The drawer opens and closes correctly, and tap targets are at least 48px.
- Skills chips wrap cleanly at 375px.
- The Experience timeline reads well on mobile.
- Light/dark toggle is present, body text size is fine (16px), and there's no horizontal overflow.

---

## 3. Execution order
1. User: restore the old project and dump schema + data (§1a). User: provide the active project's URL and publishable key.
2. Write the `portfolio` schema migration + data load (§1b) and the app changes (§1d), including the H1 fallback.
3. User: run the migration in the active project's SQL editor and expose the schema (§1c).
4. Fix H2–H5, then M1–M9.
5. Rebuild, re-test at 375×812 and 768×1024, deploy.

---

## 4. Status (2026-10-03)

Done in code. Verified with `flutter analyze` (no new issues) and a release web build screenshotted at 375×812 in headless Chromium, using bundled content (no backend):

| # | Status |
|---|--------|
| §1b | `supabase/migrations/20261003_portfolio_schema.sql` + `supabase/seed/portfolio_seed_from_repo.sql`, tested twice in a row on Postgres 16 (anon can read content and insert messages, cannot read messages or write content) |
| §1d | `SUPABASE_SCHEMA` define + `PostgrestClientOptions(schema)`. No URL/key baked in. Without them the site renders the fallback and the contact form reports failure |
| H1, M8 | Cubit starts with `PortfolioContent.fallback` and swaps in remote data. No blank startup spinner |
| H2, M1, M2 | Services: any card count, one column on phones, no clipped text, shadow alpha fixed |
| H3 | Hero: name/title/links first, photo fixed at 45% of viewport height |
| H4 | Wheel: a tick only chains sections if the Scrollable couldn't move. The first tick on Services now scrolls Services |
| H5 | `ensureSemantics()` on web. Labels/tooltips on icon-only buttons. Contact icons have a 48px hit area. Pinch-zoom is still blocked by the Flutter engine's own viewport meta (not app-configurable) |
| M3 | Solid headings on phones (Services, About name, Let's Connect) |
| M4, M5 | QR code hidden on phones. Form, Send button and socials all reachable above the footer |
| M6 | Home uses the shared `PortfolioTopBar` (icons no longer shift) |
| M7 | Drawer uses a pill for the active item |
| M9 | `ScreenUtilInit` no longer keyed by size class |
| Low | `web/index.html` loads `flutter_bootstrap.js` |

Still on the owner: §1a dump (or accept the seed), run the migration, expose the schema, pass the URL/publishable key at build time, re-upload Storage files, and re-test on a real phone.
