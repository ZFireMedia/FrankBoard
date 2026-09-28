# FrankBoard Launch Readiness Checklist v1

**Date**: 2025-03-16  
**Use**: Run before announcing launch, before marketing push, or after major site/app changes.  
**Scope**: Marketing site (frankboard.com) + app readiness.

---

## Marketing Site (frankboard.com)

### All Public Pages Load

- [ ] https://frankboard.com — Homepage
- [ ] https://frankboard.com/editions/ — Editions
- [ ] https://frankboard.com/migrate/ — Migration
- [ ] https://frankboard.com/why/ — Why FrankBoard
- [ ] https://frankboard.com/pricing/ — Pricing
- [ ] https://frankboard.com/support/ — Support

All return 200, no 4xx/5xx.

### Nav / Footer Consistency

- [ ] Header nav: Editions, Migrate, Why, Pricing, Support present on all pages
- [ ] "Get Community Free" CTA in header links to GitHub
- [ ] Footer nav matches header
- [ ] Footer "Built on Kanboard" links to kanboard/kanboard

### CTA Correctness

- [ ] "Get Community Free" → GitHub FrankBoard repo
- [ ] Pro/Cloud "Contact us" → mailto:support@frankboard.com
- [ ] Internal links (Compare editions, Migrate, etc.) resolve correctly

### Email / Contact Correctness

- [ ] support@frankboard.com is valid and monitored
- [ ] mailto links use correct address

### Metadata / Favicon Basics

- [ ] Each page has unique title and meta description
- [ ] Favicon loads (assets/img/favicon.svg)
- [ ] robots.txt returns 200, Allow: /
- [ ] sitemap.xml returns 200, valid XML

### App / Site Boundary Correctness

- [ ] Site does not link to broken app URLs
- [ ] app.frankboard.com (when live) or staging URL is correct if linked
- [ ] No mixed content (HTTP resources on HTTPS page)

### SSL / Basic Trust

- [ ] https://frankboard.com loads over HTTPS
- [ ] No certificate warnings in browser
- [ ] (Optional) www.frankboard.com redirects to frankboard.com

---

## App Readiness (When Applicable)

- [ ] App URL (staging or app.frankboard.com) loads
- [ ] Login works
- [ ] Core flow (create project, task) works
- [ ] No known P0/P1 bugs open

---

## Summary

| Area | Pass | Fail | Notes |
|------|------|------|-------|
| Site pages | | | |
| Nav/Footer | | | |
| CTAs | | | |
| Contact | | | |
| Metadata | | | |
| App boundary | | | |
| SSL | | | |
| App | | | |

**Launch-ready?** All Pass, no P0/P1 blockers.
