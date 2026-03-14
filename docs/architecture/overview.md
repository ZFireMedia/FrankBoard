# FrankBoard Architecture Overview

> **Note**: The primary architecture document is [system-overview.md](system-overview.md), which describes the VPS-first runtime model. This file provides a brief summary.

## Summary

FrankBoard is a modernization fork of Kanboard. The primary runtime for Phase 1 is a **Dockerized VPS environment**—development and staging run on a VPS with Docker, not on local Docker.

- **Upstream**: Kanboard v1.2.51
- **Database**: PostgreSQL 16 (primary)
- **Stack**: Nginx, PHP 8.4, Alpine Linux
- **Key directories**: `app/`, `plugins/`, `data/`, `vendor/`, `libs/`
- **Config**: `DATABASE_URL` (env) or `data/config.php` / `config.php`

See [system-overview.md](system-overview.md) for full architecture and [codebase-audit.md](codebase-audit.md) for implementation details.
