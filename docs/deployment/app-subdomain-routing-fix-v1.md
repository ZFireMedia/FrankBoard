# App Subdomain Routing Fix v1

**Date**: 2025-03-13  
**Context**: app.frankboard.com returned 403. Nginx had no dedicated server block. dev.zfiremedia.com config caused conflicting server_name warnings.

---

## What Was Changed

### Removed

| Item | Path | Reason |
|------|------|--------|
| dev.zfiremedia.com config | `/etc/nginx/sites-available/dev.zfiremedia.com` | Unused; caused `conflicting server name "dev.zfiremedia.com"` warnings |
| dev.zfiremedia.com symlink | `/etc/nginx/sites-enabled/dev.zfiremedia.com` | Disabled the config |

**Old dev.zfiremedia.com config** (for reference):
- Served `/var/www/html` with PHP 8.1-FPM
- SSL via Let's Encrypt
- HTTP→HTTPS redirect

### Added

| Item | Path | Purpose |
|------|------|---------|
| app.frankboard.com config | `/etc/nginx/sites-available/app.frankboard.com.conf` | Reverse proxy to FrankBoard app |
| Symlink | `/etc/nginx/sites-enabled/app.frankboard.com.conf` | Enable the config |

**Source**: `config/nginx/app.frankboard.com.conf` (repo)

---

## App Configuration

| Field | Value |
|-------|-------|
| Docker service | `frankboard` (app) |
| Container port | 80 (internal) |
| Host port | 8080 |
| Proxy target | `http://127.0.0.1:8080` |

---

## app.frankboard.com Server Block

```nginx
server {
    listen 80;
    listen [::]:80;
    server_name app.frankboard.com;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

---

## Verification

| Test | Result |
|------|--------|
| `nginx -t` | OK, no syntax errors |
| `nginx -T 2>&1 \| grep -i warn` | No warnings (dev.zfiremedia.com conflicts gone) |
| `curl -sI -H 'Host: app.frankboard.com' http://127.0.0.1/` | 302 → /login (app response, not 403) |
| `curl -sI -H 'Host: frankboard.com' http://127.0.0.1/` | 301 → https://frankboard.com (unchanged) |

---

## SSL / HTTPS

**Status**: SSL for app.frankboard.com is **configured** (added 2025-03-16).

- Certbot was run: `certbot --nginx -d app.frankboard.com --non-interactive --agree-tos`
- Certificate: `/etc/letsencrypt/live/app.frankboard.com/` (expires 2026-06-14)
- Certbot updated the app.frankboard.com nginx config to add `listen 443 ssl` and HTTP→HTTPS redirect

---

## Commands Executed (VPS)

```bash
# Remove old config
rm -f /etc/nginx/sites-enabled/dev.zfiremedia.com /etc/nginx/sites-available/dev.zfiremedia.com

# Install app config
cp /root/frankboard/config/nginx/app.frankboard.com.conf /etc/nginx/sites-available/
ln -sf /etc/nginx/sites-available/app.frankboard.com.conf /etc/nginx/sites-enabled/

# Test and reload
nginx -t
systemctl reload nginx
```

---

## Sites-Enabled After Fix

```
app.frankboard.com.conf -> /etc/nginx/sites-available/app.frankboard.com.conf
cdn.zfiremedia.com -> /etc/nginx/sites-available/cdn.zfiremedia.com
default -> /etc/nginx/sites-available/default
frankboard.com.conf -> /etc/nginx/sites-available/frankboard.com.conf
```

---

## Deploy Script Note

`scripts/deploy-site.sh` installs `frankboard.com.conf` only. To ensure app config survives future deploys, either:

1. Extend `deploy-site.sh` to also copy and enable `app.frankboard.com.conf`, or
2. Run the install commands above manually after a fresh server setup.
