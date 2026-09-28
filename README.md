# FrankBoard

A modernization fork of [Kanboard](https://github.com/kanboard/kanboard) for cleaner, faster, more user-friendly self-hosted work boards for small teams.

**Site**: [frankboard.com](https://frankboard.com) · **Migrate**: [frankboard.com/migrate](https://frankboard.com/migrate/) · **Setup help**: support@zfiremedia.com

**Owner**: Frank Bryant / ZFire Media

## What is FrankBoard?

FrankBoard is based on Kanboard. It preserves Kanboard's core strengths—simplicity, stability, self-hosting, low operational overhead—while preparing for incremental modernization. FrankBoard does not aim to become a Jira clone.

**Community** is free (this repo). Paid migration assistance and VPS/Docker setup are available via email (invoice first). See [docs/launch/service-quote-sheet-v1.md](docs/launch/service-quote-sheet-v1.md).

## VPS-First Docker Workflow

FrankBoard uses a **VPS-first** deployment model: the primary development and staging runtime is Docker on a VPS, not local Docker on the operator machine.

### Basics

1. Clone this repo on a VPS with Docker and Docker Compose installed
2. Copy `.env.example` to `.env` and set `POSTGRES_PASSWORD` (and other overrides as needed)
3. Run `docker compose up -d`
4. Access the app at `http://<vps-ip>:<APP_PORT>` (default port 8080)
5. Default login: **admin** / **admin** — change immediately

See [docs/deployment/vps-docker-staging.md](docs/deployment/vps-docker-staging.md) for the full deployment guide.

## Deployment / Staging Expectations

- **Required**: VPS with Docker and Docker Compose v2+
- **Database**: PostgreSQL is the primary target (configured via `DATABASE_URL`)
- **Volumes**: `app_data`, `app_plugins`, and `db_data` persist across restarts
- **Optional**: Reverse proxy (nginx, Caddy, Traefik) in front for SSL and custom domains

## Documentation Locations

| Resource | Location |
|----------|----------|
| Project status & phases | [PROJECT_STATUS.md](PROJECT_STATUS.md) |
| Action history | [ACTION_LOG.md](ACTION_LOG.md) |
| System architecture | [docs/architecture/system-overview.md](docs/architecture/system-overview.md) |
| Codebase audit | [docs/architecture/codebase-audit.md](docs/architecture/codebase-audit.md) |
| VPS deployment guide | [docs/deployment/vps-docker-staging.md](docs/deployment/vps-docker-staging.md) |
| Architecture decisions (ADRs) | [docs/decisions/](docs/decisions/) |

## Principles

- Preserve Kanboard's strengths: simplicity, stability, self-hosting, low overhead
- Do not become a Jira clone
- Incremental modernization, not a full rewrite
- Prefer PostgreSQL; use Docker for VPS deployment

## Upstream

FrankBoard is based on Kanboard v1.2.51. See `ChangeLog` and [Kanboard docs](https://docs.kanboard.org/) for app behavior and configuration.
