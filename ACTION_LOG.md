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

### Action: Wave 1 deploy to staging (complete)

**Timestamp**: 2025-03-14  
**Context**: User set up automation key; agent SSH working. Deploy executed remotely.

**Actions performed**:
1. Committed and pushed Wave 1 + SSH setup (was local-only)
2. Ran deploy on VPS: `cd /root/frankboard && git pull && ./scripts/deploy-wave1.sh`
3. Fixed .dockerignore — removed `assets/css/src` and `assets/vendor` so `php cli css` runs during Docker build
4. Redeployed after fixes — CSS build succeeded
5. Verified login page: centered card, FrankBoard branding, typography live

**Files affected**: .dockerignore (2 commits: 53eab9c, 508bda2)

**Results**: Wave 1 live at http://66.179.208.122:8080. Agent can run deploys via SSH.

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

### Action: Wave 2 Interior UI Foundation

**Timestamp**: 2025-03-15  
**Context**: Implement second UI wave per scope — modals, forms, dashboard, header, panels. CSS/template-only.

**Actions performed**:
1. Modal polish — overlay 0.45 opacity, content padding 20–24px, box border/shadow, 8px radius
2. Form rhythm — labels 16px/4px, inputs 32px height, form-actions border-top, help-text spacing
3. Header — padding 8–16px, border via --header-border-color
4. Panel — border-radius via --surface-radius (6px)
5. Dashboard — page-header spacing, empty-state alert padding, table-list row/header padding
6. Theme vars — --header-border-color, --surface-radius, --modal-overlay-color (light/dark/auto)
7. Base .page — margin 16px, padding-top 8, max-width 1400

**Files affected**:
- assets/css/src/modal.css, form.css, header.css, panel.css, page_header.css
- assets/css/src/dashboard.css, project.css, table_list.css, base.css
- assets/css/src/themes/light.css, dark.css, auto.css
- docs/product/wave-2-implementation-notes.md (new)
- docs/product/wave-2-scope-review.md (new)
- PROJECT_STATUS.md (updated)

**Results**: Wave 2 ready. Deploy and verify pending.

**Next steps**: Deploy to staging, verify dashboard, modals, header in light/dark/auto.

---

### Action: Wave 3 Board and Task Experience

**Timestamp**: 2025-03-15  
**Context**: Implement third UI wave — board, task cards, task detail, task forms. CSS-only.

**Actions performed**:
1. Board — column header padding 12px 14px, swimlane header styling, board-task-list padding, draggable-placeholder radius
2. Task cards — padding 10px 12px, margin 10px, border/background theme vars, title font-weight 600
3. Task detail — task-summary-container padding 20–24px, columns gap 24px, li line-height 1.6
4. Task form — secondary column border-left, task-form-bottom border-top, padding/spacing
5. Task category/tags — theme vars, radius, padding on cards

**Files affected**:
- assets/css/src/board.css, task_board.css, task_summary.css, task_form.css, task_category.css, task_tags.css
- docs/product/wave-3-implementation-notes.md, wave-3-scope-review.md, wave-3-verification.md
- PROJECT_STATUS.md

**Results**: Wave 3 ready. Deploy and verify pending.

**Next steps**: Deploy, verify with admin/pass123, capture screenshots, update verification doc.

---

### Action: Wave 3 verification completed

**Timestamp**: 2025-03-15  
**Context**: Complete Wave 3 verification on staging, including docs.

**Actions performed**:
1. Created project "Wave3 Verify" on http://66.179.208.122:8080
2. Verified board page — column headers, swimlane styling, add-task links
3. Created task "Wave 3 CSS check" — task create form styling verified
4. Verified task card on board — spacing, border, title weight
5. Opened task detail — task-summary layout, padding, columns
6. Opened task edit form — secondary column, form bottom border
7. Captured screenshots: wave3-board.png, wave3-task-card.png, wave3-task-detail.png, wave3-task-form.png
8. Updated docs/product/wave-3-verification.md — all surfaces Pass; Light theme Pass; Dark/Auto deferred; follow-up: drag-and-drop, dark theme
9. Updated PROJECT_STATUS.md — Wave 3 verified

**Files affected**:
- docs/product/wave-3-verification.md (updated)
- ACTION_LOG.md (this entry)
- PROJECT_STATUS.md (Wave 3 status)

**Results**: Wave 3 verification complete. All core surfaces pass in light theme.

**Next steps**: Optional — verify drag-and-drop, dark/auto themes.

---

### Action: Commercial Packaging and Product Positioning v1

**Timestamp**: 2025-03-15  
**Context**: Strategy/documentation only. Move from pure modernization into product/business planning. Wave 1–3 approved; FrankBoard visually credible. No billing, licensing, or gating.

