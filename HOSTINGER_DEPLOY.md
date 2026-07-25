# Publish Ahmed Emad Portfolio on Hostinger

This guide deploys the Flutter **web** build to Hostinger shared hosting.  
Supabase remains the backend (content + Contact Us). Hostinger only serves static files.

## Prerequisites

- Flutter SDK installed (`flutter --version`)
- Hostinger hosting plan with File Manager or FTP access
- Domain (or subdomain) pointed at Hostinger
- Supabase project credentials:
  - URL: `https://tptaqfbmqifzewewnudg.supabase.co`
  - Anon key: from Supabase Dashboard → **Project Settings → API**

## 1. Build for web

From the project root:

```bash
flutter pub get

flutter build web --release \
  --dart-define=SUPABASE_URL=https://tptaqfbmqifzewewnudg.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=YOUR_ANON_KEY_HERE
```

Output folder: `build/web/`

The build includes `web/.htaccess` copied into `build/web/.htaccess` when present under `web/`.  
If `.htaccess` is missing after build, copy [`web/.htaccess`](web/.htaccess) into `build/web/` manually.

## 2. What to upload

Upload the **contents** of `build/web/` (not the `web` folder itself) into:

| Target | Path |
|--------|------|
| Main domain | `public_html/` |
| Subdomain | `public_html/your-subdomain/` (or the folder Hostinger shows for that subdomain) |

Required files at the site root:

- `index.html`
- `main.dart.js`
- `flutter_bootstrap.js` / `flutter.js` (depending on Flutter version)
- `assets/`
- `icons/`
- `.htaccess` (SPA rewrite — important)

## 3. Upload via Hostinger File Manager

1. Log in to **hPanel** → **Files** → **File Manager**
2. Open `public_html` (or your subdomain folder)
3. Optional: delete old site files (keep default Hostinger files only if you still need them)
4. Zip locally:

   ```bash
   cd build/web
   zip -r ../../portfolio-web.zip .
   ```

5. Upload `portfolio-web.zip` into `public_html`
6. Right-click → **Extract**
7. Confirm `index.html` sits directly in `public_html`
8. Delete the zip after extract

## 4. Upload via FTP / SFTP

1. hPanel → **Files** → **FTP Accounts** (note host, user, password)
2. Connect with FileZilla / Cyberduck (prefer SFTP if available)
3. Upload everything inside `build/web/` into `public_html`
4. Ensure `.htaccess` is uploaded (enable “show hidden files” in the FTP client)

## 5. SPA routing (`.htaccess`)

Flutter uses path URLs (`/aboutScreen`, `/contactScreen`, …).  
Apache must rewrite unknown paths to `index.html`.

Use the project file [`web/.htaccess`](web/.htaccess). Without it, refreshing a deep link returns 404.

## 6. Supabase checklist after go-live

1. In Supabase Dashboard → **Authentication → URL Configuration**, set **Site URL** to your live domain (e.g. `https://yourdomain.com`) if prompted
2. Confirm tables have public **SELECT** (content) and Contact Us has **INSERT** for `anon`
3. Edit live content anytime:
   - `profile` — name, title, about, AE Studio URL, resume URL
   - `social_links` — GitHub, LinkedIn, email, WhatsApp, CV, X
   - `services`, `skill_categories`, `skills`, `experiences`, `projects`
4. Upload resume PDF to Storage bucket `portfolio-public`, then set `profile.resume_url` (and/or `social_links` key `cv`) to the public URL
5. View Contact Us submissions in Table Editor → `contact_messages`

## 7. Verify checklist

- [ ] Home page loads over HTTPS
- [ ] Nav sections open without full reload errors
- [ ] Refreshing `/aboutScreen` (or any section) still works
- [ ] Social icons open correct URLs
- [ ] AE Studio footer link opens
- [ ] CV / resume opens when URL is set
- [ ] Contact form inserts a row in `contact_messages`
- [ ] Projects / skills / about text match Supabase (not only local fallback)

## 8. Update workflow

1. Change code locally
2. Rebuild with the same `flutter build web --release ...` command
3. Re-upload changed files (or full `build/web` contents)
4. Hard-refresh the browser (or clear Hostinger/CDN cache if enabled)

Content-only updates (copy, links, resume) do **not** need a Hostinger redeploy — edit Supabase instead.

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Blank page | Open DevTools → Network; ensure `main.dart.js` 200; check `base href="/"` in `index.html` |
| 404 on refresh | Confirm `.htaccess` is in `public_html` and Apache `mod_rewrite` is enabled (default on Hostinger) |
| Old UI after deploy | Hard refresh / clear cache; ensure you overwrote `main.dart.js` |
| Contact form fails | Check Supabase RLS insert policy on `contact_messages`; check browser console for CORS/API errors |
| Site shows fallback content | Supabase URL/key wrong in build defines, or network blocked |
