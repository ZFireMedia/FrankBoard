# FrankBoard.com — Site Deploy Execution v1

**Date**: 2025-03-15  
**Status**: Executed  
**Scope**: Static site deployment to frankboard.com on VPS.

---

## Static Site Location on VPS

| Path | Purpose |
|------|---------|
| `/var/www/frankboard-site/` | Static site root (HTML, CSS, images, robots.txt, sitemap.xml) |
| `/root/frankboard/site/` | Source in repo; deploy script copies to `/var/www/frankboard-site` |

---

## Web Server Config

**Nginx** (Ubuntu). Config file: `/etc/nginx/sites-available/frankboard.com.conf`

### Added/Changed

- **frankboard.com** — New server block. Root: `/var/www/frankboard-site`. `try_files` for directory indexes (`/editions/` → `editions/index.html`).
- **www.frankboard.com** — Redirect 301 → `https://frankboard.com`
- **app.frankboard.com** — Config in repo (`config/nginx/app.frankboard.com.conf`); not yet enabled. Proxies to `127.0.0.1:8080` when enabled.

### Domain Mapping

| Domain | Serves | Port |
|--------|--------|------|
| frankboard.com | Static marketing site | 80 |
| www.frankboard.com | Redirect to frankboard.com | 80 |
| app.frankboard.com | (Optional) FrankBoard app proxy | 80 → 8080 |

---

## Redirect Behavior

- **www → apex**: `https://www.frankboard.com` → `https://frankboard.com` (301)
- Canonical: `https://frankboard.com`

---

## Deployment / Update Workflow

1. **From local**: Commit and push site changes to repo.
2. **Deploy**: `.\scripts\run-vps.ps1 -DeploySite`
3. **On VPS**: `git pull` in `/root/frankboard`, then `./scripts/deploy-site.sh`
4. Script copies `site/*` to `/var/www/frankboard-site`, installs nginx config, reloads nginx.

### Repeat Deploys

```powershell
.\scripts\run-vps.ps1 -DeploySite
```

---

## Rollback

- **Site**: `cp -r` backup of `/var/www/frankboard-site` before deploy; restore if needed.
- **Nginx**: Config in repo; revert with `git checkout` and re-run deploy.
- **App**: Unaffected. App runs in Docker at port 8080; site is separate.

---

## SSL / Cloudflare

- Cloudflare handles DNS and SSL proxying.
- Nginx listens on port 80.
- For origin certificate (Full/Strict): run `certbot --nginx -d frankboard.com -d www.frankboard.com` on VPS.

---

## Verification (Local to VPS)

```bash
curl -sI -H 'Host: frankboard.com' http://127.0.0.1/
curl -sI -H 'Host: frankboard.com' http://127.0.0.1/editions/
curl -sI -H 'Host: frankboard.com' http://127.0.0.1/robots.txt
curl -sI -H 'Host: frankboard.com' http://127.0.0.1/assets/css/main.css
```

All return 200 OK when Host is frankboard.com.
