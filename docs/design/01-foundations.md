# 01: Foundations (design tokens)

All values are **as built** in code on 2026-10-31 unless marked **TARGET**.
Code locations are given so you can check the spec against the source.

---

## TOK-COLOR: Color

Source: `lib/core/app_themes/colors/app_colors.dart`,
`lib/core/app_themes/colors/portfolio_theme_extension.dart`.
Widgets must read colors from `context.portfolioTheme` (theme-aware), not from
`AppColors` directly. The exceptions are the fixed brand fills listed below.

### Semantic roles

| ID | Role (`PortfolioThemeExtension` field) | Light | Dark | Used for |
|----|---------------------------------------|-------|------|----------|
| TOK-COLOR-01 | `primaryAccent` | `#DEAC16` | `#DEAC16` | Brand gold: headings, links, icons, borders, active indicators |
| TOK-COLOR-02 | `bodyText` | `#636363` | `#D9D9D9` | Body copy, secondary headings, nav text |
| TOK-COLOR-03 | `headingText` | `#DEAC16` | `#DEAC16` | (alias of accent; currently unused in widgets) |
| TOK-COLOR-04 | `scaffoldGradientStart` | `#D4D4D4` | `#4A4A4A` | Radial gradient center |
| TOK-COLOR-05 | `scaffoldGradientEnd` | `#EEEEEE` | `#212121` | Radial gradient edge, drawer background |
| TOK-COLOR-06 | `cardBackground` | `#DDDDDD` | `#4A4A4A` | Feature cards, skill category cards |
| TOK-COLOR-07 | `footerBackground` | `#636363` | `#636363` | Footer bar |
| TOK-COLOR-08 | `navText` / `navActiveText` | `#636363` | `#D9D9D9` | Navigation labels |
| TOK-COLOR-09 | `inputBackground` | `#636363` | `#4A4A4A` | (defined; inputs are currently transparent) |
| TOK-COLOR-10 | `paginationInactive` | `#FFFFFF` | `#4A4A4A` | Carousel dots |
| TOK-COLOR-11 | `textureOpacity` | `0.1` | `0.3` | (defined; texture filter is commented out) |
| TOK-COLOR-12 | `profileBlendMode` | `srcIn` | `luminosity` | Hero photo treatment. **Dark value is defective, see UI-03** |

### Fixed colors (theme-independent)

| ID | Name | Hex | Used for |
|----|------|-----|----------|
| TOK-COLOR-20 | `AppColors.primary` | `#DEAC16` | Send button fill, WhatsApp button fill, active line |
| TOK-COLOR-21 | `AppColors.secondary` | `#636363` | Gradient end of "Let's Connect!", card shadow |
| TOK-COLOR-22 | `AppColors.whiteText` | `#E1E1E1` | Footer text, Send button label |
| TOK-COLOR-23 | `AppColors.containerBackground` | `#C2C2C2` | Carousel arrow buttons |
| TOK-COLOR-24 | `AppColors.shadow` | `#7E7E7E` | Phone mockup floor shadow (α 0.45) |
| TOK-COLOR-25 | Skill legacy colors | `#B6FF85 #85E3FF #FFE885 #FF8585` | Stored in DB `skills.color_hex`. **Not rendered** (chips use accent) |

### Opacity conventions

| ID | Usage | Value |
|----|-------|-------|
| TOK-ALPHA-01 | Chip fill | `primaryAccent` α **0.08** |
| TOK-ALPHA-02 | Chip border | `primaryAccent` α **0.16** |
| TOK-ALPHA-03 | Drawer active pill | `primaryAccent` α **0.15** |
| TOK-ALPHA-04 | Muted body / empty-state text | `bodyText` α **0.85** |
| TOK-ALPHA-05 | Meta text (experience context) | `bodyText` α **0.7** |
| TOK-ALPHA-06 | Input hint | `bodyText` α **0.7** |
| TOK-ALPHA-07 | Card shadow | `AppColors.secondary` α **0.3** |
| TOK-ALPHA-08 | Skill card shadow / border | `bodyText` α **0.06 / 0.08** |

