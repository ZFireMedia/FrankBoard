# FrankBoard.com — Site Build Notes v1

**Date**: 2025-03-15  
**Status**: Build complete  
**Scope**: Static launch site v1 implementation.

---

## Files Created

| File | Purpose |
|------|---------|
| `site/index.html` | Homepage |
| `site/editions/index.html` | Editions comparison |
| `site/migrate/index.html` | Migration from Kanboard |
| `site/why/index.html` | Why FrankBoard exists |
| `site/pricing/index.html` | Pricing (Community/Pro/Cloud) |
| `site/support/index.html` | Support tiers and services |
| `site/assets/css/main.css` | Shared design system |
| `site/assets/img/favicon.svg` | Favicon (F mark) |
| `site/robots.txt` | Crawler instructions |
| `site/sitemap.xml` | Sitemap for SEO |

---

## Design Decisions

- **Background**: `#fafaf9` — warm neutral, not cold white
- **Primary**: `#2563eb` — restrained blue, not purple gradient
- **Typography**: System font stack — no custom fonts
- **Layout**: `--max-width: 720px` (narrow), `--max-width-wide: 960px` (tables/grids)
- **Tone**: Linear-level restraint, simpler and warmer — no generic SaaS gradients

---

## Copy Sources

All copy derived from `docs/marketing-copy/*.md`. Minor adjustments for HTML flow; no substantive changes to approved messaging.

---

## Placeholders / Deferred

| Item | Notes |
|------|-------|
| `og-default.png` | Social share image — use 1200×630 placeholder until real asset |
| `apple-touch-icon.png` | iOS home screen — optional for v1 |
| `main.min.css` | Unminified main.css used; minification optional at deploy |
| Pro/Cloud CTAs | `mailto:support@frankboard.com` — update when support channel is final |
| GitHub URL | `https://github.com/ZFireMedia/FrankBoard` — confirm org/repo at launch |

---

## Technical Notes

- Pure HTML + CSS; no JavaScript, no framework
- Subpages use `../assets/` for CSS/img paths
- Footer nav and header nav duplicated per page (no SSG)
- `aria-current="page"` used on support page; `class="active"` used elsewhere for current nav — consider consolidating
- Comparison tables use `comparison-table` class; responsive via `table-wrapper` overflow-x

---

## Verification Checklist

- [x] All 6 pages render
- [x] Nav/footer consistent across pages
- [x] Internal links use relative paths
- [x] CTA targets: GitHub (Community), mailto (Pro/Cloud)
- [x] robots.txt, sitemap.xml at site root
- [ ] Responsive check at 320px, 640px, 960px
- [ ] Live deploy verification
