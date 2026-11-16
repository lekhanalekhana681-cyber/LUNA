# Luna Landing Page

This folder contains a **stand‑alone static landing page** for the Luna period‑tracking app. It is completely independent of the Flutter source code – no build step, no external assets, and no frameworks.

## Files
- `index.html` – the single HTML file that includes all CSS, inline SVG graphics, and a tiny vanilla‑JS script for the dot‑ring animation.
- `vercel.json` – tells Vercel to serve `index.html` for every route (SPA style).

## How to view it locally
```bash
# From the project root
cd landing
# Open with any web server (Python, npm, etc.)
# Example using Python 3:
python -m http.server 8000
# Then open http://localhost:8000 in your browser.
```
You can also just double‑click `index.html` and open it directly, but using a local server ensures the correct handling of relative links.

## Deploy to Vercel (no build step)
1. Log in to Vercel and create a **New Project**.
2. Choose **Import Git Repository** (or connect the GitHub repo where this folder lives).
3. When asked for the **Framework Preset**, select **"Other"**.
4. Set the **Root Directory** to `landing/`.
5. **Build Command:** leave blank (the site is static). Vercel will automatically serve the files.
6. Click **Deploy** – Vercel will use `vercel.json` to rewrite all routes to `index.html`.

The landing page will be available at `https://<your‑project>.vercel.app/`.

---
*All colors, fonts, and the SVG logo follow the brand guidelines. The page is fully responsive, accessible, and respects the user's prefers‑reduced‑motion setting.*
