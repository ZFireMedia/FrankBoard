# FrankBoard.com Static Launch Site — Architecture v1

**Date**: 2025-03-15  
**Status**: Architecture document  
**Scope**: Design and structure for frankboard.com launch site; no implementation yet.

---

## Site Purpose

The launch site at frankboard.com presents FrankBoard to potential users, explains the product, editions, and migration path, and directs visitors to the appropriate next step (download Community, compare editions, migrate from Kanboard, contact for Pro/Cloud). It is a **marketing and product-information site**, not the product application.

---

## Page Inventory

| Page | Path | Purpose |
|------|------|---------|
| Homepage | `/` | Hero, benefits, trust, edition teaser, migration block |
| Edition comparison | `/editions/` or `/compare/` | Choose Community vs Pro vs Cloud |
| Migration | `/migrate/` | Kanboard users: steps, compatibility, reassurance |
| Why FrankBoard | `/why/` | Story, problem solved, deliberate boundaries |
| Pricing | `/pricing/` | Edition pricing overview, FAQ, CTAs |
| Support | `/support/` | Self-serve, by-edition support, services |

Optional future pages: `/about/`, `/contact/`, `/docs/` (if hosting docs separately).

---

## Content Hierarchy

```
Homepage (/)
├── Hero (headline, subhead, primary CTA)
├── Benefits (4 blocks)
├── Trust
├── Edition teaser
├── Migration block
└── Footer CTAs

Editions (/editions/)
├── Intro
├── Comparison table
├── Edition cards (short desc + CTA each)
├── FAQ
└── Footer CTA

Migration (/migrate/)
├── Hero (reassurance)
├── Overview bullets
├── Step-by-step guide
├── Compatibility table
├── Plugin caveat
├── Reverting
└── Support CTA

Why FrankBoard (/why/)
├── Headline/subhead
├── Story
├── Problem/solution
├── What we won't do
└── CTA

Pricing (/pricing/)
├── Headline
├── Community / Pro / Cloud blocks
├── FAQ
└── CTA

Support (/support/)
├── Headline
├── Self-serve (docs, GitHub, troubleshooting)
├── By edition
├── Services
└── Contact CTA
```

---

## Navigation Model

**Primary nav** (header, all pages):
- Product (or Editions) → `/editions/`
- Migrate → `/migrate/`
- Why → `/why/`
- Pricing → `/pricing/`
- Support → `/support/`

**Secondary**:
- Get Community (primary CTA) — prominent in header and footer
- Contact (if Pro/Cloud interest form exists) — footer, support page

**Footer**:
- Navigation links (repeat or subset)
- Get Community, Compare editions, Migrate, Pricing
- Optional: GitHub, docs link

Keep nav shallow; no more than one level of dropdown if any.

---

## Shared Layout Strategy

| Element | Scope | Notes |
|---------|-------|-------|
| **Header** | All pages | Logo, nav, primary CTA (Get Community) |
| **Footer** | All pages | Nav, CTAs, optional legal/links |
| **Hero pattern** | Home, Migration, Why, Pricing, Support | Consistent headline/subhead treatment |
| **Section pattern** | Benefit blocks, trust, edition cards | Reusable content blocks |
| **CTA block** | All pages | Consistent button/link treatment |

Layout components:
- **Header** — logo (links to /), nav links, primary CTA button
- **Footer** — nav, CTA row, optional copyright/links
- **Hero** — headline (h1), subhead (p), optional CTA
- **Section** — heading (h2), body, optional CTA
- **Card** — for edition blocks, benefit blocks, trust items

---

## CTA Strategy

| CTA | Destination | Placement |
|-----|-------------|-----------|
| Get Community Free | GitHub / Docker / download link | Header, hero, footer, multiple pages |
| Compare editions | `/editions/` | Homepage, footer |
| Migrate from Kanboard | `/migrate/` | Homepage, footer |
| See pricing | `/pricing/` | Homepage, editions, footer |
| Contact for Pro | Contact form / email | Editions, pricing, support |
| Contact for Cloud | Contact form / email | Editions, pricing, support |
| Migration assistance | Contact / support | Migration page, support page |

Primary CTA (Get Community) must be visible above the fold on homepage and in header.

---

## Relationship Between Marketing Site and Product App

| Aspect | Marketing site (frankboard.com) | Product app (app.frankboard.com or demo URL) |
|--------|----------------------------------|----------------------------------------------|
| **Purpose** | Explain, position, convert | Use FrankBoard |
| **Content** | Static HTML, copy from docs/marketing-copy | Dynamic Kanboard app |
| **Hosting** | Static files (nginx, Caddy, S3+CDN) | Docker containers |
| **Updates** | Push static build | Deploy app image |
| **Domain** | frankboard.com (root) | app.frankboard.com or demo subdomain |
| **Separation** | No shared code or runtime | Independent |

**Recommended**: Marketing site at `frankboard.com`. App at `app.frankboard.com` or `demo.frankboard.com` (or keep app on current staging IP until ready). Never mix marketing pages and app on the same path without clear separation.

---

## Summary

- Six launch pages: home, editions, migrate, why, pricing, support
- Flat nav; shared header/footer; consistent hero and section patterns
- CTAs aligned with product stage: Community available, Pro/Cloud contact
- Marketing site and app are separate deployments and domains