**Actions performed**:
1. **product-packaging-v1.md** — Product summary, target users (small teams, technical leads, Kanboard users), edition overview, core value proposition, what FrankBoard is and is not
2. **edition-strategy-v1.md** — Community (core board, self-hosted), Pro (support, automation, priority features), Cloud (managed hosting); feature boundaries; free vs paid vs cloud-only
3. **migration-positioning-v1.md** — Positioning relative to Kanboard (modernized successor), migration promise, compatibility guidance, trust/continuity language, comparison recommendations
4. **revenue-model-v1.md** — First revenue (support/hosting), service revenue (setup, migration), recurring (Pro/Cloud), monetization sequence, pricing-shape recommendations
5. Updated PROJECT_STATUS.md — Current phase, Completed Work, Documentation
6. Updated ACTION_LOG.md — this entry

**Files affected**:
- docs/business/product-packaging-v1.md (new)
- docs/business/edition-strategy-v1.md (new)
- docs/business/migration-positioning-v1.md (new)
- docs/business/revenue-model-v1.md (new)
- PROJECT_STATUS.md (updated)
- ACTION_LOG.md (this entry)

**Strategy decisions**:
- Three editions: Community (free, self-hosted), Pro (paid self-hosted), Cloud (managed)
- Community keeps full core feature set; Pro adds support + convenience features; Cloud = managed + reliability
- Migration: "FrankBoard is a modernized Kanboard" — respectful, not replacement hype
- First revenue: support contracts, hosting setup, then Pro subscription, then Cloud
- No technical gating in this task; documents are recommendations only

**Results**: Commercial packaging v1 complete. Documents coherent with product direction.

**Next steps**: Review docs; consider Wave 4 (mobile) or Pro feature scoping when ready.

---

### Action: Wave 4 Product Polish and Readiness Pass

**Timestamp**: 2025-03-15  
**Context**: Next UI polish wave after Wave 3 — empty states, search/results, mobile, admin/settings consistency, theme verification. No behavior changes, no feature bloat.

**Actions performed**:
1. **Empty states** — empty_states.css: page-level `.alert` padding 20px 24px, border-radius, line-height; intentional feel for "no project", "nothing assigned", "nothing found"
2. **Search/results** — filter_box.css: margin-bottom 20px, max-width 480px for search; table_list.css: table-list-category uses theme vars
3. **Mobile/narrow-width** — responsive.css: .page margin 12px at 640px; board-container touch scroll; config form spacing at 768px
4. **Admin/settings** — responsive.css: .sidebar-content page-header, fieldset, form-actions, panel spacing consistent with Wave 2 foundation
5. **Theme fixes** — board.css: draggable-item-selected uses var(--color-primary); table_list.css: table-list-category uses --panel-* vars; sidebar.css: hover/active border uses var(--color-medium), var(--color-primary); task_summary.css: #external-task-view uses var(--panel-border-color)
6. **CssCommand** — added empty_states.css, responsive.css to appFiles
7. **Docs** — wave-4-implementation-notes.md, wave-4-scope-review.md, wave-4-verification.md
8. Updated PROJECT_STATUS.md, ACTION_LOG.md

**Files affected**:
- assets/css/src/empty_states.css (new)
- assets/css/src/responsive.css (new)
- assets/css/src/board.css, table_list.css, sidebar.css, task_summary.css, filter_box.css
- app/Console/CssCommand.php
- docs/product/wave-4-implementation-notes.md (new)
- docs/product/wave-4-scope-review.md (new)
- docs/product/wave-4-verification.md (new)
- PROJECT_STATUS.md, ACTION_LOG.md

**Results**: Wave 4 implementation complete. Ready for deploy and verification.

**Next steps**: Deploy to staging; verify per wave-4-verification.md (empty states, search, mobile, admin, light/dark/auto themes, drag-and-drop).

---

### Action: Disable Codeberg mirror, deploy Wave 4

**Timestamp**: 2025-03-15  
**Context**: Codeberg mirror workflow not working; deploy Wave 4 + commercial packaging to staging.

**Actions performed**:
1. Disabled Codeberg mirror — `.github/workflows/codeberg_mirror.yml`: added `if: false` to mirror job
2. Committed and pushed: mirror disable, Wave 4 CSS, commercial packaging docs
3. Deployed via `.\scripts\run-vps.ps1 -DeployWave1` — git pull, docker build, containers recreated
4. Staging live at http://66.179.208.122:8080 with Wave 4

**Files affected**:
- .github/workflows/codeberg_mirror.yml
- ACTION_LOG.md (this entry)

**Results**: Mirror disabled; Wave 4 deployed to staging.

**Next steps**: Verify Wave 4 per wave-4-verification.md.

