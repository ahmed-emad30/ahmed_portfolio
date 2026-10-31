# 02: Components

Each entry gives the **file**, **anatomy**, **measurements**, **states** and
**a11y rules**. Sizes use logical px and are scaled by ScreenUtil
(`.w/.h/.r`) as in code. Token IDs refer to `01-foundations.md`.

Global a11y rules that apply to every component:

| ID | Rule |
|----|------|
| A11Y-01 | Every tappable element has a **hit area ≥ 48×48** (the visual can be smaller) |
| A11Y-02 | Icon-only controls have a **`Tooltip` + `Semantics(button: true, label:)`** with a human label (e.g. "GitHub", "Open menu") |
| A11Y-03 | Clickable non-buttons on web show `SystemMouseCursors.click` |
| A11Y-04 | Text contrast: body ≥ 4.5:1, ≥ 24px or bold ≥ 18.66px text ≥ 3:1, UI borders/icons ≥ 3:1 (see TOK-COLOR contrast table) |
| A11Y-05 | Semantics is enabled on web (`SemanticsBinding.instance.ensureSemantics()` in `main.dart`). Never remove it |
| A11Y-06 | Don't convey state by color alone. The active nav item uses a shape (line or pill) **and** color |

---

## CMP-TOPBAR: Top bar (`PortfolioTopBar`)
File: `lib/core/widgets/custom_app_bar.dart`. Used on **every** section,
including Home (since M6). Reference: any `*_light_*.jpg` top 80 px.

- Box: height **80.h**, top padding **12.h**, horizontal padding = TOK-SPACE-01.
- **Compact (mobile/tablet):** `Row[ menu IconButton, Spacer, ThemeToggleButton(compact) ]`.
  - Menu: `Icons.menu`, color accent, constraints 48×48, padding 0, tooltip **"Open menu"**. Opens the drawer.
  - Icon center lands at **(x = gutter + 24, y ≈ 46)** on every screen. A change that moves it is a regression (M6).
- **Desktop:** `Row(spaceBetween)[ TopAppNavigator, ThemeToggleButton ]`.

## CMP-TOPNAV: Desktop inline navigation (`TopAppNavigator`)
File: `lib/core/widgets/top_app_navigator.dart`, `app_navigator_item.dart`, `active_line.dart`.
Reference: `desktop_light_services.jpg`.

- Items in order: Home, About, Services, Portfolio, Skills, Experience, Contact (`AppConstants.items`).
- Item gap **35.w**. Label TOK-TYPE-08 (Poppins 400, 32 desktop), color bodyText.
- **Active:** `ActiveLine` **35.w × 5.r**, radius 5, `#DEAC16`, centered **above** the label.

## CMP-DRAWER: Navigation drawer (`PortfolioNavigationDrawer`)
File: `lib/core/widgets/portfolio_navigation_drawer.dart`. Mobile and tablet only.
Reference: no static file yet (open the menu). The Skills-active state is described here.

- Background `scaffoldGradientEnd`. Padding 24.w / 24.h inside `SafeArea`.
- Header: "Ahmed Emad" 32 / 700 accent → 8 gap → "Flutter Developer" 16 / 500 bodyText → 32 gap.
- Items: `ListTile`, content padding 16.w horizontal, separator 8.
  - Label 24 / 400 `navText`.
  - **Active:** `StadiumBorder` pill, fill accent α0.15 (TOK-ALPHA-03), label accent **600**.
- Tap closes the drawer, then navigates with `SectionNavigation.go`.

## CMP-THEME-TOGGLE: Theme toggle (`ThemeToggleButton`)
File: `lib/core/widgets/theme_toggle_button.dart`.
- SVG `light_mode` (shown in light) / `dark_mode` (shown in dark), **22.r** compact / **28.r** full.
- `IconButton` 48×48, padding 0. Tooltip **"Switch to dark theme"** / **"Switch to light theme"**.
- The choice must persist across reloads. **It currently does not (C-01).**

