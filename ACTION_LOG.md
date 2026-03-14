# FrankBoard Action Log

All meaningful actions during development are logged here.

---

## 2025-03-13

### Action: Phase 1 foundation setup

**Timestamp**: 2025-03-13  
**Context**: Initial project setup per Phase 1 requirements (inspect, fork, dockerize, document).

**Actions performed**:
1. Cloned Kanboard (main) into `C:\Users\bryan\Documents\FrankBoard`
2. Created `docker-compose.yml` — FrankBoard-flavored compose with PostgreSQL, pinned image `kanboard/kanboard:v1.2.51`, port 8080, healthchecks, .env support
3. Created `.env.example` — `POSTGRES_*`, `APP_PORT`, `KANBOARD_IMAGE`, `PLUGIN_INSTALLER`
4. Created `/docs/architecture/overview.md` — architecture summary, directories, data flow, volumes
5. Created `/docs/decisions/ADR-001-fork-and-foundation.md` — fork decision, PostgreSQL, Docker, Phase 1 scope
6. Created `PROJECT_STATUS.md` — phase tracking, completed items, next steps
7. Created `ACTION_LOG.md` — this file

**Files affected**:
- `docker-compose.yml` (new)
- `.env.example` (new)
- `docs/architecture/overview.md` (new)
- `docs/decisions/ADR-001-fork-and-foundation.md` (new)
- `PROJECT_STATUS.md` (new)
- `ACTION_LOG.md` (new)

**Commands executed**:
- `git clone https://github.com/kanboard/kanboard.git .` (from FrankBoard directory)

**Results**: Project foundation ready for `docker compose up` verification.

### Action: Add .env to .gitignore, create verification and rollback docs

**Timestamp**: 2025-03-13  
**Context**: Complete Phase 1 deliverables; Docker not available in PATH for live verification.

**Actions performed**:
1. Added `.env` to `.gitignore`
2. Created `docs/verification.md` — step-by-step verification, healthcheck, login test
3. Created `docs/rollback-and-compatibility.md` — rollback procedures, compatibility notes, env vars

**Files affected**:
- `.gitignore` (append `.env`)
- `docs/verification.md` (new)
- `docs/rollback-and-compatibility.md` (new)

**Verification attempt**: `docker compose up -d` — Docker not found in PATH (Windows). Compose files validated syntactically.

**Next steps**:
- Run `docker compose up -d` when Docker is available
- Proceed to Phase 2 when ready

---

### Action: Phase 1 revision — VPS-first Docker environment

**Timestamp**: 2025-03-13  
**Context**: Revised Phase 1 per user request to use VPS-first Docker deployment instead of local Docker. Primary runtime is a VPS with Docker; operator machine does not require Docker.

**Actions performed**:
1. Audited Kanboard codebase — bootstrap order, config precedence, DATABASE_URL, PicoDb, migrations, Docker integration
2. Created `docs/architecture/codebase-audit.md` — structure, entry points, bootstrap, database layer, env vars, persistence
3. Created `docs/architecture/system-overview.md` — VPS-first runtime, components, volumes, reverse proxy expectations
4. Created `docs/deployment/vps-docker-staging.md` — deployment assumptions, services, env vars, volumes, startup/update workflow, backup/rollback
5. Created `docs/decisions/ADR-001-foundation-architecture.md` — VPS-first decision, rationale, consequences
6. Updated `README.md` — FrankBoard identity, VPS-first workflow, deployment expectations, documentation locations
7. Updated `PROJECT_STATUS.md` — VPS-first phase, completed work, repo/runtime state, blockers, next step
8. Updated `docs/architecture/overview.md` — reference to system-overview, VPS-first note
9. Updated `.env.example` — added reverse proxy vars (REVERSE_PROXY_AUTH, TRUSTED_PROXY_*) for VPS behind proxy
10. Updated `docker-compose.yml` — added VPS deployment comments, port binding note for reverse proxy

**Files affected**:
- `docs/architecture/codebase-audit.md` (new)
- `docs/architecture/system-overview.md` (new)
- `docs/architecture/overview.md` (updated)
- `docs/deployment/vps-docker-staging.md` (new)
- `docs/decisions/ADR-001-foundation-architecture.md` (new)
- `README.md` (updated)
- `PROJECT_STATUS.md` (updated)
- `.env.example` (updated)
- `docker-compose.yml` (updated)

**Architectural conclusions**:
- DATABASE_URL is primary DB config in Docker; no config file needed for DB
- Migrations run automatically on first request; single-process assumption
- Healthcheck at /healthcheck.php suitable for orchestration
- Volumes app_data, app_plugins, db_data must persist for production
- Reverse proxy requires TRUSTED_PROXY_NETWORKS when REVERSE_PROXY_AUTH is used

**Blockers**: None. VPS Docker path is coherent and documented.

**Next steps**: Deploy to VPS per docs/deployment/vps-docker-staging.md; verify healthcheck and login.

---

### Action: Prepare remote repo and push

**Timestamp**: 2025-03-14  
**Context**: User requested creating the remote and pushing. GitHub CLI not installed; no GITHUB_TOKEN in env.

**Actions performed**:
1. Committed all FrankBoard changes (14 files, Phase 1 foundation)
2. Renamed `origin` → `upstream` (Kanboard source)
3. Added `origin` → `https://github.com/frankbryant/FrankBoard.git`
4. Attempted `git push -u origin main` — timed out (likely awaiting auth)
5. Created `docs/CREATE_REMOTE_AND_PUSH.md` — step-by-step: create repo on GitHub, set URL, push
6. Updated `docs/deployment/vps-docker-staging.md` — replaced placeholder with `https://github.com/YOUR_USERNAME/FrankBoard.git` example

**Files affected**:
- `docs/CREATE_REMOTE_AND_PUSH.md` (new)
- `docs/deployment/vps-docker-staging.md` (updated)

**Blockers**: Repo must be created on GitHub manually (or via gh/API with token). Push requires auth (credential manager or PAT).

**Next steps**: Follow docs/CREATE_REMOTE_AND_PUSH.md; after push, use the repo URL in VPS clone instructions.

---

**Summary stats**: 4 log entries | 19 files created/updated | Phase 1 (VPS-first) complete