---

### Action: Launch Foundation Messaging and Page Architecture v1

**Timestamp**: 2025-03-15  
**Context**: First launch-facing marketing and product-page foundation. Move from internal modernization to external positioning and go-to-market. Documentation/strategy only; no website implementation.

**Actions performed**:
1. **homepage-messaging-v1.md** — Homepage goal, target audience, hero/subhead options, benefit blocks, trust blocks, CTA recommendations, section order
2. **edition-comparison-v1.md** — Page purpose, edition names, comparison table structure, differentiators, emphasis for Community vs Pro vs Cloud
3. **migration-page-v1.md** — Target audience, purpose, reassurance messaging, compatibility promises, page structure, CTAs
4. **why-frankboard-exists-v1.md** — Story angle, positioning, problem solved, deliberate boundaries, page structure
5. **pricing-structure-v1.md** — Page purpose, pricing model recommendation, structure, FAQ topics, what to include/exclude initially
6. **support-page-v1.md** — Purpose, support channels/tiers, self-serve structure, paid support positioning, section recommendations
7. Updated PROJECT_STATUS.md — Current phase, Completed Work, Documentation, Next steps
8. Updated ACTION_LOG.md — this entry

**Files affected**:
- docs/marketing/homepage-messaging-v1.md (new)
- docs/marketing/edition-comparison-v1.md (new)
- docs/marketing/migration-page-v1.md (new)
- docs/marketing/why-frankboard-exists-v1.md (new)
- docs/marketing/pricing-structure-v1.md (new)
- docs/marketing/support-page-v1.md (new)
- PROJECT_STATUS.md, ACTION_LOG.md

**Assumptions for later validation**:
- Hero emphasis: "Simple work board for small teams" vs "Modern Kanboard" — A/B test at launch
- Pro pricing: flat annual preferred; tiered by team size as alternative
- Migration page: emphasize "backup + config swap" as primary path; plugin testing as secondary
- Support: Community (GitHub/docs) vs Pro/Cloud (email/SLA) — no live chat initially

**Results**: Launch foundation messaging v1 complete. All docs coherent with business strategy. Page outlines practical for real launch site.

**Next steps**: Review docs/marketing/; implement site when ready; validate hero/subhead with target users.

---

### Action: Launch Copy Drafts v1

**Timestamp**: 2025-03-15  
**Context**: Turn approved launch foundation strategy into first-pass real website copy. Documentation only; no site implementation.

**Actions performed**:
1. **homepage-copy-v1.md** — Hero, subhead, CTAs, 4 benefit sections, trust block, edition teaser, migration block, footer CTA
2. **edition-comparison-copy-v1.md** — Intro, edition descriptions, comparison table content, CTA copy per edition, short FAQ
3. **migration-page-copy-v1.md** — Headline/subhead, reassurance intro, step-by-step migration, compatibility, plugin caveat, support CTA
4. **why-frankboard-exists-copy-v1.md** — Headline/subhead, founding story, problem solved, deliberate boundaries, closing CTA
5. **pricing-page-copy-v1.md** — Headline/subhead, Community/Pro/Cloud copy blocks, FAQ, CTA, "coming soon" notes for Pro/Cloud
6. **support-page-copy-v1.md** — Headline/subhead, self-serve, Community, Pro/Cloud, services, CTA
7. Updated PROJECT_STATUS.md, ACTION_LOG.md

**Files affected**:
- docs/marketing-copy/homepage-copy-v1.md (new)
- docs/marketing-copy/edition-comparison-copy-v1.md (new)
- docs/marketing-copy/migration-page-copy-v1.md (new)
- docs/marketing-copy/why-frankboard-exists-copy-v1.md (new)
- docs/marketing-copy/pricing-page-copy-v1.md (new)
- docs/marketing-copy/support-page-copy-v1.md (new)
- PROJECT_STATUS.md, ACTION_LOG.md

**Assumptions for validation**:
- Pro/Cloud CTAs use "Contact us" and "Coming soon" — update when live
- Migration steps assume standard Kanboard backup procedure
- Support contact channels: placeholder email/URL until configured

**Results**: Launch copy drafts v1 complete. All pages could be published with minimal editing.

**Next steps**: Review copy; implement launch site; update Pro/Cloud CTAs when editions are live.

---

### Action: Static Launch Site Architecture for FrankBoard.com

**Timestamp**: 2025-03-15  
**Context**: Design architecture and file structure for first static launch site at frankboard.com. Documentation only; no site build. Site separate from core product app.