`withValues(alpha:)` takes **0.0–1.0**. Never multiply by 255 (that was bug M2).

### Contrast (WCAG 2.2): measured

| Pair | Ratio | AA normal (4.5) | AA large / UI (3.0) |
|------|-------|-----|-----|
| `#DEAC16` on light bg `#D4D4D4` | **1.41** | ❌ | ❌ |
| `#DEAC16` on light bg `#EEEEEE` | **1.81** | ❌ | ❌ |
| `#DEAC16` on light card `#DDDDDD` | **1.54** | ❌ | ❌ |
| `#636363` on `#D4D4D4` | 4.05 | ❌ | ✅ |
| `#636363` on `#EEEEEE` | 5.18 | ✅ | ✅ |
| `#636363` on card `#DDDDDD` | 4.42 | ❌ (borderline) | ✅ |
| `#E1E1E1` on `#DEAC16` (Send button) | **1.60** | ❌ | ❌ |
| `#FFFFFF` on `#DEAC16` | 2.10 | ❌ | ❌ |
| `#212121` on `#DEAC16` | 7.68 | ✅ | ✅ |
| `#DEAC16` on dark `#212121` | 7.68 | ✅ | ✅ |
| `#DEAC16` on dark card `#4A4A4A` | 4.23 | ❌ (borderline) | ✅ |
| `#D9D9D9` on `#4A4A4A` | 6.28 | ✅ | ✅ |
| `#E1E1E1` on footer `#636363` | 4.59 | ✅ | ✅ |
| `#DEAC16` link on footer `#636363` | 2.87 | ❌ | ❌ |
| Hint `#636363`@70% on `#EEEEEE` (≈`#8E8E8E`) | 2.82 | ❌ | ❌ |

**Conclusion:** dark mode passes. In **light mode the brand gold fails as text
everywhere**. The fix is a brand decision, tracked as **UI-09 (NEEDS OWNER
APPROVAL)**. Proposed tokens, which are **TARGET and not yet approved**:

| ID | Proposed role | Light | Dark | Ratio (light) |
|----|---------------|-------|------|---------------|
| TOK-COLOR-30 (TARGET) | `accentText`: gold used **as text** on light surfaces | `#8A6A00` | `#DEAC16` | 4.37 on `#EEEEEE`, 3.0+ on `#D4D4D4` for ≥24px |
| TOK-COLOR-31 (TARGET) | `onPrimary`: text/icons on a gold fill | `#212121` | `#212121` | 7.68 |

Until UI-09 is approved, keep using `primaryAccent` for text and **do not
introduce new gold shades**.

---

## TOK-TYPE: Typography

Source: `lib/core/app_themes/text_style/app_text_style.dart`,
`font_weight_helper.dart`, `pubspec.yaml` (fonts).

- **Family:** `Poppins` everywhere (theme default), with `Cairo` as fallback for Arabic.
  The footer is the one exception and uses `Inter` 500.
- **Weights in use:** 400 regular, 500 medium, 600 semibold (drawer active
  item only), 700 bold, 800 extrabold. Weights 100/200/300 ship in `pubspec.yaml`
  but are **unused** (see C-06).
- **Scaling:** `AppTextStyle.*` sizes are `size.spMin` (ScreenUtil). Section
  sizes go through `context.responsiveSp(mobile:, tablet:, desktop:)`, which
  returns the **raw logical px on mobile** and `.spMin` on tablet/desktop.

### Type scale by role

