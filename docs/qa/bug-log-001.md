# FrankBoard Bug Log 001

**Test Run**: RUN-2025-03-13-001  
**Date**: 2025-03-13  
**Environment**: Production (frankboard.com, app.frankboard.com) + Staging (66.179.208.122:8080)

---

## BUG-001: app.frankboard.com returns 403 Forbidden

**Severity**: P0 (blocking — if app is intended to be live)

**Environment**:
| Field | Value |
|-------|-------|
| App/Site URL | https://app.frankboard.com/ |
| Browser | Cursor IDE Browser |
| OS | Windows 10 |

**Steps to Reproduce**:
1. Navigate to https://app.frankboard.com/
2. Observe response

**Expected Result**: App loads (login page or dashboard).

**Actual Result**: 403 Forbidden. Page shows "403 Forbidden" with Show Details and Reload buttons.

**Screenshot / Logs**: Snapshot shows document title "403 Forbidden"; two buttons visible (Show Details, Reload).

**Notes**: Staging app at http://66.179.208.122:8080 loads correctly. Nginx config for app.frankboard.com may be disabled or misconfigured per docs/site/site-deploy-execution-v1.md ("app.frankboard.com config ready" but not enabled).

**Resolution (2025-03-13)**: Nginx routing fix applied per docs/deployment/app-subdomain-routing-fix-v1.md. dev.zfiremedia.com removed; app.frankboard.com config enabled. Certbot run; SSL added. https://app.frankboard.com loads login page.

**Status**: Fixed

---

## BUG-002: sitemap.xml returns 500 Internal Server Error

**Severity**: P1 (high — SEO impact, launch checklist failure)

**Environment**:
| Field | Value |
|-------|-------|
| App/Site URL | https://frankboard.com/sitemap.xml |
| Method | mcp_web_fetch |
| Browser | Cursor IDE Browser |

**Steps to Reproduce**:
1. Fetch https://frankboard.com/sitemap.xml
2. Observe response

**Expected Result**: 200 OK, valid XML sitemap.

**Actual Result**: 500 Internal Server Error. Fetch failed with status 500.

**Screenshot / Logs**: `Error fetching URL https://frankboard.com/sitemap.xml: Error fetching URL, status code: 500 Internal Server Error`

**Notes**: robots.txt references `https://frankboard.com/sitemap.xml`. Sitemap exists in site source (site/sitemap.xml). Possible nginx/Cloudflare routing or MIME-type issue serving static XML.

**Resolution (2025-03-16)**: User confirmed sitemap loads correctly in browser. QA Test Run 003 closeout verification.

**Status**: Fixed

---

## Summary

| Bug ID | Severity | Status |
|--------|----------|--------|
| BUG-001 | P0 | Fixed |
| BUG-002 | P1 | Fixed |

**Total**: 2 bugs logged; both fixed.