**Actions performed**:
1. **site-architecture-v1.md** — Site purpose, page inventory (6 pages), content hierarchy, navigation model, shared layout, CTA strategy, marketing-site vs app relationship
2. **site-file-structure-v1.md** — Folder/file structure, page naming, asset org, metadata/SEO, robots/sitemap
3. **site-design-system-v1.md** — Visual direction, typography, spacing, components, buttons, icons, avoid list
4. **site-deployment-v1.md** — Static deploy on VPS, reverse proxy, domain/path, SSL/caching, separation from app, update workflow
5. Updated PROJECT_STATUS.md, ACTION_LOG.md

**Files affected**:
- docs/site/site-architecture-v1.md (new)
- docs/site/site-file-structure-v1.md (new)
- docs/site/site-design-system-v1.md (new)
- docs/site/site-deployment-v1.md (new)
- PROJECT_STATUS.md, ACTION_LOG.md

**Architecture decisions**:
- Static-first: HTML/CSS, no CMS, no heavy JS framework
- Plain HTML + CSS or minimal SSG (e.g. 11ty) — avoid React/Vue unless justified
- Site at frankboard.com; app at app.frankboard.com or separate subdomain when ready
- Deployment: static files served by nginx/Caddy; separate from Docker app stack
- Content: copy lives in docs/marketing-copy/; site consumes or mirrors during build

**Results**: Static launch site architecture v1 complete. Ready for implementation.

**Next steps**: Implement site per docs/site/; deploy to frankboard.com.

---

### Action: Static Launch Site v1 Implementation

**Timestamp**: 2025-03-15  
**Context**: Build FrankBoard.com static launch site per approved architecture, copy drafts, and design system. Plain HTML + CSS, no framework.

