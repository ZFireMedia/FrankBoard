# FrankBoard — Project Status

**Owner**: Frank Bryant  
**Last Updated**: 2026-09-28

## Current Phase

**Soft launch pack v1.1** — CTA and channel refinement. Primary CTA = Migrate; secondary = Setup help; tertiary = Get Community Free. Outreach order: personal first, Kanboard/self-hosted second, Reddit third, HN later. See `docs/launch/soft-launch-strategy-v1.1.md`, `cta-strategy-v1.1.md`, `outreach-targets-v1.1.md`, `announcement-copy-v1.1.md`.

**Public GitHub**: https://github.com/ZFireMedia/FrankBoard (account email `support@zfiremedia.com`)

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
| **QA system v1** | **2025-03-16** | **Strategy, playbook, regression checklist, launch readiness, bug/test templates, automation roadmap; see `docs/qa/`** |
| **QA Test Run 001** | **2025-03-13** | **Full manual pass; test-run-001, bug-log-001, fix-priority-queue-001; 2 bugs (P0: app 403, P1: sitemap 500)** |
| **QA Test Run 002** | **2025-03-16** | **Re-run after BUG-001 fix; app.frankboard.com + SSL pass; BUG-002 (sitemap 500) still open; see test-run-002.md** |
| **QA Test Run 003** | **2025-03-16** | **Closeout verification; BUG-002 fixed (sitemap user-verified); no P0/P1 blockers; launch-ready** |
| **Soft launch pack v1** | **2025-03-16** | **Strategy, CTA, outreach targets, announcement copy, response handling; docs/launch/** |
| **Soft launch pack v1.1** | **2025-03-16** | **CTA: Migrate primary, Setup help secondary, Get Community tertiary; channel order: personal → Kanboard → Reddit → HN** |
| **Docker workflow schedule disabled** | **2025-03-16** | **Removed daily cron from docker.yml; added workflow_dispatch; see docs/deployment/docker-workflow-status-v1.md** |

## Current Repo/Runtime State

- **Codebase**: Wave 1 + Wave 2 + Wave 3 + Wave 4 CSS changes in repo; Kanboard v1.2.51 fork
- **Origin**: `https://github.com/ZFireMedia/FrankBoard.git` (public)
- **CI**: Daily Docker workflow schedule disabled; manual `workflow_dispatch` + tag/PR triggers preserved — see `docs/deployment/docker-workflow-status-v1.md`
- **Runtime**: FrankBoard live on 66.179.208.122:8080 (frankboard:wave1 image); marketing site at frankboard.com (CTA/GitHub updates need site redeploy)
- **Documentation**: Architecture, deployment, product UX audit, roadmap, wave-1/2/3/4 implementation notes, business packaging (docs/business/), launch marketing (docs/marketing/), launch copy (docs/marketing-copy/), site architecture (docs/site/), QA (docs/qa/), soft launch (docs/launch/)

## Blockers

- None for contact path — support CTAs use `support@zfiremedia.com` (Google MX). Optional later: forward `support@frankboard.com` via Cloudflare Email Routing for brand addresses.

## Next Recommended Step

1. Deploy updated marketing site to frankboard.com (GitHub URLs, Migrate CTAs, zfiremedia support email)
2. Execute soft launch per docs/launch/ v1.1 — personal outreach first
3. Sell services (setup/migration) under ZFireMedia as demand appears; Pro/Cloud remain waitlist/contact

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