| ID | Role | Style | Mobile | Tablet | Desktop | Line height | Color |
|----|------|-------|--------|--------|---------|-------------|-------|
| TOK-TYPE-01 | Section display heading ("Services", "Skills", "Experience") | 800 | 56 | 80 | 128 | default | accent (fill or fill+stroke, see CMP-HEADING) |
| TOK-TYPE-02 | Hero / About name ("Ahmed Emad.") | 800 | 48 (min 28) | 64–72 | 96 | **0.8** | accent |
| TOK-TYPE-03 | "Let's Connect!" | 800 | 48 | 96 | 100 | default | gradient `#DEAC16 → #636363` |
| TOK-TYPE-04 | Portfolio outline title ("TAGGZ") | 800 | 56 | (`outlineFontSize`) | (`outlineFontSize`) | 1 / 0.7 | accent stroke |
| TOK-TYPE-05 | Eyebrow ("Explore Now!") | 800 | 28 | – | 40 | 0.8 | bodyText |
| TOK-TYPE-06 | Hero job title | 700 | 22 | 28 | 36 | 1 | bodyText |
| TOK-TYPE-07 | Experience role | 700 | 22 | – | 32 | 1.1 | accent |
| TOK-TYPE-08 | Nav item (desktop top bar / hero side menu) | 400 | 18 | 24 | 32 | default | bodyText |
| TOK-TYPE-09 | Drawer item | 400 (600 active) | 24 | 24 | – | default | navText / accent active |
| TOK-TYPE-10 | About body | 400 | 16 | 20 | 24 | mobile **1.5**, else **26/24.spMin ≈ 1.08** (defect, UI-05) | bodyText |
| TOK-TYPE-11 | Skills subtitle | 400 | 16 | 20 | 24 | 1.3 | bodyText |
| TOK-TYPE-12 | Card title (service, skill category) | 800 | 16 | 16 | 16 | 1 / 1.2 | accent |
| TOK-TYPE-13 | Card body (service description) | 500 | 16 | 16 | 16 | 1.3 | bodyText |
| TOK-TYPE-14 | Body / bullets | 400 | 14–16 | – | 16 | 1.5 | bodyText |
| TOK-TYPE-15 | Input text & hint, Send label | 500 | 16 | 16 | 16 | 1.25 | bodyText / hint α0.7 / whiteText |
| TOK-TYPE-16 | Chips, period pill | 400 | 13 | 13 | 13 | 1.2 | bodyText / accent |
| TOK-TYPE-17 | Footer | Inter 500 | 10 | 10 | 10 | 1.0 | whiteText + accent link |
| TOK-TYPE-18 | "Explore All Projects" button | 500 | 24 | 24 | 24 | 40/24 | bodyText |

Rules:
- **Minimum body size is 14 logical px on mobile** (13 is allowed only for chips and pills).
- Display headings at line-height < 1 (0.7–0.8) are intentional for tight
  stacking. **Never use < 1.3 for multi-line body copy.**

---

## TOK-SPACE: Spacing and layout

Source: `lib/core/utils/responsive_values.dart`.

| ID | Token | Mobile | Tablet | Desktop |
|----|-------|--------|--------|---------|
| TOK-SPACE-01 | `horizontalPadding` (page gutter) | 16.w | 32.w | 60.w |
| TOK-SPACE-02 | `sectionTopPadding` | 24.h | 64.h | 100.h |
| TOK-SPACE-03 | `maxContentWidth` | ∞ | 720.w | ∞ |
| TOK-SPACE-04 | `gridColumns` (skills, project grid) | 1 | 2 | 3 |
| TOK-SPACE-05 | Grid gap | 16 | 16 | 16 |

Spacing steps in use: **4, 8, 10, 12, 16, 20, 24, 32, 40, 48, 72** (logical px,
scaled with `.w`/`.h`/`.r`). New code picks from this list.

## TOK-RADIUS: Corner radius

| ID | Value | Used for |
|----|-------|----------|
| TOK-RADIUS-01 | 4 | Text inputs |
| TOK-RADIUS-02 | 8 | Skill / tech chips |
| TOK-RADIUS-03 | 10 | Cards, Send button, social buttons, carousel arrows, dashed frames |
| TOK-RADIUS-04 | 12 | Inline images (About tablet/mobile photo, currently commented out) |
| TOK-RADIUS-05 | 20 | Experience period pill |
| TOK-RADIUS-06 | stadium | Drawer active pill |
| TOK-RADIUS-07 | 40.h | Phone mockup floor shadow ellipse |

