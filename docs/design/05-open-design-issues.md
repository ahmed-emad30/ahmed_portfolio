# 05: Open design issues and decisions

Found on 2026-10-31 by screenshotting `main` @ `7b478e8` at 375 / 768 / 1280 in
light and dark (see `reference/`). Each entry defines the **target design**
precisely enough that you need nothing outside this folder.

Status values:
- **READY**: the target is defined, so implement it as written.
- **NEEDS OWNER APPROVAL**: don't implement until the owner (Ahmed) edits
  the status to `APPROVED` (optionally picking an option).
- **QUESTION**: the owner must choose. Don't implement.

Severity: High = broken or unreadable for a visitor; Medium = noticeably wrong;
Low = polish.

---

## UI-01: Portfolio section is empty with bundled content (High, READY)
**Where:** SCR-PORTFOLIO-M/T/D. Evidence: `reference/*_light_portfolio.jpg`.
**Cause:** the carousel only shows projects where `hasPreviewImages` is true.
`PortfolioContent.fallback` gives no project preview keys, so the section
renders only "No projects available yet.", with no path to All Projects.

**Target:**
1. In `lib/core/utils/portfolio_content.dart`, give the `taggz` fallback project
   `previewImage1Key: 'portfolio1'` and `previewImage2Key: 'portfolio2'`.
   (`portfolio_1.png` and `portfolio_2.png` are Taggz screens.) Also add
   the same keys to the Taggz row in `supabase/seed/portfolio_seed_from_repo.sql`
   (`preview_image_1_key`, `preview_image_2_key`).
2. Empty state: when no project has previews **but at least one project
   exists**, show the message (16 / 400 bodyText α0.85) followed by 24 gap and
   CMP-BTN-OUTLINE "Explore All Projects", centered. When zero projects exist,
   show the message only.

**Accept:** with no backend, every band matches
`reference/<bp>_light_portfolio_with_previews.jpg`. With previews removed,
the button is still visible and opens `/portfolioScreen/allProjectsScreen`.

## UI-02: Tablet hero: social icons draw over the menu (High, READY)
**Where:** SCR-HERO-T. Evidence: `reference/tablet_light_home.jpg` (icons
overlap "SKILLS / EXPERIENCE").
**Cause:** `_HeroTabletLayout` forces the content into `SizedBox(height: 420.h)`. The
7 compact `SideMenuItem`s (each ≈ 44 px) plus the name and title need more height, so they
paint past the bottom of the box, and the `ContactSection` that follows is
placed directly after the box (420.h + 24), on top of the overflowing items.

**Target:** remove the fixed height from the row. Layout:
`Row(crossAxisAlignment: start)[ Expanded: SizedBox(height: 420.h, photo compact cover), 24.w, Expanded: Column(mainAxisSize: min)[ name (72 tablet, height 0.8), 12, title (28 / 700), 32, 7 × SideMenuItem(compact) ] ]`
→ **32.h** gap → `ContactSection(horizontal)` left-aligned to the content column.
Don't use `Expanded`/`Spacer` inside the content column.

**Accept:** at 600×960, 768×1024 and 899×1024, the icons sit ≥ 24 px below
the lowest menu item, there's no overlap, and nothing is clipped.

## UI-03: Dark mode hero photo has a grey box (High, READY)
**Where:** SCR-HERO-M/T/D in dark. Evidence: `reference/mobile_dark_home.jpg`,
`desktop_dark_home.jpg` (grey rectangle around the head; in light the dotted
background shows through).
**Cause:** `_ProfileImage` wraps the photo in
`ColorFiltered(ColorFilter.mode(Colors.grey, BlendMode.color))`, which also
paints the transparent pixels.

**Target:** the dark treatment must keep alpha. Use a luminance (greyscale)
matrix:
```dart
const ColorFilter.matrix(<double>[
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0,      0,      0,      1, 0,
])
```
(The photo is already monochrome, so this mainly keeps it neutral.) Keep the
`profileBlendMode` token, but its dark value now selects this matrix.

**Accept:** in dark at every band, the page background and texture are visible
around the head exactly where they are in light.

## UI-04: Outline-only headings on tablet/desktop are hard to read (Medium, NEEDS OWNER APPROVAL)
**Where:** About name (T/D), "Let's Connect!" (T/D), "Projects" on All
Projects (all bands, including mobile). Evidence: `tablet_light_about.jpg`,
`desktop_light_contact.jpg`, `mobile_light_all_projects.jpg`.
**Why approval is needed:** the outlined style is part of the desktop brand look.

**Proposal:** headings that carry meaning use the **filled + stroke stack**
(CMP-HEADING, as Skills and Experience already do) at every band. Pure outline
stays allowed only where a filled duplicate sits behind it (knockout:
Services T/D, Portfolio title).
- "Projects" on mobile is a **must-fix regardless of approval** (rule M3: no
  outline-only meaningful text < 600 px). Make it filled on mobile now.

**Accept (after approval):** no outline-only meaningful heading remains. The
About, Contact and All Projects references are re-captured.

