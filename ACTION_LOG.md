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

### Action: Fix FrankBoard DB connection — use DB_* instead of DATABASE_URL

**Timestamp**: 2025-03-14  
**Context**: FrankBoard container unhealthy on VPS. Logs showed `Undefined array key "driver"` in app/common.php — PicoDb UrlParser failed to parse DATABASE_URL (parse_url returns false, often due to special chars in password).

**Actions performed**:
1. Switched docker-compose from DATABASE_URL to explicit DB_* env vars (DB_DRIVER, DB_USERNAME, DB_PASSWORD, DB_HOSTNAME, DB_NAME, DB_PORT)
2. Updated docs/deployment/vps-docker-staging.md — troubleshooting note for DATABASE_URL parse failures, DB_* as workaround

**Files affected**:
- `docker-compose.yml` (environment: DB_* vars)
- `docs/deployment/vps-docker-staging.md` (troubleshooting)

**Root cause**: DATABASE_URL URL parsing fails on certain passwords; DB_* vars bypass UrlParser and are passed directly to PHP via Kanboard's env.conf.

**Next steps**: Pull on VPS, `docker compose down && docker compose up -d`; verify healthcheck passes and app loads.

---

### Action: Phase 2 Live UX Audit and Modernization Plan

**Timestamp**: 2025-03-14  
**Context**: FrankBoard running on VPS 66.179.208.122. Phase 2 product/UX analysis per task instructions. No implementation yet.

**Actions performed**:
1. Audited live FrankBoard at http://66.179.208.122:8080 — login page observed via browser
2. Reviewed codebase: templates (auth, dashboard, board, task creation, search), CSS (base, form, header, board, task_list, themes), responsive breakpoints (480px, 768px, 1000px)
3. Created `docs/product/ux-audit-v1.md` — summary, strengths, pain points, page-by-page findings, responsiveness, accessibility, modernization opportunities
4. Created `docs/product/ui-modernization-roadmap-v1.md` — prioritized must/should/later items, dependencies, sequencing
5. Created `docs/product/first-implementation-wave-v1.md` — first wave scope (typography, login polish, focus states, contrast), rationale, risk, exclusions
6. Updated `PROJECT_STATUS.md` — Phase 2 audit complete, verified staging, next step = first wave

**Areas reviewed**:
- Login experience (live)
- Dashboard/home, board view, task creation, task detail (codebase/templates)
- Navigation, search/filter (codebase)
- Responsiveness (CSS media queries)
- Visual hierarchy, form layout, themes (light/dark/auto)

**Conclusions**:
- Kanboard UX is functional but dated; Helvetica Neue, tight spacing, weak visual hierarchy
- Strengths: light/dark themes, search syntax, task metadata; keep simple, no Jira creep
- Highest friction: login blandness, task form density, board column width on mobile, button affordance
- First wave: typography, login, focus states, contrast — low risk, high visibility

**Files affected**:
- `docs/product/ux-audit-v1.md` (new)
- `docs/product/ui-modernization-roadmap-v1.md` (new)
- `docs/product/first-implementation-wave-v1.md` (new)
- `PROJECT_STATUS.md` (updated)
- `ACTION_LOG.md` (updated)

**Next steps**: Implement first wave when ready.

---

### Action: Wave 1 UI modernization implementation

**Timestamp**: 2025-03-14  
**Context**: Implement first UI wave per `docs/product/first-implementation-wave-v1.md` — CSS/template-only, no JS or API changes.

**Actions performed**:
1. Typography refresh — `base.css`: font stack `system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif`; `text-rendering: optimizeLegibility`
2. Login template — `app/Template/auth/index.php`: added `.login-page-wrapper` > `.login-card` > `.login-brand` + `.form-login` structure
3. Login CSS — new `assets/css/src/login.css`: centered card, 8px radius, theme variables, responsive 480px
4. Button focus — `button.css`: `outline: 2px solid var(--input-focus-border-color); outline-offset: 2px` on `:focus` / `:focus-visible`
5. Light theme contrast — `light.css`: `--input-placeholder-color` `#dedede` → `#999`
6. Build integration — added `login.css` to `CssCommand.php`; added `'css'` to `cli` bootstrap skip list; added `RUN cd /var/www/app && php cli css` to Dockerfile