## TOK-ELEV: Elevation / shadow

| ID | Used for | Spec |
|----|----------|------|
| TOK-ELEV-01 | Service FeatureCard | `#636363` α0.3, blur 22, offset (0, 2) |
| TOK-ELEV-02 | Skill category card | `bodyText` α0.06 shadow + α0.08 border |
| TOK-ELEV-03 | Phone mockup floor | `#7E7E7E` α0.45 ellipse, radius 40.h |

No Material elevation (`elevation:` > 0) is used anywhere. Keep it that way.

## TOK-BP: Breakpoints and scaling

Source: `lib/core/utils/screen_size_utils.dart`, `lib/core/app/portfolio_app.dart`.

| ID | Band | Width | ScreenUtil design size | Navigation |
|----|------|-------|------------------------|------------|
| TOK-BP-01 | mobile | < 600 | 375 × 812 | Top bar: menu + theme toggle; drawer |
| TOK-BP-02 | tablet | 600–899 | 768 × 1024 | Same as mobile (`useCompactNavigation`) |
| TOK-BP-03 | desktop | ≥ 900 (`largeDesktop` ≥1200, `xl` ≥1800 share the desktop layout) | 1280 × 843 | Inline top nav (`TopAppNavigator`) + toggle |

Test viewports: **375×812, 768×1024, 1280×843** (plus 390×844 and 1440×900
as smoke checks). `ScreenUtilInit` is intentionally **not keyed** by band
(M9), so a resize keeps the route and scroll position.

## TOK-MOTION: Motion

| ID | What | Value | Source |
|----|------|-------|--------|
| TOK-MOTION-01 | Section route transition (vertical slide) | 550 ms | `app_transition_page.dart` |
| TOK-MOTION-02 | Edge-scroll chaining cooldown | 900 ms | `section_scroll_navigator.dart` |
| TOK-MOTION-03 | Edge-scroll overscroll threshold | 48 px | same |
| TOK-MOTION-04 | Hover interaction | 200 ms | `hover_interaction.dart` |
| TOK-MOTION-05 | List item entrance | 375 ms | `app_animate.dart` |
| TOK-MOTION-06 | Carousel dot | 300 ms | `dot_item.dart` |

Respect reduced motion: new animations ≥ 300 ms must be skippable when
`MediaQuery.disableAnimations` is true.

## TOK-IMG: Imagery and icons

| ID | Asset | Treatment |
|----|-------|-----------|
| TOK-IMG-01 | `photos/front_profile.png` (half-face portrait, transparent bg) | Hero. Light: as is. Dark: `ColorFiltered(grey, BlendMode.color)`, which **paints the transparent area grey (UI-03)** |
| TOK-IMG-02 | `photos/side_profile.png` | About, desktop only, right-aligned, full height |
| TOK-IMG-03 | `photos/angle_phone.png` | Services centerpiece |
| TOK-IMG-04 | `photos/scan_qr.png` | Contact, tablet/desktop only |
| TOK-IMG-05 | `photos/texture.png` | Dotted halftone overlay on every page (`PortfolioScaffoldBackground`, `BoxFit.cover`) |
| TOK-IMG-06 | `photos/{taggz,iconcierge,wepick,alltraders}.png` | Project covers (`image_key`) |
| TOK-IMG-07 | `photos/portfolio_1.png`, `portfolio_2.png` | Taggz app screens: Portfolio carousel previews |
| TOK-IMG-08 | `svg/*` | Icons. Contact set: `github, linked_in, email, whats, cv, x`. Theme: `light_mode, dark_mode`. Nav: `left_Arrow, right_Arrow`. Links: `google_play, app_store, apk, web, windows, video, export` |

Background: every page uses `PortfolioScaffoldBackground`, a radial gradient
(`TOK-COLOR-04` → `TOK-COLOR-05`, radius 1.2) plus `texture.png` cover.
