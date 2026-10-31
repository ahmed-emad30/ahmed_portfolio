/**
 * Minimal static server for a Flutter web build with SPA fallback, so deep
 * links like /servicesScreen load index.html.
 *
 * Usage: node scripts/design/serve_spa.mjs build/web 8765
 */
import http from 'node:http';
import fs from 'node:fs';
import path from 'node:path';

const root = path.resolve(process.argv[2] ?? 'build/web');
const port = Number(process.argv[3] ?? 8765);
const types = {
  '.html': 'text/html',
  '.js': 'application/javascript',
  '.mjs': 'application/javascript',
  '.json': 'application/json',
  '.wasm': 'application/wasm',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.svg': 'image/svg+xml',
  '.ttf': 'font/ttf',
  '.otf': 'font/otf',
};

http
  .createServer((req, res) => {
    let file = path.join(root, decodeURIComponent(req.url.split('?')[0]));
    if (!file.startsWith(root)) file = path.join(root, 'index.html');
    if (!fs.existsSync(file) || fs.statSync(file).isDirectory()) {
      file = path.join(root, 'index.html');
    }
    res.writeHead(200, {
      'content-type': types[path.extname(file)] ?? 'application/octet-stream',
    });
    fs.createReadStream(file).pipe(res);
  })
  .listen(port, () => console.log(`Serving ${root} on http://localhost:${port}`));
