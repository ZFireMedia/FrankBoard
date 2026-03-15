# FrankBoard — Project Status

**Owner**: Frank Bryant  
**Last Updated**: 2025-03-15

## Current Phase

**Wave 2 implementation complete** — Interior UI foundation (modals, forms, dashboard, header, panels) ready for deploy and verification.

## Verified in Staging (VPS 66.179.208.122)

| Item | Status |
|------|--------|
| FrankBoard live at http://66.179.208.122:8080 | Verified |
| Login flow | Functional |
| Admin password change | Done |
| Docker stack healthy | frankboard + frankboard-db running |
| Wave 1 CSS deployed | ✓ Centered card, FrankBoard branding, typography |
| Wave 2 CSS deployed | Pending deploy |

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

## Current Repo/Runtime State

- **Codebase**: Wave 1 + Wave 2 CSS changes in repo; Kanboard v1.2.51 fork
- **Runtime**: FrankBoard live on 66.179.208.122:8080 (frankboard:wave1 image)
- **Documentation**: Architecture, deployment, product UX audit, roadmap, wave-1/2 implementation notes

## Blockers

- None

## Next Recommended Step

1. **Deploy Wave 2** to staging: `.\scripts\run-vps.ps1 -DeployWave1` (script name unchanged; rebuilds image with Wave 2 CSS)
2. **Live review**: verify dashboard, new project modal, header, light/dark/auto themes
3. **Approve Wave 2** before Wave 3 (board/task focus)

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
