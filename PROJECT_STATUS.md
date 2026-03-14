# FrankBoard — Project Status

**Owner**: Frank Bryant  
**Last Updated**: 2025-03-13

## Current Phase

**Phase 1: Foundation** — VPS-first Docker environment, inspect, fork, dockerize, document, prepare for safe modernization.

## Completed Work

| Item | Date | Notes |
|------|------|-------|
| Clone Kanboard | 2025-03-13 | Source: kanboard/kanboard main |
| Docker Compose (PostgreSQL) | 2025-03-13 | `docker-compose.yml` with .env support |
| Documentation structure | 2025-03-13 | `/docs`, ADRs, architecture docs |
| VPS-first revision | 2025-03-13 | Primary runtime = Docker on VPS |
| Codebase audit | 2025-03-13 | `docs/architecture/codebase-audit.md` |
| System overview | 2025-03-13 | `docs/architecture/system-overview.md` |
| VPS deployment guide | 2025-03-13 | `docs/deployment/vps-docker-staging.md` |
| ADR-001 foundation architecture | 2025-03-13 | VPS-first, PostgreSQL, Docker |
| README.md | 2025-03-13 | VPS-first workflow, doc links |
| .env.example | 2025-03-13 | Documented env vars |
| .gitignore | 2025-03-13 | Added `.env` |

## Current Repo/Runtime State

- **Codebase**: Kanboard v1.2.51 fork; no application code changes
- **Docker Compose**: Ready for VPS deployment; PostgreSQL 16, Kanboard official image
- **Documentation**: Architecture, audit, deployment, ADRs in place
- **Runtime**: Intended for VPS with Docker; local Docker optional

## Blockers

- **None for Phase 1**. VPS with Docker access is assumed. If VPS is not yet provisioned, operator can run `docker compose up -d` once the repo is on a machine with Docker.

## Next Recommended Step

1. Deploy to VPS: clone repo on VPS, create `.env`, run `docker compose up -d`
2. Verify: `curl http://<vps-ip>:8080/healthcheck.php` → `{"status":200,"message":"Database connection is OK"}`
3. Log in at `http://<vps-ip>:8080`, change admin password
4. Proceed to Phase 2 (UI/UX polish, performance) when foundation is verified

## Future Phases (Preview)

- Phase 2: UI/UX polish, performance tuning
- Phase 3: API improvements, AI-task-assistance readiness
- Phase 4: (TBD) Feature additions aligned with core principles

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
