#!/usr/bin/env bash
# Rewrites a data-only dump of the old project's `public` schema so it loads
# into the `portfolio` schema of the active project.
#
# 1. On your machine, with the OLD project restored (password stays with you):
#      supabase db dump --db-url "$OLD_DB_URL" --schema public --data-only -f old_data.sql
# 2. ./scripts/rewrite_dump_to_portfolio.sh old_data.sql > portfolio_data.sql
# 3. In the ACTIVE project, after supabase/migrations/20261003_portfolio_schema.sql:
#      SQL Editor → paste portfolio_data.sql → Run
#    (or: psql "$NEW_DB_URL" -v ON_ERROR_STOP=1 -f portfolio_data.sql)
#
# Only the 8 portfolio tables are rewritten; anything else in the dump is left
# pointing at `public` so it fails loudly instead of landing in the wrong place.
set -euo pipefail

if [[ $# -ne 1 || ! -f "$1" ]]; then
  echo "usage: $0 old_data.sql > portfolio_data.sql" >&2
  exit 1
fi

tables='profile|social_links|services|skill_categories|skills|experiences|projects|contact_messages'

echo 'begin;'
echo
echo '-- Clear content so the dump is the single source of truth.'
echo 'truncate portfolio.skills, portfolio.skill_categories, portfolio.profile,'
echo '  portfolio.social_links, portfolio.services, portfolio.experiences,'
echo '  portfolio.projects, portfolio.contact_messages;'
echo

sed -E \
  -e "s/(\"?)public(\"?)\.(\"?)($tables)(\"?)([^a-z_]|$)/portfolio.\4\6/g" \
  -e '/^SET (statement_timeout|lock_timeout|idle_in_transaction_session_timeout|transaction_timeout) /d' \
  "$1"

echo
echo 'commit;'