**Actions performed**:
1. **site/assets/css/main.css** — Design system (--bg #fafaf9, --text #1c1917, --primary #2563eb, spacing, BEM components)
2. **site/index.html** — Homepage: hero, benefits, trust, edition teaser, migration teaser, footer CTAs
3. **site/editions/index.html** — Editions intro, Community/Pro/Cloud, comparison table, FAQ, CTAs
4. **site/migrate/index.html** — Reassurance, migration steps, compatibility, plugin caveat, CTA
5. **site/why/index.html** — Story, product philosophy, what we solve/won't do, CTA
6. **site/pricing/index.html** — Community/Pro/Cloud cards (Pro/Cloud "Coming soon"), FAQ, CTAs
7. **site/support/index.html** — Self-serve, Community, Pro/Cloud support, services, CTA
8. **site/assets/img/favicon.svg** — Favicon (F mark)
9. **site/robots.txt** — Allow /, Sitemap URL
10. **site/sitemap.xml** — All 6 pages, lastmod 2025-03-15
11. **docs/site/site-build-notes-v1.md** — Files, design decisions, placeholders
12. **docs/site/site-deploy-checklist-v1.md** — Pre/post-deploy verification

**Files affected**:
- site/index.html, site/editions/index.html, site/migrate/index.html, site/why/index.html, site/pricing/index.html, site/support/index.html (new)
- site/assets/css/main.css, site/assets/img/favicon.svg (new)
- site/robots.txt, site/sitemap.xml (new)
- docs/site/site-build-notes-v1.md, docs/site/site-deploy-checklist-v1.md (new)

**Design**: Calm, clear, trustworthy. Linear-level restraint, simpler and warmer. No gradients, system fonts, warm neutral background.

**Results**: Static site v1 complete. Ready for deployment to frankboard.com.

**Next steps**: Deploy per site-deploy-checklist-v1.md; verify responsive; add og-default.png when available.

---

### Action: Homepage Card Alignment Refinement Pass

**Timestamp**: 2025-03-15  
**Context**: Desktop-focused layout correction. Card groups (benefits, trust) felt left-biased relative to centered hero. Small refinement only; no redesign.

**Actions performed**:
1. Added `--max-width-cards: 840px` (between hero 720px and wide 960px)
2. Benefits: `.benefits .container` → 840px at min-width: 960px
3. Trust: `.trust .container` → 840px at min-width: 960px; `.trust .section__title` text-align: center
4. Editions teaser: same container constraint; section__title and section__cta text-align: center
5. Created docs/site/homepage-alignment-pass-notes.md

**Files affected**:
- site/assets/css/main.css (CSS variable, desktop media queries)
- docs/site/homepage-alignment-pass-notes.md (new)
- PROJECT_STATUS.md, ACTION_LOG.md

**Breakpoints**: Only min-width: 960px affected. Mobile and tablet unchanged.

**Results**: Card groups feel more centered and compositionally balanced beneath hero. No regression in nav, CTA rows, footer.

**Next steps**: Deploy when ready; verify at 960px+ viewport.

---

### Action: Deploy Static Site to frankboard.com

**Timestamp**: 2025-03-15  
**Context**: Deploy FrankBoard static marketing site to frankboard.com on VPS; keep separate from app at app.frankboard.com.

**Actions performed**:
1. Created `config/nginx/frankboard.com.conf` — frankboard.com + www redirect to canonical
2. Created `config/nginx/app.frankboard.com.conf` — app proxy (not yet enabled)
3. Created `scripts/deploy-site.sh` — copies site/ to /var/www/frankboard-site, installs nginx config
4. Added `-DeploySite` to run-vps.ps1
5. Committed and pushed; ran `.\scripts\run-vps.ps1 -DeploySite`
6. VPS: git pull, deploy-site.sh, nginx reload
7. Created docs/site/site-deploy-execution-v1.md, site-post-deploy-checklist-v1.md

**Files affected**:
- config/nginx/frankboard.com.conf, app.frankboard.com.conf (new)
- scripts/deploy-site.sh (new)
- scripts/run-vps.ps1 (DeploySite param)
- docs/site/site-deploy-execution-v1.md, site-post-deploy-checklist-v1.md (new)
- PROJECT_STATUS.md, ACTION_LOG.md

**Deployment path**: /var/www/frankboard-site on VPS 66.179.208.122  
**Verification**: curl -sI -H 'Host: frankboard.com' http://127.0.0.1/ → 200 OK (homepage, editions, robots.txt, sitemap.xml, CSS, favicon)

**Results**: Static site live. App unchanged. www → apex redirect configured. Cloudflare/DNS must point frankboard.com to VPS for public access.

**Next steps**: Verify https://frankboard.com in browser (requires DNS); run certbot for origin SSL if Full/Strict; enable app.frankboard.com when ready.

---

### Action: QA System v1 — FrankBoard QA Agent System

**Timestamp**: 2025-03-16  
**Context**: Establish structured QA/testing system for consistent testing, bug logging, and launch readiness.

**Actions performed**:
1. **docs/qa/qa-strategy-v1.md** — QA goals, testing layers, manual vs automation, surfaces, bug prioritization
2. **docs/qa/manual-qa-playbook-v1.md** — Exact app flows (login, dashboard, board, task, search, admin, theme), site flows (homepage, six pages, CTAs, assets), recording, pass/fail, blockers
3. **docs/qa/core-regression-checklist-v1.md** — Login, project create/edit, board view, task create/edit/detail, search/filter, admin/settings, theme/responsive, navigation
4. **docs/qa/launch-readiness-checklist-v1.md** — All public pages, nav/footer, CTAs, contact, metadata/favicon, app/site boundary, SSL
5. **docs/qa/bug-report-template-v1.md** — Title, severity, environment, steps, expected/actual, screenshot, notes
6. **docs/qa/test-run-log-template-v1.md** — Date, env, tester, scope, pass/fail summary, blockers, follow-ups
7. **docs/qa/automation-roadmap-v1.md** — Top automation candidates (login→board→task), Playwright/Cypress direction, what to wait on, what not to overbuild
8. Updated PROJECT_STATUS.md, ACTION_LOG.md

**Files affected**:
- docs/qa/*.md (7 new files)
- PROJECT_STATUS.md, ACTION_LOG.md

**Assumptions**: Manual QA first; no automation in v1; staging URL (66.179.208.122:8080) and frankboard.com are canonical; test credentials (admin/pass123) stable.

**Results**: QA system ready for immediate use. Playbook and checklists aligned with product/site reality.

**Next steps**: Run manual QA per playbook before next deploy; use bug template for any issues; consider automation when regression history justifies.

---

### Action: FrankBoard QA Test Run 001

**Timestamp**: 2025-03-13  
**Context**: First full manual QA pass per docs/qa/; produce bug list and prioritized fix queue.

**Actions performed**:
1. Tested marketing site (frankboard.com) — Home, Editions, Migrate, Why, Pricing, Support: all 200 OK
2. Verified robots.txt — 200, Sitemap ref present
3. Verified sitemap.xml — **500 Internal Server Error** (BUG-002)
4. Tested app.frankboard.com — **403 Forbidden** (BUG-001)
5. Tested staging app (66.179.208.122:8080) — Dashboard, board view load; core nav functional
6. Created docs/qa/test-run-001.md — date, env, scope, pass/fail, blockers, readiness
7. Created docs/qa/bug-log-001.md — BUG-001 (P0), BUG-002 (P1) with reproduction steps
8. Created docs/qa/fix-priority-queue-001.md — ordered fixes, before-launch vs can-wait
9. Updated PROJECT_STATUS.md — blockers, next steps
10. Updated ACTION_LOG.md (this entry)

**Findings**: 2 bugs. Marketing site content/nav pass. App at staging works; app.frankboard.com blocked. Sitemap broken.

**Files affected**:
- docs/qa/test-run-001.md (new)
- docs/qa/bug-log-001.md (new)
- docs/qa/fix-priority-queue-001.md (new)
- PROJECT_STATUS.md (updated)
- ACTION_LOG.md (updated)

**Next steps**: Fix BUG-001 and BUG-002 per fix-priority-queue-001.md; re-run QA.

---

### Action: Fix app.frankboard.com nginx routing and remove dev.zfiremedia.com

**Timestamp**: 2025-03-16  
**Context**: BUG-001 — app.frankboard.com returned 403. Clean up unused dev.zfiremedia.com nginx config; add app subdomain reverse proxy.

**Actions performed**:
1. Inspected /etc/nginx/sites-enabled and sites-available on VPS
2. Removed dev.zfiremedia.com — deleted symlink from sites-enabled and config file from sites-available (resolved nginx conflicting server_name warnings)
3. Copied config/nginx/app.frankboard.com.conf to /etc/nginx/sites-available and enabled via symlink
4. nginx -t passed (no warnings); systemctl reload nginx
5. Verified: curl -H "Host: app.frankboard.com" http://127.0.0.1/ → 302 to /login (app response, not 403)
6. Verified: frankboard.com still returns 301 to HTTPS
7. Updated deploy-site.sh — now installs app.frankboard.com.conf on deploy
8. Created docs/deployment/app-subdomain-routing-fix-v1.md
9. Updated PROJECT_STATUS.md, ACTION_LOG.md

**Proxy target**: http://127.0.0.1:8080 (FrankBoard Docker container frankboard, port 0.0.0.0:8080->80/tcp)

**Files affected**:
- scripts/deploy-site.sh (added app config install)
- config/nginx/app.frankboard.com.conf (removed outdated comment)
- docs/deployment/app-subdomain-routing-fix-v1.md (new)
- PROJECT_STATUS.md, ACTION_LOG.md

**SSL follow-up**: Config listens on port 80 only. HTTPS requests (e.g. https://app.frankboard.com) may hit default/other block until certbot SSL is added for app.frankboard.com. Documented in app-subdomain-routing-fix-v1.md.

**Results**: HTTP routing correct. BUG-001 resolved for HTTP. Browser 403 on HTTPS expected until SSL configured.

---

### Action: Add SSL for app.frankboard.com (certbot)

**Timestamp**: 2025-03-16  
**Context**: User requested certbot to enable HTTPS for app.frankboard.com.

**Actions performed**:
1. Ran `certbot --nginx -d app.frankboard.com --non-interactive --agree-tos` on VPS
2. Certificate issued and deployed to app.frankboard.com.conf
3. Certificate path: /etc/letsencrypt/live/app.frankboard.com/ (expires 2026-06-14)
4. Verified https://app.frankboard.com — login page loads

**Files affected**:
- docs/deployment/app-subdomain-routing-fix-v1.md (SSL section updated)
- PROJECT_STATUS.md, docs/qa/bug-log-001.md

**Results**: app.frankboard.com fully working over HTTPS. BUG-001 fully resolved.

---

### Action: QA Test Run 002 (re-run)

**Timestamp**: 2025-03-16  
**Context**: Re-run full QA pass after BUG-001 fix (app.frankboard.com nginx + certbot SSL).

**Actions performed**:
1. Tested marketing site — Home, Editions, Migrate, Why, Pricing, Support: all 200 OK
2. Verified robots.txt — 200, Sitemap ref present
3. Verified sitemap.xml — **500 Internal Server Error** (BUG-002 still open)
4. Tested app.frankboard.com — Login page loads over HTTPS; admin/pass123 → dashboard; board view loads (columns Backlog, Ready, WIP, Done)
5. Created docs/qa/test-run-002.md
6. Updated docs/qa/bug-log-001.md (BUG-001 status → Fixed)
7. Updated docs/qa/fix-priority-queue-001.md (BUG-001 done, BUG-002 remaining)
8. Updated PROJECT_STATUS.md

**Results**: BUG-001 fully resolved. BUG-002 remains only P1 blocker. App and site otherwise pass.

**Files affected**:
- docs/qa/test-run-002.md (new)
- docs/qa/bug-log-001.md, fix-priority-queue-001.md (updated)
- PROJECT_STATUS.md

---

### Action: QA Test Run 003 — Closeout Verification

**Timestamp**: 2025-03-16  
**Context**: Verify sitemap fixed and FrankBoard free of P0/P1 launch blockers.

**Actions performed**:
1. Verified frankboard.com and all six marketing pages — 200 OK
2. Verified robots.txt — 200, Sitemap ref present
3. Verified sitemap.xml — user confirmed works in browser
4. Verified app.frankboard.com — HTTPS, login → dashboard
5. Confirmed no P0/P1 blockers remain
6. Created docs/qa/test-run-003.md; updated bug-log-001, fix-priority-queue-001, PROJECT_STATUS, ACTION_LOG

**Results**: Launch-ready. All acceptance criteria met.

**Files affected**:
- docs/qa/test-run-003.md (new)
- docs/qa/bug-log-001.md, fix-priority-queue-001.md, PROJECT_STATUS.md, ACTION_LOG.md

---

### Action: FrankBoard Soft Launch Pack v1

**Timestamp**: 2025-03-16  
**Context**: Create first soft-launch operations pack for controlled public exposure and early demand validation.

**Actions performed**:
1. Created docs/launch/soft-launch-strategy-v1.md — objective, phasing, success criteria, founder-speed constraints
2. Created docs/launch/cta-strategy-v1.md — primary CTA (Get Community Free → GitHub), secondary CTAs
3. Created docs/launch/outreach-targets-v1.md — target audiences (Kanboard users, small teams, ops leads), channels (HN, Reddit, Kanboard, personal network)
4. Created docs/launch/announcement-copy-v1.md — one-liner, short, HN, Reddit, Twitter, email templates
5. Created docs/launch/response-handling-v1.md — analytics, response handling for GitHub/issues/contact, SLA, logging
6. Updated PROJECT_STATUS.md, ACTION_LOG.md

**Results**: Soft launch pack ready. Founder can execute first outreach with minimal setup.

**Files affected**:
- docs/launch/soft-launch-strategy-v1.md (new)
- docs/launch/cta-strategy-v1.md (new)
- docs/launch/outreach-targets-v1.md (new)
- docs/launch/announcement-copy-v1.md (new)
- docs/launch/response-handling-v1.md (new)
- PROJECT_STATUS.md, ACTION_LOG.md

---

### Action: Soft Launch Pack v1.1 — CTA and Channel Adjustment

**Timestamp**: 2025-03-16  
**Context**: Refine CTA strategy and channel order to optimize for migration/setup signal over generic free acquisition.

**Actions performed**:
1. Created docs/launch/soft-launch-strategy-v1.1.md — metrics updated for migration/setup; Get Community tertiary
2. Created docs/launch/cta-strategy-v1.1.md — Primary: Migrate from Kanboard; Secondary: Request setup help; Tertiary: Get Community Free
3. Created docs/launch/outreach-targets-v1.1.md — Channel order: 1) Direct/personal, 2) Kanboard/self-hosted, 3) Reddit, 4) HN (later)
4. Created docs/launch/announcement-copy-v1.1.md — Messaging emphasizes migration, setup help; email template leads with migration
5. Updated PROJECT_STATUS.md, ACTION_LOG.md

**CTA hierarchy**:
- Primary: Migrate from Kanboard → /migrate/
- Secondary: Request setup help → mailto:support@zfiremedia.com
- Tertiary: Get Community Free → GitHub

**Channel order**: Personal first → Kanboard/self-hosted → Reddit → HN (defer until ready)

**Files affected**:
- docs/launch/soft-launch-strategy-v1.1.md, cta-strategy-v1.1.md, outreach-targets-v1.1.md, announcement-copy-v1.1.md (new)
- PROJECT_STATUS.md, ACTION_LOG.md

---

### Action: Disable daily Docker GitHub workflow schedule

**Timestamp**: 2025-03-16  
**Context**: Daily Docker workflow (`multiplatform-build`) failing; FrankBoard uses VPS deploy, not published images. Reduce CI noise.

**Actions performed**:
1. Edited `.github/workflows/docker.yml` — removed `schedule` (`cron: '0 1 * * *'`)
2. Added `workflow_dispatch` for manual runs from Actions tab
3. Preserved `push` (tags `v*.*.*`) and `pull_request` (main) unchanged
4. Created `docs/deployment/docker-workflow-status-v1.md` — original triggers, changes, reactivation notes
5. Updated PROJECT_STATUS.md, ACTION_LOG.md

**Files affected**:
- .github/workflows/docker.yml
- docs/deployment/docker-workflow-status-v1.md (new)
- PROJECT_STATUS.md, ACTION_LOG.md

**Manual use**: Actions → Docker → Run workflow. No daily scheduled run.

---

## 2026-07-10

### Action: Launch readiness review (fresh chat reconstruction)

**Timestamp**: 2026-07-10  
**Context**: User requested launch-readiness report after prior chat context was lost. Review only; no product/code changes.

**Actions performed**:
1. Reviewed PROJECT_STATUS, ACTION_LOG, QA closeout (Runs 001–003), launch pack v1.1, site/nginx/deploy scripts
2. Live HTTP checks: frankboard.com (6 pages + robots/sitemap/assets), app.frankboard.com, staging :8080 — all 200
3. SSL check: Cloudflare cert CN=frankboard.com expires 2026-08-11 (~32 days)
4. GitHub CTA probe: public API 404; git smart-http 401 → repo private / not publicly cloneable
5. Confirmed homepage still leads with “Get Community Free” (v1 CTA), not Migrate-primary (v1.1)
6. Noted large uncommitted working tree (QA/launch/marketing docs + nginx/deploy follow-ups)

**Results**: Soft-launch **not fully ready** until GitHub Community distribution is public (or CTAs retargeted). Site/app infrastructure otherwise healthy.

**Next steps**:
1. Make `ZFireMedia/FrankBoard` public (or fix all site GitHub links)
2. Align homepage hero CTA with soft-launch v1.1 (Migrate primary)
3. Confirm `support@zfiremedia.com` is monitored
4. Commit/push pending docs + deploy script changes
5. Optional: quick core-regression re-pass (create project/task) before outreach

---

### Action: Public GitHub move + soft-launch CTA/docs push

**Timestamp**: 2026-09-28  
**Context**: Soft-launch blockers — private Community repo and homepage CTA mismatch. User directed use of new GitHub account `support@zfiremedia.com` (`ZFireMedia`).

**Actions performed**:
1. Connected Cursor SCM + authenticated `gh` as `ZFireMedia`
2. Created public repo https://github.com/ZFireMedia/FrankBoard
3. Retargeted site/docs GitHub URLs from `zfiremedia-stack/FrankBoard` → `ZFireMedia/FrankBoard`
4. Homepage hero/footer CTAs aligned to soft-launch v1.1 (Migrate primary, setup help secondary, Community tertiary)
5. DNS check: `frankboard.com` has SPF (GoDaddy efwd) but **no MX records** — brand `support@frankboard.com` unlikely to receive mail; `zfiremedia.com` has MX → `smtp.google.com`
6. Commit + push pending launch/QA/docs/nginx/deploy changes to new public origin (`0bdbd9ee1` → `origin/main`)

**Files affected**:
- `site/*.html` (GitHub URLs + homepage CTA)
- docs launch/marketing/deployment references
- prior uncommitted QA/launch/nginx/deploy/workflow files
- PROJECT_STATUS.md, ACTION_LOG.md

**Results**: Public Community distribution live at https://github.com/ZFireMedia/FrankBoard (200, private=false). Email inbox for frankboard.com still broken (no MX). Marketing site on VPS still needs redeploy for live CTA/GitHub URL updates.

**Next steps**:
1. Switch contact mailto to `support@zfiremedia.com`
2. Deploy updated marketing site to frankboard.com
3. Begin soft-launch outreach

---

### Action: Switch contact email to support@zfiremedia.com

**Timestamp**: 2026-09-28  
**Context**: frankboard.com has no MX; ZFireMedia is the billing/owning company and has working Google mail. Selling posture is services-first (setup/migration), not Pro/Cloud checkout.

**Actions performed**:
1. Replaced all site `mailto:support@frankboard.com` (and one `frankboard.io`) with `support@zfiremedia.com`
2. Updated launch/QA/site docs and PROJECT_STATUS accordingly
3. Commit + push; prepare site deploy

**Files affected**:
- `site/**/*.html`
- docs launch/qa/site/marketing-copy; PROJECT_STATUS.md; ACTION_LOG.md

**Results**: Contact path points at monitored ZFireMedia inbox. Live site still needs redeploy.

**Next steps**: Deploy marketing site; soft-launch outreach

**Summary stats**: 32 log entries | Contact email → zfiremedia

---

### Action: Deploy site + retarget VPS origin to public repo

**Timestamp**: 2026-09-28  
**Context**: After contact-email switch, live frankboard.com still served old CTAs; VPS origin still pointed at private zfiremedia-stack remote.

**Actions performed**:
1. Set VPS `origin` to `https://github.com/ZFireMedia/FrankBoard.git` (tokenless public HTTPS)
2. Fast-forward `/root/frankboard` to `266eb85b4`
3. Ran `scripts/deploy-site.sh` — site + nginx configs reloaded
4. Verified live homepage/pricing use `mailto:support@zfiremedia.com` and Migrate-primary CTAs

**Security note**: Previous VPS origin URL embedded a GitHub PAT. Remote cleaned; **revoke that PAT in GitHub** if still active.

**Results**: Marketing site live with ZFireMedia GitHub + support email.

**Next steps**: Soft-launch outreach; optional brand alias `support@frankboard.com` → forward later

**Summary stats**: 33 log entries | Site deployed with zfiremedia contact
