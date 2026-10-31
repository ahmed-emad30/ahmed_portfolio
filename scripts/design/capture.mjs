/**
 * Captures the design reference / verification screenshot set described in
 * docs/design/04-verification.md.
 *
 * Usage (from scripts/):
 *   npm install --no-save playwright        # once; Chromium must be available
 *   node design/capture.mjs http://localhost:8765 ../build/design-shots
 *
 * Options (env):
 *   ONLY=home,services        # subset of screen names
 *   BREAKPOINTS=mobile,tablet # subset of breakpoints
 *   THEMES=light              # light, dark or both (default both)
 *
 * File names match docs/design/reference/: <breakpoint>_<theme>_<screen>.jpg
 */
import { chromium } from 'playwright';
import { mkdirSync } from 'node:fs';

const [baseUrl = 'http://localhost:8765', outDir = 'design-shots'] =
  process.argv.slice(2);
mkdirSync(outDir, { recursive: true });

const screens = {
  home: 'homeScreen',
  about: 'aboutScreen',
  services: 'servicesScreen',
  portfolio: 'portfolioScreen',
  skills: 'skillsScreen',
  experience: 'experienceScreen',
  contact: 'contactScreen',
  all_projects: 'portfolioScreen/allProjectsScreen',
  project_details: 'portfolioScreen/project/taggz',
};
const breakpoints = { mobile: [375, 812], tablet: [768, 1024], desktop: [1280, 843] };
const pick = (env, all) => (process.env[env] ? process.env[env].split(',') : all);

const onlyScreens = pick('ONLY', Object.keys(screens));
const onlyBps = pick('BREAKPOINTS', Object.keys(breakpoints));
const themes = pick('THEMES', ['light', 'dark']);

const browser = await chromium.launch();
for (const theme of themes) {
  for (const bp of onlyBps) {
    const [width, height] = breakpoints[bp];
    // en-US: headless Chromium's default locale crashes intl in this app.
    const page = await browser.newPage({ viewport: { width, height }, locale: 'en-US' });
    page.on('pageerror', (e) => console.log(`[${bp}/${theme}] pageerror:`, e.message));
    for (const name of onlyScreens) {
      await page.goto(`${baseUrl.replace(/\/$/, '')}/${screens[name]}`);
      await page.waitForFunction(() => !document.getElementById('splash'), null, {
        timeout: 60000,
      });
      await page.waitForTimeout(2000);
      if (theme === 'dark') {
        // Theme is not persisted yet (see C-01), so toggle on every load.
        await page
          .getByRole('button', { name: 'Switch to dark theme' })
          .first()
          .click({ timeout: 4000 })
          .catch(() => console.log(`[${bp}] no theme toggle on ${name}`));
        await page.waitForTimeout(1000);
        await page.mouse.move(5, height - 5); // hide the tooltip
        await page.waitForTimeout(500);
      }
      const file = `${outDir}/${bp}_${theme}_${name}.jpg`;
      await page.screenshot({ path: file, type: 'jpeg', quality: 70 });
      console.log('saved', file);
    }
    await page.close();
  }
}
await browser.close();
