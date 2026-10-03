#!/usr/bin/env bash
# Deploy Flutter web build to GitHub Pages (gh-pages branch).
#
# Usage (from repo root):
#   ./scripts/deploy_github_pages.sh
#
# Required env (active Supabase project, Settings → API):
#   SUPABASE_URL=https://<ref>.supabase.co
#   SUPABASE_ANON_KEY=sb_publishable_...
#
# Optional env overrides:
#   REPO_NAME=ahmed_portfolio
#   GH_PAGES_BRANCH=gh-pages
#   SUPABASE_SCHEMA=portfolio
#   USE_PATH_URL=true
#   SKIP_BUILD=1          # deploy existing build/web only
#   DRY_RUN=1             # build only, do not push

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

REPO_NAME="${REPO_NAME:-ahmed_portfolio}"
GH_PAGES_BRANCH="${GH_PAGES_BRANCH:-gh-pages}"
BASE_HREF="/${REPO_NAME}/"
SUPABASE_URL="${SUPABASE_URL:-}"
SUPABASE_ANON_KEY="${SUPABASE_ANON_KEY:-}"
SUPABASE_SCHEMA="${SUPABASE_SCHEMA:-portfolio}"
USE_PATH_URL="${USE_PATH_URL:-true}"
SKIP_BUILD="${SKIP_BUILD:-0}"
DRY_RUN="${DRY_RUN:-0}"

BUILD_DIR="$ROOT_DIR/build/web"
PUBLISH_DIR="$ROOT_DIR/.gh-pages-publish"

echo "==> Deploy target"
echo "    site:   https://ahmed-emad30.github.io/${REPO_NAME}/"
echo "    branch: ${GH_PAGES_BRANCH}"
echo "    base:   ${BASE_HREF}"

if ! command -v flutter >/dev/null 2>&1; then
  echo "error: flutter not found on PATH" >&2
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "error: git not found on PATH" >&2
  exit 1
fi

if [[ "$SKIP_BUILD" != "1" && ( -z "$SUPABASE_URL" || -z "$SUPABASE_ANON_KEY" ) ]]; then
  echo "error: set SUPABASE_URL and SUPABASE_ANON_KEY (without them the site only shows bundled content)" >&2
  exit 1
fi

REMOTE_URL="$(git remote get-url origin)"

if [[ "$SKIP_BUILD" != "1" ]]; then
  echo "==> flutter pub get"
  flutter pub get

  echo "==> flutter build web --release"
  flutter build web --release \
    --base-href="$BASE_HREF" \
    --dart-define=USE_PATH_URL="$USE_PATH_URL" \
    --dart-define=SUPABASE_URL="$SUPABASE_URL" \
    --dart-define=SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY" \
    --dart-define=SUPABASE_SCHEMA="$SUPABASE_SCHEMA"
else
  echo "==> Skipping build (SKIP_BUILD=1)"
fi

if [[ ! -f "$BUILD_DIR/index.html" ]]; then
  echo "error: missing $BUILD_DIR/index.html — build failed or SKIP_BUILD without artifacts" >&2
  exit 1
fi

# GitHub Pages has no Apache rewrite. 404.html = index.html lets deep links
# (e.g. /ahmed_portfolio/aboutScreen) boot the Flutter SPA.
cp "$BUILD_DIR/index.html" "$BUILD_DIR/404.html"
touch "$BUILD_DIR/.nojekyll"

echo "==> Staging publish folder"
rm -rf "$PUBLISH_DIR"
mkdir -p "$PUBLISH_DIR"
cp -R "$BUILD_DIR"/. "$PUBLISH_DIR"/

if [[ "$DRY_RUN" == "1" ]]; then
  echo "==> DRY_RUN=1 — build ready at $BUILD_DIR (and staged at $PUBLISH_DIR), not pushing."
  exit 0
fi

echo "==> Publishing to origin/${GH_PAGES_BRANCH}"
cd "$PUBLISH_DIR"
git init -b "$GH_PAGES_BRANCH"
git remote add origin "$REMOTE_URL"
git add -A

GIT_NAME="$(git -C "$ROOT_DIR" config user.name || echo 'github-pages-deploy')"
GIT_EMAIL="$(git -C "$ROOT_DIR" config user.email || echo 'deploy@localhost')"
COMMIT_MSG="Deploy web $(date -u +'%Y-%m-%d %H:%M:%S UTC')"

git -c user.name="$GIT_NAME" -c user.email="$GIT_EMAIL" commit -m "$COMMIT_MSG"
git push -u origin "HEAD:${GH_PAGES_BRANCH}" --force

cd "$ROOT_DIR"
rm -rf "$PUBLISH_DIR"

echo ""
echo "Done. Site should update shortly at:"
echo "  https://ahmed-emad30.github.io/${REPO_NAME}/"
echo ""
echo "If Pages is not enabled: GitHub → Settings → Pages"
echo "  Source: Deploy from a branch → ${GH_PAGES_BRANCH} / (root)"
