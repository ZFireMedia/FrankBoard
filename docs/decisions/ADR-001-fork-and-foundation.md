# ADR-001: Fork Kanboard as FrankBoard and Establish Phase 1 Foundation

## Status

Accepted (2025-03-13)

## Context

- Kanboard is in maintenance mode; no major feature development planned
- Need a modernized, cleaner, self-hosted work board for small teams
- Goals: preserve simplicity, stability, self-hosting, low operational overhead
- Must avoid turning into a Jira clone

## Decision

1. **Fork Kanboard** as FrankBoard, preserving full upstream compatibility initially
2. **Use Docker** as the primary local/dev/prod workflow
3. **Prefer PostgreSQL** as the target database (Kanboard supports it natively)
4. **Pin Kanboard image** to v1.2.51 for stability; use official image until custom build is needed
5. **Document everything** in `/docs`, `PROJECT_STATUS.md`, `ACTION_LOG.md`
6. **Add ADRs** for significant technical decisions
7. **Phase 1 scope**: inspect, fork, dockerize, verify, document—no feature changes yet

## Consequences

- FrankBoard runs as Kanboard under the hood; upgrades from upstream remain possible
- PostgreSQL is the recommended path; SQLite/MySQL still supported via upstream compose files
- Docker Compose is the entry point; bare-metal install follows Kanboard procedures
- Rollback: remove FrankBoard-specific files and use Kanboard docker-compose directly

## References

- [Kanboard Docker docs](https://docs.kanboard.org/v1/admin/docker/)
- [Kanboard config](https://docs.kanboard.org/v1/admin/config/)
- Project rules (core rules 1–10)
