# FrankBoard vs Kanboard

FrankBoard is a **fork of [Kanboard](https://github.com/kanboard/kanboard)** (based on v1.2.51). Same core model — projects, boards, tasks, swimlanes, categories, plugins, and database schema — with product and UX modernization for small teams.

This document is the clear list of differences required for community listings (e.g. awesome-selfhosted).

## What stays the same

- Kanban boards, tasks, subtasks, swimlanes, categories, tags
- Plugin API and existing Kanboard plugins (compatibility target)
- Database schema — migration from Kanboard is typically backup → point FrankBoard at the same DB → verify
- Self-hosted, MIT-licensed core
- PHP application stack

## What FrankBoard changes

| Area | FrankBoard | Upstream Kanboard |
|------|------------|-------------------|
| **UI** | Modernized login, board, task cards/detail, modals, forms, dashboard; light/dark consistency | Classic Kanboard UI |
| **Branding** | FrankBoard product branding and marketing site | Kanboard branding |
| **Deployment default** | Docker + PostgreSQL first-class (VPS-oriented compose) | Multiple install paths; SQLite common for simple installs |
| **Product packaging** | Community (free) + paid migration/setup assistance; Pro/Cloud roadmap | Open-source project; no FrankBoard commercial packaging |
| **Docs / site** | frankboard.com (migrate, pricing, screenshots, support) | kanboard.org + docs.kanboard.org |

## Migration

If you already run Kanboard:

1. Backup database and `data` folder
2. Point FrankBoard at that database (same schema)
3. Verify projects, tasks, and plugins

Guide: [https://frankboard.com/migrate/](https://frankboard.com/migrate/)

## What FrankBoard is not

- Not a Jira/Linear clone
- Not a drop-in replacement of every Kanboard distro package or third-party image without verification
- Not a guarantee that every third-party plugin has been re-tested on this fork — report issues if something breaks

## Upstream credit

Kanboard is created and maintained by its authors and community. FrankBoard builds on that work. See Kanboard’s license and documentation for upstream behavior and configuration.
