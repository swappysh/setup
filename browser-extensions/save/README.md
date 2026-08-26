# Save

Manifest V3 Chrome/Arc extension. Click the toolbar icon to POST the current
tab's URL and title to a Cloudflare Worker (`saves-worker.swappysh.workers.dev`).

Originally a bookmarklet-to-extension conversion (http://blog.self.li/post/16366939413/how-to-convert-bookmarklet-to-chrome-extension),
migrated off Manifest V2 after Chrome disabled MV2 extensions.

## Install

1. `chrome://extensions` (or the Arc/Chromium equivalent) → enable Developer mode
2. Load unpacked → select this folder
3. Open the extension's options page and paste in the worker's write secret

The secret is stored in `chrome.storage.local` (per-browser-profile), never in
this repo.
