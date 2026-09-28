# FrankBoard Fix Priority Queue 001

**Date**: 2025-03-13  
**Source**: Test Run 001 (docs/qa/test-run-001.md), Bug Log 001 (docs/qa/bug-log-001.md)

---

## Ordered Fix List

| # | Bug ID | Title | Severity | Status |
|---|--------|-------|----------|--------|
| 1 | BUG-001 | app.frankboard.com returns 403 | P0 | **Fixed** — nginx + certbot SSL |
| 2 | BUG-002 | sitemap.xml returns 500 | P1 | **Fixed** — user confirmed sitemap loads in browser (Run 003) |

---

## What Should Be Fixed Before Wider Launch

1. ~~**BUG-001**~~ — Done. app.frankboard.com now serves app with HTTPS.
2. ~~**BUG-002**~~ — Done. Sitemap loads correctly (verified Run 003).

---

## What Can Wait

- **Task create/edit, search, admin, theme, responsive** — Run 002 verified login, dashboard, board at app.frankboard.com.
- **CTA link verification** — GitHub, mailto targets; quick manual check.
- **Favicon verification** — Low impact.
- **P2/P3 items** — None found in this run.

---

## Recommended Action Order

1. ~~Investigate app.frankboard.com nginx config~~ — Done.
2. ~~Investigate sitemap.xml 500~~ — Done. User confirmed sitemap works in browser.
3. ~~Re-run test pass after fixes~~ — Run 003 closeout complete.
4. **Launch-readiness sign-off** — No known P0/P1 blockers. FrankBoard launch-ready.
