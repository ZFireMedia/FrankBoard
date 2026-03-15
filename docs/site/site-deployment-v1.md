# FrankBoard.com — Site Deployment v1

**Date**: 2025-03-15  
**Status**: Architecture document  
**Scope**: Static site deployment model on VPS; separation from product app.

---

## Static Deployment Model on VPS

### Approach

The launch site is **static HTML/CSS/JS** served by a web server. No server-side rendering, no CMS, no build-time backend.

| Option | Pros | Cons |
|--------|------|------|
| **Nginx** | Fast, mature, easy config | More config for static-only |
| **Caddy** | Auto SSL, simple config | Slightly less familiar |
| **Pre-built container** | Reproducible | Extra image to maintain |

**Recommendation**: Serve static files via **Nginx** (or Caddy) in a dedicated directory. No Docker required for the site itself unless containerizing for consistency — a simple `root /var/www/frankboard-site;` (or similar) suffices.

### Static Site Location on VPS

| Path | Purpose |
|------|---------|
| `/var/www/frankboard-site/` or `/root/frankboard-site/` | Static site root (HTML, CSS, JS, images) |

Keep this **separate** from `/root/frankboard` (the product app repo). The site is a different artifact with its own update workflow.

---

## Reverse Proxy Considerations

### Domain and Routing

| Domain | Serves | Notes |
|--------|--------|-------|
| **frankboard.com** | Marketing site (static) | Primary domain |
| **app.frankboard.com** or **board.frankboard.com** | FrankBoard app (Docker) | Optional subdomain for product |

**OR** (simpler initially):

| Path | Serves |
|------|--------|
| **frankboard.com/** | Marketing site |
| **frankboard.com/app/** or **frankboard.com/demo/** | Proxy to app (port 8080) |

**Recommendation**: Use **frankboard.com** for the marketing site only at launch. Run the app on a subdomain (e.g., **app.frankboard.com**) or separate URL (e.g., **demo.frankboard.com**) when ready. Keeps routing simple and avoids path conflicts.

### Reverse Proxy Configuration (Nginx Example)

```nginx
# Marketing site
server {
    listen 80;
    listen [::]:80;
    server_name frankboard.com www.frankboard.com;
    root /var/www/frankboard-site;
    index index.html;
    location / {
        try_files $uri $uri/ $uri.html /index.html;
    }
}

# App (when on subdomain)
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

## Domain and Path Structure Recommendations

### Marketing Site Paths

| Path | Page |
|------|------|
| `/` | Homepage |
| `/editions/` | Edition comparison |
| `/migration/` | Migrate from Kanboard |
| `/why/` | Why FrankBoard exists |
| `/pricing/` | Pricing |
| `/support/` | Support |

Trailing slashes optional; pick one convention and stick to it.

### App Paths (when separate)

- `app.frankboard.com` or `demo.frankboard.com` — root is app login/dashboard
- No path prefix needed; entire subdomain is the app

---

## SSL and Caching

### SSL

- **Recommendation**: Use **Let's Encrypt** (Certbot) or **Caddy** auto-HTTPS
- Enforce HTTPS; redirect HTTP → HTTPS
- HSTS header optional but recommended for production

### Caching

| Resource | Cache header | Rationale |
|----------|--------------|-----------|
| HTML | `Cache-Control: max-age=300` or no-cache | Allow quick content updates |
| CSS, JS | `Cache-Control: max-age=31536000, immutable` | Use hashed filenames; long cache |
| Images | `Cache-Control: max-age=86400` | Balance freshness and performance |

Use hashed filenames (e.g., `main.a1b2c3.css`) for assets to enable long cache without stale content.

---

## Separation from App Runtime

### Clear Boundaries

| Artifact | Location | Deploy |
|----------|----------|--------|
| **Marketing site** | `/var/www/frankboard-site/` (or `site/` in repo) | rsync, script, or Git pull |
| **FrankBoard app** | Docker at `/root/frankboard` | `deploy-wave1.sh` |

The marketing site **does not** live inside the app container. The app serves the product; the site serves marketing pages.

### No Shared State

- Site has no database
- Site does not call app APIs for rendering (static only)
- Links to app: use full URL (e.g., `https://app.frankboard.com` or demo URL)

---

## Update and Deploy Workflow Recommendation

### Option A: Git + rsync (Simple)

1. Build/export static site locally (or in CI)
2. `rsync -avz ./dist/ user@vps:/var/www/frankboard-site/`
3. No rebuild on VPS; push pre-built files

### Option B: Git pull + build on VPS

1. Clone site repo on VPS (e.g., `/root/frankboard-site-repo`)
2. On deploy: `git pull && npm run build` (or similar)
3. Copy `dist/` to `/var/www/frankboard-site/`

### Option C: Separate repo for site

- `FrankBoard` repo = product (app)
- `FrankBoard-site` repo = marketing site (or `site/` subfolder in main repo)
- Deploy site via its own pipeline

**Recommendation**: Start with **Option A** (build locally, rsync) or a **site/** folder in the main repo with a simple `scripts/deploy-site.sh` that rsyncs to the VPS. Add CI/CD when needed.

### Deploy Script Sketch

```bash
#!/bin/bash
# scripts/deploy-site.sh — run from local machine
set -e
SITE_DIR="./site"   # or ./dist if using static generator
VPS_HOST="frankboard-vps"
REMOTE_PATH="/var/www/frankboard-site"

rsync -avz --delete "$SITE_DIR/" "$VPS_HOST:$REMOTE_PATH/"
echo "Site deployed to $REMOTE_PATH"
```

---

## Checklist Before Go-Live

- [ ] Domain frankboard.com points to VPS IP
- [ ] SSL certificate installed and HTTP→HTTPS redirect active
- [ ] Static files in correct path; Nginx/Caddy serving them
- [ ] 404 page configured (e.g., `/404.html`)
- [ ] robots.txt and sitemap.xml in place
- [ ] App (if on subdomain) proxy configured and tested
- [ ] No mixed content (HTTPS site loading HTTP resources)

---

## Summary

- **Model**: Static files served by Nginx/Caddy
- **Location**: `/var/www/frankboard-site/` — separate from app
- **Domain**: frankboard.com for site; app.frankboard.com for product when ready
- **SSL**: Let's Encrypt; enforce HTTPS
- **Cache**: Short for HTML; long for hashed CSS/JS
- **Deploy**: rsync or script; no CMS or server-side build on VPS
- **Separation**: Site and app are independent; no shared runtime
