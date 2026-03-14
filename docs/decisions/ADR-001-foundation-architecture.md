# ADR-001: Foundation Architecture — VPS-First Docker Environment

## Status

Accepted (2025-03-13)

## Context

- FrankBoard is a modernization fork of Kanboard
- Local Docker is not installed on the operator machine
- Project has access to a VPS with Docker available
- Phase 1 goal: prepare the codebase for safe modernization with a coherent deployment path

## Decision

1. **VPS-first deployment model** — The primary development and staging runtime is Docker on a VPS, not local Docker on the operator machine.
2. **PostgreSQL** as the documented target database (Kanboard supports it natively).
3. **Docker Compose** as the deployment mechanism — `docker-compose.yml` with `.env` for configuration.
4. **Official Kanboard image** pinned to v1.2.51 — no custom build required for Phase 1.
5. **Documentation** — Architecture docs, codebase audit, VPS deployment guide, ADRs.
6. **Constraints** — No UI redesign, no AI features, no large refactors in Phase 1.

## Consequences

- Operator machine: edit code, manage git, read docs; no local Docker required.
- VPS: clone repo, set `.env`, run `docker compose up -d`.
- Reverse proxy: document expectations (TRUSTED_PROXY_*, optional SSL termination).
- Backup and rollback procedures documented in the VPS deployment guide.
- Rollback: revert compose/env, restore DB from `pg_dump`, or pin older image version.

## References

- [VPS Docker Staging Guide](../deployment/vps-docker-staging.md)
- [System Overview](../architecture/system-overview.md)
- [Codebase Audit](../architecture/codebase-audit.md)
- [ADR-001 Fork and Foundation](ADR-001-fork-and-foundation.md) — prior fork decision
