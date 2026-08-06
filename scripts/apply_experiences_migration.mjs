/**
 * Applies supabase/migrations/20260807_experiences_company_tech_tags.sql
 * using the Supabase Management API (requires a personal access token).
 *
 * Usage:
 *   SUPABASE_ACCESS_TOKEN=sbp_... node scripts/apply_experiences_migration.mjs
 *
 * Or run the SQL file manually in Dashboard → SQL Editor.
 */
import { promises as fs } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const projectRef = process.env.SUPABASE_PROJECT_REF || 'tptaqfbmqifzewewnudg';
const token = process.env.SUPABASE_ACCESS_TOKEN;
const sqlPath = path.resolve(
  __dirname,
  '../supabase/migrations/20260807_experiences_company_tech_tags.sql',
);

if (!token) {
  console.error(
    'Missing SUPABASE_ACCESS_TOKEN.\n' +
      'Run the SQL manually: supabase/migrations/20260807_experiences_company_tech_tags.sql\n' +
      'Dashboard → SQL Editor → New query → Run',
  );
  process.exit(1);
}

const query = await fs.readFile(sqlPath, 'utf8');
const response = await fetch(
  `https://api.supabase.com/v1/projects/${projectRef}/database/query`,
  {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${token}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ query }),
  },
);

const body = await response.text();
if (!response.ok) {
  console.error('Migration failed:', response.status, body);
  process.exit(1);
}

console.log('Migration applied successfully.');
console.log(body);
