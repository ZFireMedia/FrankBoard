# FrankBoard.com — Post-Deploy Verification Checklist v1

**Date**: 2026-03-15  
**Purpose**: Verify static site is live and functioning at frankboard.com.

---

## Verification (Run After Deploy)

| Check | URL / Action | Expected |
|-------|-------------|----------|
| Homepage loads | https://frankboard.com | 200, FrankBoard homepage |
| Editions | https://frankboard.com/editions/ | 200, edition comparison page |
| Migrate | https://frankboard.com/migrate/ | 200, migration page |
| Why | https://frankboard.com/why/ | 200, Why FrankBoard page |
| Pricing | https://frankboard.com/pricing/ | 200, pricing page |
| Support | https://frankboard.com/support/ | 200, support page |
| Nav links | Click Editions, Migrate, Why, Pricing, Support | Each navigates correctly |
| CSS loads | DevTools Network: main.css | 200 |
| Favicon loads | DevTools Network: favicon.svg | 200 |
| robots.txt | https://frankboard.com/robots.txt | 200, Allow: / |
| sitemap.xml | https://frankboard.com/sitemap.xml | 200, valid XML |
| Canonical | https://www.frankboard.com | 301 redirect to https://frankboard.com |

---

## VPS-Side Verification (SSH)

```bash
# Homepage
curl -sI -H 'Host: frankboard.com' http://127.0.0.1/ | head -3

# Subpage
curl -sI -H 'Host: frankboard.com' http://127.0.0.1/editions/ | head -3

# Assets
curl -sI -H 'Host: frankboard.com' http://127.0.0.1/robots.txt | head -3
curl -sI -H 'Host: frankboard.com' http://127.0.0.1/sitemap.xml | head -3
curl -sI -H 'Host: frankboard.com' http://127.0.0.1/assets/css/main.css | head -3
```

All should return `HTTP/1.1 200 OK` (or 301 for www redirect).

---

## Mobile Check

- [ ] Resize browser to 375px width — layout reflows, no horizontal scroll
- [ ] Nav wraps or collapses appropriately
- [ ] Card grids stack to single column
- [ ] Buttons/links remain tappable

---

## Placeholders / Deferred Items

| Item | Status |
|------|--------|
| SSL (HTTPS) | Cloudflare proxy or Certbot — run `certbot --nginx -d frankboard.com -d www.frankboard.com` if origin cert needed |
| app.frankboard.com | Config in repo; enable when app subdomain is ready |
| og-default.png | Not present; add for social sharing when ready |
