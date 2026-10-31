# 03: Screens

Each screen has an ID per breakpoint: `SCR-<NAME>-M` (375), `-T` (768) and
`-D` (1280). For each one: the **reference image**, the **layout** (top to
bottom, or left to right), the **measurements**, and **deviations** (known
defects that link to `05-open-design-issues.md`).

Routes (`lib/core/app_routes/routes_strings.dart`), in navigation order:
`/homeScreen → /aboutScreen → /servicesScreen → /portfolioScreen → /skillsScreen → /experienceScreen → /contactScreen`.
Sub-routes: `/portfolioScreen/allProjectsScreen`, `/portfolioScreen/project/:projectId`.

Shell (all sections except Home): `AppScreenNavigator` →
`SectionScrollNavigator` → `ShellScaffold` (drawer on compact) →
`PortfolioScaffoldBackground` → `Column[ CMP-TOPBAR, Expanded(CustomScrollView) ]`.
The body gets horizontal padding TOK-SPACE-01. The footer (CMP-FOOTER) is
`bottomNavigationBar` on Contact, All Projects and Project Details only.

**Section chaining:** scrolling past the top or bottom edge of a section (48 px
of overscroll, or a wheel tick the content couldn't absorb) goes to the
previous or next section with a 550 ms vertical slide. The first wheel tick
on a new section must scroll that section, not skip it (H4, fixed).

---

## SCR-HERO: Home (`/homeScreen`)
Files: `lib/features/home/presentation/home_screen/ui/home_screen.dart`,
`lib/features/hero/presentation/hero_screen/ui/widgets/hero_body.dart`.

### SCR-HERO-M (375): `reference/mobile_light_home.jpg`, `mobile_dark_home.jpg`
`Stack[ HeroBody, Positioned(top 0, gutters) CMP-TOPBAR ]`. HeroBody scrolls, with padding **L16 T72 R16 B24**:
1. Name (TOK-TYPE-02): 48, min 28, max 2 lines (`displayNameWithBreak` = "Ahmed\nEmad."), height 0.8, accent.
2. 12 gap. Job title (TOK-TYPE-06): 22 / 700 bodyText.
3. 24 gap. CMP-CONTACT-ICONS horizontal, centered.
4. 24 gap. Photo `front_profile`: **height 0.45 × screen height**, full width, `BoxFit.cover`.

Acceptance: the name, title and icons are fully visible in the first 812 px without scrolling (H3). Nothing shifts when the photo loads.
**Deviations:** dark photo shows a grey box (**UI-03**). The cover crop shows only the right half-face (**UI-08**, decision).

### SCR-HERO-T (768): `reference/tablet_light_home.jpg`
`SingleChildScrollView(padding 24.w × 72.h)`:
1. `SizedBox(height 420.h) Row[ photo (compact, Expanded) | 24 | _HeroContent(no toggle, compact nav) ]`.
2. 24 gap, then CMP-CONTACT-ICONS horizontal.

_HeroContent: name (flex 5 with title) + side menu (flex 5) of 7 `SideMenuItem`s (18/24/32 uppercase, active bar 5.w × 28.h accent).
**Deviations:** the side menu overflows the 420.h box, and the social icons draw **on top of** "SKILLS / EXPERIENCE" (**UI-02**, high).

### SCR-HERO-D (1280): `reference/desktop_light_home.jpg`, `desktop_dark_home.jpg`
Full screen (1.sw × 1.sh) `Row`:
1. CMP-CONTACT-ICONS vertical (75.w column).
2. `Expanded Row(spacing 32.w, end)`:
   - Photo: `Expanded`, height 1.sh, cover, with a **30.w accent right border** (the gold bar).
   - `_HeroContent`: theme toggle top-right (end 24.w, top 8.h). Name 96 / 800 (flex 5 with title 36 / 700). Then the side menu (flex 5), 32 / 400 uppercase, with the active bar **5.w × 50.h**. Then Spacer(1).
**Deviations:** dark photo grey box (**UI-03**).

---

## SCR-ABOUT: About (`/aboutScreen`)
File: `lib/features/about/presentation/about_screen/ui/widgets/about_body.dart`.

| Band | Reference | Layout |
|------|-----------|--------|
| M | `mobile_light_about.jpg` | Name **filled** accent 48 / 800, height 0.8 → 16 gap → about text 16 / 400, **height 1.5**, full width |
| T | `tablet_light_about.jpg` | Name **outline** 72 → about text 20, width **0.45.sw**, height ≈1.08 |
| D | `desktop_light_about.jpg` | Same as T at 96 / 24, plus `side_profile.png` full height on the right (desktop only, `IgnorePointer`) |

**Deviations:** tablet/desktop body line-height ≈1.08 is cramped, and the tablet right half is empty (**UI-05**). Outline name on T/D (**UI-04**).

---

## SCR-SERVICES: Services (`/servicesScreen`)
File: `services_body.dart`. Content: `services` table (fallback: 4 items).

| Band | Reference | Layout |
|------|-----------|--------|
| M | `mobile_light_services.jpg` | Heading "Services" **filled** 56 (left) → 24 → `angle_phone` 260.h → 24 → **one column** of compact CMP-FEATURE-CARDs, 16 gap. Empty list → "No services listed yet." (16 / 400 bodyText α0.85) |
| T | `tablet_light_services.jpg` | Max width 720.w, centered. Row[card0, 16, card1] → 32 → knockout heading 80 over `angle_phone` 320.h → 32 → Row[card2, 16, card3] |
| D | `desktop_light_services.jpg`, `desktop_dark_services.jpg` | Stack: padding 100 v. Row(spaceBetween)[card0, card1]. Expanded center: branching SVGs (`top_left/bottom_left` and `top_right/bottom_right`) around the "Services" fill at 128. Row(spaceBetween)[card2, card3]. Overlay: `angle_phone` (start 40) + stroke-only "Services" |

Rule: T and D layouts are built for **exactly 4** services. Any other count falls back to the M layout at every width (H2).

---

## SCR-PORTFOLIO: Portfolio (`/portfolioScreen`)
File: `portfolio_body.dart`.

| Band | Reference (target) | Layout |
|------|--------------------|--------|
| M | `mobile_light_portfolio_with_previews.jpg` | Outline title (project name, e.g. "TAGGZ", 56) above → two phone mockups side by side, overlapping slightly, with floor shadow → arrows overlaid on the stage (if > 1 project) → CMP-BTN-OUTLINE "Explore All Projects" |
| T | `tablet_light_portfolio_with_previews.jpg` | Knockout title centered behind the phones (phone heights 0.5 / 0.48 × screen height) → button |
| D | `desktop_light_portfolio_with_previews.jpg` | Same as T, phones 0.62 / 0.59 sh, title band 290.w × 80.h shadow rotated 13.24° |

**Deviations:** with the bundled fallback content, no project has preview images, so every band shows only "No projects available yet." (`*_light_portfolio.jpg`). There's also no way to reach All Projects from that state (**UI-01**, high).

---

## SCR-SKILLS: Skills (`/skillsScreen`)
File: `skills_body.dart`. References: `*_light_skills.jpg`, `*_dark_skills.jpg`.
1. Heading "Skills": filled + stroke stack (56 / 80 / 128).
2. Subtitle `profile.skills_subtitle` (TOK-TYPE-11) 16 / 20 / 24, height 1.3.
3. Grid of CMP-SKILL-CARDs, 1 / 2 / 3 columns, gap 16.
No known deviations.

---

## SCR-EXPERIENCE: Experience (`/experienceScreen`)
Files: `experience_body.dart`, `experience_entry.dart`. References: `*_light_experience.jpg`.
1. Eyebrow "Explore Now!" (TOK-TYPE-05) 28 m / 40 d, bodyText, height 0.8.
2. Heading "Experience": filled + stroke stack.
3. 48 gap, then CMP-TIMELINE entries, newest first (`sort_order`). Section padding top 32.h, bottom 40.h. Empty → "No experience entries yet." (16 / 400 bodyText α0.85).
**Question:** the eyebrow repeats the All Projects copy ("Explore Now!"). Confirm the wording (**UI-11**, low).

---

## SCR-CONTACT: Contact (`/contactScreen`)
File: `contact_body.dart`. `ListView`: 32 gap → heading → content.

| Band | Reference | Layout |
|------|-----------|--------|
| M | `mobile_light_contact.jpg`, `mobile_dark_contact.jpg` | "Let's Connect!" **filled gradient** 48 → tagline (16 / 500, centered, height 1.5) **without the QR image** → 24 → form (CMP-INPUT × 4, gap 20) → CMP-BTN-PRIMARY → social row (CMP-BTN-SOCIAL) → 8. Footer |
| T | `tablet_light_contact.jpg` | Heading **outline** gradient 96 → Column[ QR image + tagline (width 0.36.sw), form full width ] |
| D | `desktop_light_contact.jpg`, `desktop_dark_contact.jpg` | Heading outline 100 → Row(spacing 32.w)[ Flexible: QR + tagline, Expanded: form ] |

Acceptance: at 375×812, every field, the Send button and the social row can be reached above the footer by scrolling. The footer never covers a focused field.
**Deviations:** outline heading on T/D (**UI-04**). The tablet stacks the QR column at a third of the width above a full-width form, which leaves an empty right side (**UI-06**). Send label contrast (**UI-09**). Inputs have no labels and a weak error state (**UI-10**).

---

## SCR-ALLPROJECTS: All Projects (`/portfolioScreen/allProjectsScreen`)
File: `all_projects_screen.dart`. References: `*_light_all_projects.jpg`.
1. Eyebrow "Explore Now!" (bodyText 800) → "Projects" **outline** accent (**UI-04**).
2. CMP-PROJECT-ROW × N, 8 per page (`AppConstants.projectsPerPage`), pagination dots.
3. Footer.

## SCR-DETAILS: Project Details (`/portfolioScreen/project/:slug`)
File: `lib/features/portfolio/presentation/project_details/ui/project_details_screen.dart`. References: `*_light_project_details.jpg`.
1. Index "01" (48 / 800 accent) → title (28 m / 48 d, 800 accent).
2. Cover in a dashed frame with a soft shadow (M: full width; D: left ≈ 500 wide).
3. "Overview" (**24 / 700** accent, unlike its siblings, **UI-12**) → 12 → full description 16 / 400 bodyText, height 1.6 → 28.
4. "Tech Stack" (16 / 800 accent) → 12 → chips (radius 20, 15 / 500).
5. "Key Features" (16 / 800 accent) → accent-dot bullets.
6. Store/source links row (`project_links_row.dart`): icons hidden when the URL is empty.
7. Footer. An unknown slug → message 24 / 400 (not found).

---

## SCR-DRAWER: Drawer (mobile/tablet)
See CMP-DRAWER. Opens from the top-bar menu icon on every compact screen. The current section is marked with the pill.
