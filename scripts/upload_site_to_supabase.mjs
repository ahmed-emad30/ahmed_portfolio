import { createClient } from '@supabase/supabase-js';
import { promises as fs } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(__dirname, '..');
const webRoot = path.join(root, 'build', 'web');

const SUPABASE_URL = 'https://tptaqfbmqifzewewnudg.supabase.co';
const SUPABASE_KEY =
  process.env.SUPABASE_ANON_KEY ||
  'sb_publishable_N2tce2vsArUliYLn9pkxkQ_acu2kZdy';
const BUCKET = 'site';
const PREFIX = 'www';

const mimeTypes = {
  '.html': 'text/html; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.webp': 'image/webp',
  '.ico': 'image/x-icon',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2',
  '.ttf': 'font/ttf',
  '.otf': 'font/otf',
  '.wasm': 'application/wasm',
  '.map': 'application/json',
  '.txt': 'text/plain; charset=utf-8',
  '.bin': 'application/octet-stream',
};

function contentTypeFor(filePath) {
  const ext = path.extname(filePath).toLowerCase();
  return mimeTypes[ext] || 'application/octet-stream';
}

async function walk(dir) {
  const entries = await fs.readdir(dir, { withFileTypes: true });
  const files = [];
  for (const entry of entries) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      files.push(...(await walk(full)));
    } else if (entry.name !== '.htaccess') {
      files.push(full);
    }
  }
  return files;
}

async function main() {
  const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);
  const files = await walk(webRoot);
  console.log(`Uploading ${files.length} files to ${BUCKET}/${PREFIX}/ ...`);

  let ok = 0;
  let failed = 0;

  for (const file of files) {
    const relative = path.relative(webRoot, file).split(path.sep).join('/');
    const objectPath = `${PREFIX}/${relative}`;
    const body = await fs.readFile(file);
    const { error } = await supabase.storage.from(BUCKET).upload(objectPath, body, {
      upsert: true,
      contentType: contentTypeFor(file),
      cacheControl: relative.endsWith('.html') ? '0' : '3600',
    });

    if (error) {
      failed += 1;
      console.error(`FAIL ${objectPath}: ${error.message}`);
    } else {
      ok += 1;
      if (ok % 25 === 0 || relative === 'index.html') {
        console.log(`OK (${ok}/${files.length}) ${objectPath}`);
      }
    }
  }

  // Root Storage index.html: plain-text instructions (Storage cannot render HTML apps).
  const notice = [
    'Ahmed Emad Portfolio',
    '',
    'Supabase Storage cannot render HTML websites (files open as plain text).',
    '',
    'Open the live site here:',
    `${SUPABASE_URL}/functions/v1/portfolio`,
    '',
  ].join('\n');

  const { error: noticeError } = await supabase.storage.from(BUCKET).upload(
    'index.html',
    new TextEncoder().encode(notice),
    {
      upsert: true,
      contentType: 'text/plain; charset=utf-8',
      cacheControl: '0',
    },
  );

  if (noticeError) {
    console.error(`FAIL index.html notice: ${noticeError.message}`);
  } else {
    console.log('OK root index.html notice written');
  }

  console.log(`\nDone. uploaded=${ok} failed=${failed}`);
  console.log(`Live URL:\n${SUPABASE_URL}/functions/v1/portfolio`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
