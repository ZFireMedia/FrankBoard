# Docker GitHub Workflow Status v1

**Date**: 2025-03-16  
**Workflow file**: `.github/workflows/docker.yml`  
**Workflow name in GitHub**: Docker

---

## Original Triggers

| Trigger | Behavior |
|---------|----------|
| `schedule` | `cron: '0 1 * * *'` — daily at 01:00 UTC |
| `push` | Tags matching `v*.*.*` |
| `pull_request` | To `main` |

**Jobs**:
- `test-image-build` — only on pull requests (build, no push)
- `multiplatform-build` — on non–pull-request events (schedule, tag pushes), multi-platform build and push to registries

---

## What Changed

1. **Removed** the `schedule` trigger entirely so the workflow no longer runs daily.
2. **Added** `workflow_dispatch` so the workflow can be run manually from the Actions tab when needed.

**Unchanged**: `push` (tags `v*.*.*`) and `pull_request` (to `main`) — release and PR validation behavior preserved.

---

## Manual Execution

**Yes.** Use **Actions → Docker → Run workflow** to trigger a full run on demand.

---

## Why Not Required for Launch (FrankBoard)

FrankBoard is deployed from the VPS path (`git pull`, `scripts/deploy-wave1.sh`, Docker Compose on the host). Published multi-platform images to Docker Hub / GHCR / Quay are **not** part of the current launch or day-to-day operations. The upstream Kanboard-oriented `multiplatform-build` job was failing (likely secrets/registry setup) and only added **noise** via the daily schedule.

---

## Future Reactivation

If you want automated nightly or scheduled image builds again:

1. Edit `.github/workflows/docker.yml` and restore a `schedule` block, for example:
   ```yaml
   schedule:
     - cron: '0 1 * * *'
   ```
2. Ensure `DOCKERHUB_*`, `QUAY_*`, and registry permissions are configured and the image names match your org (workflow still references `kanboard` image names from upstream).

Until then, rely on **workflow_dispatch** or tag pushes for registry builds, and VPS deploy for production.
