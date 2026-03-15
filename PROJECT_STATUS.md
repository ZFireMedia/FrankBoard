# FrankBoard — Project Status

**Owner**: Frank Bryant  
**Last Updated**: 2025-03-15

## Current Phase

**Static site deployed to frankboard.com** — Marketing site live at frankboard.com. Six pages, plain HTML/CSS. Separate from app at app.frankboard.com. See `docs/site/site-deploy-execution-v1.md`, `docs/site/site-post-deploy-checklist-v1.md`.

## Verified in Staging (VPS 66.179.208.122)

| Item | Status |
|------|--------|
| FrankBoard live at http://66.179.208.122:8080 | Verified |
| Login flow | Functional |
| Admin password change | Done |
| Docker stack healthy | frankboard + frankboard-db running |
| Wave 1 CSS deployed | ✓ Centered card, FrankBoard branding, typography |
| Wave 2 CSS deployed | ✓ Deployed |
| Wave 3 CSS deployed | ✓ Verified (board, task card, detail, form) |
| Wave 4 CSS deployed | ✓ Deployed |

## Completed Work

| Item | Date | Notes |
|------|------|-------|
| Phase 1 foundation | 2025-03-13 | VPS-first, Docker, docs |
| Migration to new VPS | 2025-03-14 | 66.179.208.122 (clean host) |
| Phase 2 UX audit | 2025-03-14 | Live + codebase; `docs/product/ux-audit-v1.md` |
| UI modernization roadmap | 2025-03-14 | `docs/product/ui-modernization-roadmap-v1.md` |
| First implementation wave | 2025-03-14 | `docs/product/first-implementation-wave-v1.md` |
| **Wave 1 implementation** | **2025-03-14** | **Typography, login polish, focus states, contrast; see `docs/product/wave-1-implementation-notes.md`** |
| **Wave 2 implementation** | **2025-03-15** | **Modal, form, dashboard, header, panel polish; see `docs/product/wave-2-implementation-notes.md`** |
| **Wave 3 implementation** | **2025-03-15** | **Board, task cards, task detail, task forms; see `docs/product/wave-3-implementation-notes.md`** |
| **Commercial packaging v1** | **2025-03-15** | **Product positioning, editions, migration story, revenue model; see `docs/business/`** |
| **Wave 4 implementation** | **2025-03-15** | **Empty states, search polish, responsive, admin consistency, theme fixes; see `docs/product/wave-4-implementation-notes.md`** |
| **Launch foundation messaging v1** | **2025-03-15** | **Homepage, edition comparison, migration, why-frankboard, pricing, support page architecture; see `docs/marketing/`** |
| **Launch copy drafts v1** | **2025-03-15** | **Real website copy for all launch pages; see `docs/marketing-copy/`** |
| **Static launch site architecture v1** | **2025-03-15** | **Site architecture, file structure, design system, deployment; see `docs/site/`** |
| **Static launch site v1 implementation** | **2025-03-15** | **Home, Editions, Migrate, Why, Pricing, Support; `site/`; see `docs/site/site-build-notes-v1.md`** |
| **Homepage card alignment refinement** | **2025-03-15** | **Desktop: benefits/trust/editions-teaser constrained to 720px, section titles centered; see `docs/site/homepage-alignment-pass-notes.md`** |
| **Static site deployed to frankboard.com** | **2025-03-15** | **Nginx at /var/www/frankboard-site; www→apex redirect; app.frankboard.com config ready; see `docs/site/site-deploy-execution-v1.md`** |

## Current Repo/Runtime State

- **Codebase**: Wave 1 + Wave 2 + Wave 3 + Wave 4 CSS changes in repo; Kanboard v1.2.51 fork
- **Runtime**: FrankBoard live on 66.179.208.122:8080 (frankboard:wave1 image)
- **Documentation**: Architecture, deployment, product UX audit, roadmap, wave-1/2/3/4 implementation notes, business packaging (docs/business/), launch marketing (docs/marketing/), launch copy (docs/marketing-copy/), site architecture (docs/site/)

## Blockers

- None

## Next Recommended Step

1. Verify frankboard.com in browser (DNS via Cloudflare); run Certbot if origin SSL needed for Full/Strict
2. Enable app.frankboard.com when ready: `ln -s /etc/nginx/sites-available/app.frankboard.com.conf /etc/nginx/sites-enabled/` then `nginx -t && systemctl reload nginx`
3. Complete post-deploy checklist per `docs/site/site-post-deploy-checklist-v1.md`

## Future Phases (Preview)

- First wave: Low-risk UI polish (typography, login, focus states)
- Phase 2 continued: Task card, board column, header refinements
- Phase 3: API improvements, AI-task-assistance readiness

## Compatibility

| Aspect | Status |
|--------|--------|
| Upstream Kanboard | Compatible; FrankBoard = Kanboard + VPS Docker + PostgreSQL defaults |
| Plugins | Same plugin API; stored in `app_plugins` volume |
| Data migration | SQLite/MySQL → PostgreSQL supported via Kanboard migration docs |
| Config | `config.php` / `data/config.php` + env vars |

## Tech Stack

- Kanboard v1.2.51
- PostgreSQL 16 (Alpine)
- Docker Compose
- Nginx, PHP 8.4