## CMP-HEADING: Section display headings
Three variants exist. Pick the one listed for the screen in `03-screens.md`.

| Variant | How | Where |
|---------|-----|-------|
| **Filled** | `TextStyle(color: accent)` | Mobile headings (Services, About name, Let's Connect), Skills, Experience |
| **Filled + stroke stack** | `Stack[ stroke(2px accent), fill(accent) ]` | Skills, Experience (all bands) |
| **Knockout over image** | `Stack[ fill text, image, stroke-only text ]`. The fill is hidden where the image covers it and the outline shows on top | Services tablet/desktop (`desktop_light_services.jpg`), Portfolio "TAGGZ" title |
| **Outline only** | `foreground: AppMethods.textStroke(accent, 2)` | About name (tablet/desktop), "Projects" (All Projects), "Let's Connect!" (tablet/desktop) |

Rule (A11Y-04 / M3): **Outline-only text is not allowed for text that carries
meaning at < 600 px width.** Outline-only on tablet/desktop is an open
contrast issue (UI-04).

## CMP-CONTACT-ICONS: Social icon group (`ContactSection` + `ContactIcon`)
Files: `lib/features/hero/presentation/hero_screen/ui/widgets/contact_section.dart`, `contact_icon.dart`.

- Order: GitHub, LinkedIn, Email, WhatsApp, CV. Labels: "GitHub", "LinkedIn", "Email", "WhatsApp", "Resume (CV)".
- Each icon is wrapped in `Tooltip` + `Semantics(button, label)` + click cursor. Bottom padding 7.
- **Horizontal (mobile, tablet):** centered `Row`, 8.w padding each side.
- **Vertical (desktop):** column width **75.w**. A dashed line (`DashedLinePainter`) **35.w × 0.24.sh** runs from the top edge, then 10.h gap, then the icons indented 35.w (`desktop_light_home.jpg` left edge).
- URLs come from `social_links` (`resolveLinkUrl(key)`). The CV falls back to `profile.resume_url`.

## CMP-FEATURE-CARD: Service card (`FeatureCard`)
File: `lib/features/services/presentation/services_screen/ui/widgets/services_body.dart`.

- Background `cardBackground`, radius **10.r**, shadow TOK-ELEV-01.
- Padding: **compact (mobile)** 16 h × 24 v; **regular** 24 h × 38 v.
- Width: mobile full width; tablet `Expanded` in a 2-column row; desktop **0.27.sw**.
- Title TOK-TYPE-12 (16 / 800 accent, height 1) → 8.h → description TOK-TYPE-13.
- Description lines: compact **unlimited**; regular **max 4 with ellipsis**.

## CMP-SKILL-CARD and CMP-CHIP
File: `lib/features/skills/presentation/skills_screen/ui/widgets/skills_body.dart`.

- Card: full width of its grid cell, padding 22 h × 24 v, radius 10.r, bg `cardBackground`, TOK-ELEV-02.
- Card title: 16 / 800 accent, height 1.2. Then a `Wrap` of chips with spacing 10.w / runSpacing 10.h.
- **Chip:** padding 14 h × 9 v, radius 8.r, fill accent α0.08, border accent α0.16, label 13 / 400 bodyText.
- Grid: TOK-SPACE-04 columns, gap 16.

## CMP-TIMELINE: Experience entry (`ExperienceEntry`)
File: `lib/features/experience/presentation/experience_screen/ui/widgets/experience_entry.dart`.
Reference: `mobile_light_experience.jpg`, `desktop_light_experience.jpg`.

- Rail column **28.w**: dot **14.r** (accent fill, 2px accent border) on top of a vertical line **2.w** accent.
- Content:
  1. Period pill: padding 14 × 6, radius 20.r, text 13 / 400 accent.
  2. Role: 700, 22 m / 32 d, accent, height 1.1.
  3. Company: 500, 15 m, bodyText, height 1.2.
  4. Context: 500, 13 m, bodyText α0.7.
  5. Bullets: 6.r accent dot (top 8, right 10) + 14 m / 16 d regular text, height 1.5, bottom 8 each.
  6. Tech tags: `Wrap` spacing 8.w of chips with padding 12 × 7, radius 8, the same fill/border as CMP-CHIP, 13 / 400.
- Entry bottom spacing 32.

## CMP-INPUT: Contact text field (`ContactInputField`)
File: `lib/features/contact/presentation/contact_screen/ui/widgets/contact_body.dart`.

- Outline border **accent 1.4.dm**, radius **4.r**, the same border in every state (enabled/focused/error).
- Content padding 24 h × 18 v. Text 16 / 500 bodyText, height 1.25. Hint bodyText α0.7.
- Message field `maxLines: 7`. Gap between fields 20.h.
- Validation: name required; email required and contains "@"; message required. Phone is optional.
- Known gaps: the hint fails contrast (2.8:1). The error state has no distinct color. There are no visible labels (only hints). See UI-10.

## CMP-BTN-PRIMARY: Send button (`SendMessageButton`)
- Full width, height **48**, horizontal padding 17.w, radius 10.r, fill `#DEAC16`.
- Label "Send Message" 16 / 500 `#E1E1E1` (**1.6:1, fails**, UI-09).
- Loading: 20.dm white `CircularProgressIndicator` (stroke 2). Taps are ignored while submitting.
- Result: a toast "Message sent successfully" / "Failed to send message. Try again."

## CMP-BTN-SOCIAL: WhatsApp and dashed icon buttons (`_LabeledTapTarget`)
- Visual **35.dm** square, radius 10.r, inside a **48×48 hit area**, with tooltip + semantics label.
- WhatsApp: gold fill, white glyph. Others (Email, LinkedIn, X): **dotted** 2px gold border, dash [6, 3], icon 20.dm.
- Row: centered, spacing 12.w. Order: WhatsApp, Email, LinkedIn, X.

## CMP-BTN-OUTLINE: "Explore All Projects" (dashed outline button)
File: `portfolio_body.dart`.
- `DottedBorder` radius 10.r, dash [10, 3, 10, 3], bodyText color. Label 24 / 500 bodyText, height 40/24.
- Centered under the carousel (`desktop_light_portfolio_with_previews.jpg`).

## CMP-CAROUSEL: Portfolio preview stage and arrows
File: `portfolio_body.dart`.
- Stage: knockout title (CMP-HEADING) + two phone mockups (`buildPreview(index: 1|2)`) + a floor shadow ellipse (TOK-ELEV-03).
- Shows **only projects with preview images** (`hasPreviewImages`). With none, the section shows "No projects available yet." (**UI-01**).
- Arrows (`NavigationIconButton`): square **52.dm compact / 75.dm**, radius 10, fill `#C2C2C2`, `InkWell`, tooltip "Previous project" / "Next project". They appear only when there is more than one featured project.

## CMP-PROJECT-ROW: All-projects list item
File: `lib/features/portfolio/presentation/portfolio_screen/ui/all_projects_screen.dart`. Reference: `*_light_all_projects.jpg`.
- Dashed-frame cover image (`image_url` → `image_key`) + index ("01", 48 / 800 accent) + title (accent, 800) + short description (bodyText) + link "View full project details ↗" (accent).
- Mobile: stacked. Desktop: cover left (≈380 wide), text right.

## CMP-FOOTER: Footer (`Footer`)
File: `all_projects_screen.dart`. Shown on All Projects, Project Details and Contact only.
- Height **30.h**, full width, `footerBackground`, centered single line, Inter 10 / 500.
- Text: "Ahmed Emad © 2025. Designed by **{ae_studio_label}**. All Rights Reserved". The label is accent and underlined, and links to `ae_studio_url`.
- The year is hard-coded "2025" and the link fails contrast (2.87:1), see UI-07.

## CMP-PAGE-BG: Page background (`PortfolioScaffoldBackground`)
- Radial gradient TOK-COLOR-04 → 05 (radius 1.2) + `texture.png` cover. Applied to every route.
