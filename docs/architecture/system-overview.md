# FrankBoard System Overview

FrankBoard is a modernization fork of Kanboard. The primary runtime for Phase 1 is a **Dockerized VPS environment**, not local Docker on the operator machine.

**Owner**: Frank Bryant  
**Last Updated**: 2025-03-13

---

## 1. Primary Runtime: VPS-First Docker

| Aspect | Description |
|--------|-------------|
| **Primary environment** | Docker on a VPS (staging / dev) |
| **Local Docker** | Optional; not required for Phase 1 |
| **Deployment** | Clone repo to VPS → `.env` → `docker compose up -d` |

The operator machine can be used for editing, git, and documentation. The VPS runs the application and database.

---

## 2. What FrankBoard Is

- A fork of [Kanboard](https://github.com/kanboard/kanboard) v1.2.51
- Self-hosted work board for small teams (Kanban methodology)
- Goals: cleaner, faster, more user-friendly; preserve simplicity and low overhead
- **Not** a Jira clone; incremental modernization over full rewrite

---

## 3. Component Stack

| Layer | Technology |
|-------|-------------|
| Web Server | Nginx (inside app container) |
| Runtime | PHP 8.4 (FPM) |
| Database | PostgreSQL 16 (preferred) |
| ORM | PicoDb |
| Frontend | jQuery, CSS, minimal JS |

---

## 4. Docker Services

| Service | Image | Role |
|---------|-------|------|
| `app` | kanboard/kanboard:v1.2.51 | Web app (Nginx + PHP-FPM) |
| `db` | postgres:16-alpine | PostgreSQL |

---

## 5. Persistent Volumes

| Volume | Purpose |
|--------|---------|
| `app_data` | Attachments, cache, optional `data/config.php` |
| `app_plugins` | Installed plugins |
| `db_data` | PostgreSQL database files |
| `certs` | SSL certificates (optional) |

---

## 6. Configuration Path

1. **DATABASE_URL** (env) — Primary for Docker; parsed by PicoDb UrlParser
2. **data/config.php** — Instance overrides (inside `app_data` volume)
3. **config.php** — Root config (baked into image)
4. **constants.php** — Env fallbacks

---

## 7. Reverse Proxy Expectations

When FrankBoard runs behind a reverse proxy (nginx, Caddy, Traefik):

- Proxy terminates SSL and forwards to app (e.g. `http://127.0.0.1:8080`)
- Set `TRUSTED_PROXY_NETWORKS` (CIDR) and `TRUSTED_PROXY_HEADERS` if using proxy-based auth
- Bind app to `127.0.0.1:8080` when only proxy should reach it

---

## 8. Related Docs

| Doc | Purpose |
|-----|---------|
| [Codebase Audit](codebase-audit.md) | Kanboard structure, bootstrap, config |
| [VPS Docker Staging](../deployment/vps-docker-staging.md) | Deployment guide |
| [ADR-001 Foundation Architecture](../decisions/ADR-001-foundation-architecture.md) | VPS-first decision |
