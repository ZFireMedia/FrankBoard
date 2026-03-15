# FrankBoard.com — Site File Structure v1

**Date**: 2025-03-15  
**Status**: Structure document  
**Scope**: Folder and file organization for static launch site.

---

## Recommended Folder Structure

```
frankboard-site/          # or site/, marketing-site/, www/
├── index.html            # Homepage
├── editions/
│   └── index.html
├── migrate/
│   └── index.html
├── why/
│   └── index.html
├── pricing/
│   └── index.html
├── support/
│   └── index.html
├── assets/
│   ├── css/
│   │   ├── main.css
│   │   └── main.min.css   # built/optimized
│   ├── js/
│   │   └── main.js        # minimal; nav, CTA tracking if any
│   ├── img/
│   │   ├── logo.svg
│   │   ├── logo-dark.svg  # if dark mode
│   │   └── og-default.png # social share
│   └── fonts/            # if custom fonts
├── _includes/            # if using simple SSG (11ty, etc.)
│   ├── header.html
│   ├── footer.html
│   ├── hero.html
│   └── cta.html
├── _layouts/             # if using SSG
│   └── default.html
├── robots.txt
├── sitemap.xml
├── favicon.ico
├── apple-touch-icon.png
└── CNAME                 # if using GitHub Pages; frankboard.com
```

**If pure static HTML (no SSG)**:
- Each page is a full HTML file.
- Shared header/footer: copy-paste or simple build script (e.g. `sed`, `cat`) that injects snippets.

**If using a lightweight SSG** (recommended for maintainability):
- **11ty** — good fit: simple, HTML-first, no React/Vue
- **Hugo** — fast, good if comfortable with Go templates
- **Nunjucks + small build** — minimal setup

---

## Page Naming Conventions

| Page | File | URL |
|------|------|-----|
| Homepage | `index.html` (root) | `/` |
| Editions | `editions/index.html` | `/editions/` |
| Migration | `migrate/index.html` | `/migrate/` |
| Why | `why/index.html` | `/why/` |
| Pricing | `pricing/index.html` | `/pricing/` |
| Support | `support/index.html` | `/support/` |

Trailing slashes for directory-based routes. Use `index.html` for clean URLs.

---

## Asset Organization

| Type | Location | Notes |
|------|----------|-------|
| CSS | `assets/css/` | `main.css` (source), `main.min.css` (built) |
| JS | `assets/js/` | `main.js` — nav, analytics, minimal interactivity |
| Images | `assets/img/` | Logo, OG image, optional illustrations |
| Icons | `assets/img/` or `assets/icons/` | SVG preferred |
| Fonts | `assets/fonts/` | Only if custom; system fonts reduce weight |
| Metadata | Root or `_data/` | `meta.json`, `site.json` for SSG |

**Naming**: lowercase, hyphens (`logo-dark.svg`, `og-default.png`).

---

## Metadata / SEO File Locations

| File | Location | Purpose |
|------|----------|---------|
| `robots.txt` | Root | Allow crawlers; optional disallow for /admin if ever added |
| `sitemap.xml` | Root | List all pages; update on deploy |
| `favicon.ico` | Root | Browser tab icon |
| `apple-touch-icon.png` | Root | iOS home screen |
| Per-page meta | In `<head>` of each page | title, description, og:title, og:image |

**sitemap.xml** example entries:
```
/
/editions/
/migrate/
/why/
/pricing/
/support/
```

---

## Robots / Sitemap Recommendations

**robots.txt**:
```
User-agent: *
Allow: /

Sitemap: https://frankboard.com/sitemap.xml
```

**sitemap.xml**:
- Include all public pages
- Set `lastmod` to build/deploy date
- `changefreq`: monthly for static marketing pages
- `priority`: 1.0 for /, 0.8 for main pages

Generate sitemap at build time or maintain manually for 6 pages.

---

## Build Output (if using SSG)

```
dist/                     # or _site/, build/, output/
├── index.html
├── editions/
│   └── index.html
├── migrate/
│   └── index.html
├── why/
│   └── index.html
├── pricing/
│   └── index.html
├── support/
│   └── index.html
├── assets/
│   ├── css/
│   ├── js/
│   └── img/
├── robots.txt
├── sitemap.xml
└── favicon.ico
```

Deploy the `dist/` (or equivalent) folder to the web server.

---

## Repository Recommendation

**Option A**: `frankboard-site/` as a subfolder in the main FrankBoard repo (monorepo).
**Option B**: Separate repo `FrankBoard/frankboard-site` or `FrankBoard/www`.

Recommendation: **Separate repo** for clear separation between product app and marketing site. Simpler CI/CD, independent deploys. Link to main repo in README.

---

## Summary

- Flat HTML or lightweight SSG (11ty preferred)
- Six pages in logical paths; `index.html` per section
- Assets in `assets/{css,js,img,fonts}`
- `robots.txt`, `sitemap.xml` at root
- Build output in `dist/`; deploy that folder