## UI-05: About: cramped body text, and an empty right half on tablet (Medium, READY)
**Where:** SCR-ABOUT-T/D. Evidence: `tablet_light_about.jpg`, `desktop_light_about.jpg`.
**Target:**
- About body line-height **1.5 at every band** (TOK-TYPE-10). Today it's 26/24.spMin ≈ 1.08 on T/D.
- Tablet: text width = `maxContentWidth` (720.w, i.e. full width minus gutters) instead of 0.45.sw.
- Desktop: keep 0.45.sw and the side profile.

**Accept:** at 768 the text spans the content width. At 1280 the lines don't
touch (ascenders and descenders clear by ≥ 4 px). The page still fits without a
horizontal scroll.

## UI-06: Contact on tablet wastes width (Low, READY)
**Where:** SCR-CONTACT-T. Evidence: `tablet_light_contact.jpg`.
**Target:** at tablet width use the **desktop composition**:
`Row(spacing 32.w)[ Flexible: QR + tagline (0.36.sw), Expanded: form ]`.
In `contact_body.dart`, switch on `context.isMobile` instead of
`context.isMobileOrTablet`. The QR image stays visible on tablet.

**Accept:** at 768×1024 the QR and the form sit side by side, the first field
is visible without scrolling, and nothing overflows at 600 px.

## UI-07: Footer link contrast and hard-coded year (Low, READY except color)
**Where:** CMP-FOOTER (Contact, All Projects, Details).
**Target:**
- Year: `DateTime.now().year` instead of the literal "2025".
- Hit area: the "AE Studio" link becomes a `Semantics(link: true)` and has a
  48 px tall tap target (the footer bar may grow to 48.h if needed). Its
  label stays visually 10 px.
- Link color depends on UI-09. Until then keep accent, which is a known failure.

## UI-08: Mobile hero photo crop (Low, QUESTION)
**Where:** SCR-HERO-M (`mobile_light_home.jpg`). The 45 vh `BoxFit.cover` box
shows the right half-face floating, with no gold bar (on desktop the gold bar
explains the cut).
**Options:**
- **A** (keep): as is.
- **B**: add a **12.w** accent right border to the mobile photo box, echoing desktop.
- **C**: `BoxFit.contain`, aligned center-right, with a max height of 45 vh.
Owner picks one. Don't implement until a choice is recorded here.

## UI-09: Light-mode gold fails contrast as text (High a11y, NEEDS OWNER APPROVAL)
**Where:** everywhere gold is used as text or as a text background in light mode.
`#DEAC16` on light backgrounds is **1.4–1.8:1** (needs 3:1 large / 4.5:1 body).
The Send button label `#E1E1E1` on gold is **1.6:1**. See the contrast table in
`01-foundations.md`.
**Proposal** (introduces TOK-COLOR-30/31):
- New theme field `accentText`: light **`#8A6A00`**, dark `#DEAC16`. Use it for
  **gold text** (headings, links, titles, period pills, card titles).
  Fills, borders, icons, active lines and decorative strokes keep `primaryAccent`.
- New theme field `onPrimary` = `#212121` for text and icons on gold fills
  (Send label 7.68:1, WhatsApp glyph).
- Dark mode is unchanged.
**Accept (after approval):** every text pair in light mode is ≥ 3:1 (≥ 24 px
or bold ≥ 18.66 px) or ≥ 4.5:1 (smaller). References re-captured.

## UI-10: Contact form inputs: labels, error state, hint contrast (Medium, READY)
**Where:** CMP-INPUT.
**Target:**
- Use `labelText` (same strings: "Your Name", "Email", "Phone Number (optional)",
  "How can I help?") with `floatingLabelBehavior: auto`. Drop `hintText`.
  Label color bodyText at 100%. (Hint α0.7 measured 2.5–2.9:1, which fails.)
- Error: `errorBorder` / `focusedErrorBorder` 1.4 px **`AppColors.error` `#C1121F`**
  in light (4.2–5.4:1), **`AppColors.redProgress` `#FF8484`** in dark (6.8:1).
  The error text is 13 / 400 in the same color.
- Focused border: 2.0 px accent. Enabled: 1.4 px accent (unchanged).
- `autofillHints`: name / email / telephoneNumber. `textInputAction: next`, except
  the message field.
- Email validation: a simple `^[^@\s]+@[^@\s]+\.[^@\s]+$` check.

**Accept:** submitting empty shows three red errors, the labels float on focus,
and keyboard Tab/Next moves through the fields in order.

## UI-11: Experience eyebrow says "Explore Now!" (Low, QUESTION)
**Where:** SCR-EXPERIENCE (`desktop_light_experience.jpg`). The same eyebrow as
All Projects. Owner: keep it, change it (e.g. "My Journey"), or remove it.

## UI-12: Project Details sub-heading sizes are inconsistent (Low, QUESTION)
**Where:** SCR-DETAILS (`*_light_project_details.jpg`). "Overview" is
**24 / 700** accent (`style24Medium` + w700). "Tech Stack" and "Key Features" are
**16 / 800** accent. (The soft edges on "Overview" in the reference are JPEG
compression over the texture, not a rendering bug.)
**Options:** **A** keep (Overview is intentionally the lead heading);
**B** make all three 16 / 800; **C** make all three 24 / 700.

---

## Resolved (kept for history)
H1–H5, M1–M9 from `docs/MOBILE_AUDIT_AND_MIGRATION_PLAN.md`, done in PR #1.
