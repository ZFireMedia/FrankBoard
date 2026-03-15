# FrankBoard.com — Site Deploy Checklist v1

**Date**: 2025-03-15  
**Purpose**: Pre-launch and post-deploy verification.

---

## Pre-Deploy

- [ ] Domain `frankboard.com` points to VPS IP
- [ ] SSL certificate installed (Let's Encrypt/Certbot)
- [ ] HTTP → HTTPS redirect configured
- [ ] Nginx/Caddy server block for `frankboard.com` (see `site-deployment-v1.md`)

### Deploy Steps

1. **Copy site files** to `/var/www/frankboard-site/` (or equivalent)
   ```bash
   rsync -avz --delete site/ user@vps:/var/www/frankboard-site/
   ```

2. **Verify web root** serves `index.html` at `/`

3. **Check `try_files`** (Nginx):
   ```nginx
   location / {
     try_files $uri $uri/ $uri/index.html =404;
   }
   ```
   Ensures `/editions`, `/pricing`, etc. resolve to `index.html` in subdirs.

---

## Post-Deploy Verification

| Check | Expected |
|-------|----------|
| https://frankboard.com | Homepage loads |
| https://frankboard.com/editions/ | Editions page |
| https://frankboard.com/migrate/ | Migration page |
| https://frankboard.com/why/ | Why page |
| https://frankboard.com/pricing/ | Pricing page |
| https://frankboard.com/support/ | Support page |
| https://frankboard.com/robots.txt | Allow: /, Sitemap URL |
| https://frankboard.com/sitemap.xml | Valid XML, 6 URLs |
| https://frankboard.com/assets/css/main.css | CSS loads |
| https://frankboard.com/assets/img/favicon.svg | Favicon loads |

---

## Mobile / Responsive

- [ ] Homepage hero, benefits grid, trust grid reflow at 640px
- [ ] Nav wraps at narrow width
- [ ] Tables scroll horizontally on small screens
- [ ] Footer nav and copy stack on mobile

---

## Links to Verify

- [ ] "Get Community Free" → GitHub repo
- [ ] Footer "GitHub" → GitHub repo
- [ ] Footer "Kanboard" → kanboard/kanboard
- [ ] "Contact us" / Pro/Cloud CTAs → mailto:support@frankboard.com
- [ ] Internal links (Editions, Migrate, Why, Pricing, Support)

---

## Rollback

If deploy fails: restore previous `frankboard-site` backup or rsync prior copy. No database; static only.
