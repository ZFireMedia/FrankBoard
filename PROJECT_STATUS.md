# FrankBoard — Project Status

**Owner**: Frank Bryant  
**Last Updated**: 2025-03-14

## Current Phase

**Wave 1 Implementation Complete** — UI modernization Wave 1 implemented in repo. Staging not yet rebuilt; live review pending.

## Verified in Staging (VPS 66.179.208.122)

| Item | Status |
|------|--------|
| FrankBoard live at http://66.179.208.122:8080 | Verified |
| Login flow | Functional |
| Admin password change | Done |
| Docker stack healthy | frankboard + frankboard-db running |
| Wave 1 CSS deployed | Pending rebuild |

## Completed Work

| Item | Date | Notes |
|------|------|-------|
| Phase 1 foundation | 2025-03-13 | VPS-first, Docker, docs |
| Migration to new VPS | 2025-03-14 | 66.179.208.122 (clean host) |
| Phase 2 UX audit | 2025-03-14 | Live + codebase; `docs/product/ux-audit-v1.md` |
| UI modernization roadmap | 2025-03-14 | `docs/product/ui-modernization-roadmap-v1.md` |
| First implementation wave | 2025-03-14 | `docs/product/first-implementation-wave-v1.md` |
| **Wave 1 implementation** | **2025-03-14** | **Typography, login polish, focus states, contrast; see `docs/product/wave-1-implementation-notes.md`** |

## Current Repo/Runtime State

- **Codebase**: Wave 1 CSS/template changes in repo; Kanboard v1.2.51 fork
- **Runtime**: FrankBoard live on 66.179.208.122:8080 (pre–Wave 1 image)
- **Documentation**: Architecture, deployment, product UX audit, roadmap, wave-1-implementation-notes

## Blockers

- None

## Next Recommended Step

1. **Rebuild and redeploy** to staging: build image from FrankBoard repo (includes CSS build in Dockerfile), push, deploy
2. **Live review**: verify login, dashboard, board, task detail, task creation in light/dark/auto themes
3. **Approve Wave 1** before proceeding to Wave 2

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