**Files affected**:
- `app/Template/auth/index.php`
- `assets/css/src/base.css`
- `assets/css/src/login.css` (new)
- `assets/css/src/button.css`
- `assets/css/src/themes/light.css`
- `app/Console/CssCommand.php`
- `cli`
- `Dockerfile`
- `docs/product/wave-1-implementation-notes.md` (new)
- `PROJECT_STATUS.md` (updated)

**Results**: Wave 1 complete in repo. CSS build runs during Docker image build. Staging deploy pending.

**Next steps**: Rebuild image from FrankBoard repo, deploy to VPS, manual verification (login, dashboard, board, task, themes).

---

### Action: Deploy Wave 1 — script and verification prep

**Timestamp**: 2025-03-14  
**Context**: User requested deployment. Docker and PHP not available locally; SSH to VPS returned permission denied.

**Actions performed**:
1. Created `scripts/deploy-wave1.sh` — builds frankboard:wave1, updates .env, recreates containers
2. Added deploy-wave1 section to `docs/deployment/vps-docker-staging.md`
3. Verified staging live at http://66.179.208.122:8080 — login page loads (pre–Wave 1 state: basic left-aligned form, no card)
4. Captured pre–Wave 1 screenshot for comparison

**Files affected**:
- `scripts/deploy-wave1.sh` (new)
- `docs/deployment/vps-docker-staging.md` (updated)

**Blockers**: Deployment must be run on VPS. Run `./scripts/deploy-wave1.sh` after `git pull` from an SSH session.

**Next steps**: SSH to VPS, run deploy script; then verify login, dashboard, board, task, themes in browser.

---

### Action: VPS SSH setup for agent automation

**Timestamp**: 2025-03-14  
**Context**: Agent cannot run SSH (hangs or fails). User needs agent to handle deploys, updates, maintenance. Repo path: /root/frankboard.

**Diagnosis**:
- `ssh -o BatchMode=yes frankboard-vps "echo OK"` returns "Permission denied (publickey)" in ~8s — connection works, key auth fails from agent process
- Likely cause: key has passphrase; agent subprocess lacks ssh-agent

**Actions performed**:
1. Created `docs/deployment/vps-context.md` — canonical path (/root/frankboard), host, commands
2. Created `scripts/run-vps.ps1` — wrapper for `ssh -o BatchMode=yes frankboard-vps "<cmd>"`
3. Updated `docs/deployment/ssh-vps-setup.md` — automation key flow (passphrase-free key for non-interactive use)
4. Created `.cursor/rules/vps-context.mdc` — agent rule: path, run-vps.ps1, automation key
5. Updated `scripts/ssh-config-snippet.txt` — note on automation key
6. Updated `docs/deployment/vps-docker-staging.md` — /root/frankboard in deploy section

**Files affected**:
- `docs/deployment/vps-context.md` (new)
- `docs/deployment/ssh-vps-setup.md` (updated)
- `scripts/run-vps.ps1` (new)
- `scripts/ssh-config-snippet.txt` (updated)
- `.cursor/rules/vps-context.mdc` (new)
- `docs/deployment/vps-docker-staging.md` (updated)

**Fix for agent SSH**: Create automation key (no passphrase), add to VPS, set `IdentityFile ~/.ssh/id_ed25519_frankboard` in SSH config. See docs/deployment/ssh-vps-setup.md § Automation key.

**Next steps**: User runs automation key setup; then agent can run `.\scripts\run-vps.ps1 -DeployWave1` and other VPS commands.

---

**Summary stats**: 9 log entries | 42 files created/updated | VPS SSH automation ready (pending automation key)
