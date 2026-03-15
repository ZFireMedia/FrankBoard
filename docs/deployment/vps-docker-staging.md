# VPS Docker Staging Deployment Guide

FrankBoard uses a **VPS-first** deployment model: the primary development and staging runtime is Docker on a VPS, not local Docker on the operator machine.

---

## 1. Deployment Assumptions

- **VPS** with Docker and Docker Compose v2+ installed
- **SSH** access to the VPS
- **Optional**: Reverse proxy (nginx, Caddy, Traefik) in front of the app for SSL and routing
- **Network**: App container reachable on host port (default 8080) or via reverse proxy

---

## 2. Required Docker Services

| Service | Image | Purpose |
|---------|-------|---------|
| `app` | `kanboard/kanboard:v1.2.51` | Web application (Nginx + PHP-FPM) |
| `db` | `postgres:16-alpine` | PostgreSQL database |

The `app` service depends on `db` being healthy before starting.

---

## 3. Environment Variables

Create `.env` from `.env.example` on the VPS. Key variables:

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `POSTGRES_USER` | No | kanboard | PostgreSQL username |
| `POSTGRES_PASSWORD` | **Yes** (prod) | kanboard-secret | PostgreSQL password |
| `POSTGRES_DB` | No | kanboard | Database name |
| `APP_PORT` | No | 8080 | Host port for app (e.g. 8080 or 80) |
| `KANBOARD_IMAGE` | No | kanboard/kanboard:v1.2.51 | Application image |
| `PLUGIN_INSTALLER` | No | false | Enable web plugin install (dev only) |

**Security**: For staging/production, set a strong `POSTGRES_PASSWORD` and do not enable `PLUGIN_INSTALLER` unless in a trusted dev environment.

### Reverse Proxy (Optional)

When behind a reverse proxy (e.g. Caddy, nginx) that terminates SSL and forwards to the app:

| Variable | Purpose |
|----------|---------|
| `REVERSE_PROXY_AUTH` | `true` if using proxy-based auth |
| `TRUSTED_PROXY_NETWORKS` | CIDR list (e.g. `172.16.0.0/12,10.0.0.0/8`) |
| `TRUSTED_PROXY_HEADERS` | e.g. `HTTP_X_REAL_IP,HTTP_X_FORWARDED_FOR` |

---

## 4. Volume Persistence Expectations

| Volume | Purpose | Backup Priority |
|--------|---------|-----------------|
| `app_data` | Attachments, cache, optional `data/config.php` | High |
| `app_plugins` | Installed plugins | High |
| `db_data` | PostgreSQL data | **Critical** |
| `certs` | SSL certificates (optional; self-signed if empty) | Low |

**Critical**: Without `db_data`, database content is lost on container recreation. `app_data` holds user uploads and cache.

---

## 5. Database Service Notes

- **PostgreSQL 16** (Alpine) — FrankBoard’s default
- **Healthcheck**: `pg_isready`; app waits for `condition: service_healthy` before start
- **Auto-migrations**: Kanboard runs schema migrations on first request when `DB_RUN_MIGRATIONS` is true (default)
- **Connection**: App uses `DB_DRIVER`, `DB_USERNAME`, `DB_PASSWORD`, `DB_HOSTNAME=db`, `DB_NAME`, `DB_PORT` (explicit vars avoid DATABASE_URL parse issues with special chars in passwords)

---

## 6. Startup Workflow

```bash
# On VPS: clone FrankBoard (replace YOUR_USERNAME with your GitHub username)
# Or use rsync/scp if the repo is not yet on GitHub — see docs/CREATE_REMOTE_AND_PUSH.md
git clone https://github.com/YOUR_USERNAME/FrankBoard.git frankboard
cd frankboard

# Create environment
cp .env.example .env
# Edit .env: set POSTGRES_PASSWORD and any overrides

# Start stack
docker compose up -d

# Verify
docker compose ps
curl http://localhost:8080/healthcheck.php
# Expected: {"status":200,"message":"Database connection is OK"}
```

Access: `http://<vps-ip>:8080` or via reverse proxy. Default login: **admin** / **admin** — change immediately.

---

## 7. Update Workflow

```bash
# Pull latest FrankBoard (compose, env example, docs)
git pull

# Re-pull images and recreate containers
docker compose pull
docker compose up -d

# Kanboard migrations run automatically on next request
```

For image version changes, update `KANBOARD_IMAGE` in `.env` (e.g. `v1.2.52`) and run `docker compose up -d`.

### 7a. Deploy Wave 1 (custom FrankBoard build)

Wave 1 includes CSS/template changes that require building from the FrankBoard repo (not the stock Kanboard image). **Repo path on VPS**: `/root/frankboard`.

From your local machine (requires SSH key access):

```powershell
.\scripts\run-vps.ps1 -DeployWave1
```

Or manually via SSH:

```bash
ssh frankboard-vps "cd /root/frankboard && git pull && chmod +x scripts/deploy-wave1.sh && ./scripts/deploy-wave1.sh"
```

Or on the VPS directly:

```bash
cd /root/frankboard
git pull
./scripts/deploy-wave1.sh
```

Verify at http://66.179.208.122:8080 — login page should show centered card layout and FrankBoard branding.

---

## 8. Backup Considerations

| Item | Method |
|------|--------|
| PostgreSQL | `docker compose exec db pg_dump -U kanboard kanboard > backup.sql` |
| App data (files, cache) | `docker compose run --rm app tar czf - -C /var/www/app data` or volume backup |
| Plugins | Backup `app_plugins` volume |

**Suggested schedule**: Daily pg_dump to off-VPS storage; periodic volume snapshots if available.

---

## 9. Rollback Considerations

| Scenario | Action |
|----------|--------|
| Bad deploy | `docker compose down`; restore `.env` and `docker-compose.yml` from git; `docker compose up -d` |
| Database corruption | Restore from `pg_dump` backup; `docker compose exec -T db psql -U kanboard kanboard < backup.sql` |
| Revert image version | Set `KANBOARD_IMAGE=kanboard/kanboard:v1.2.50` in `.env`; `docker compose up -d` |

Volumes persist across `docker compose down`. Use `docker compose down -v` only if intending to delete data.
