# FrankBoard QA Strategy v1

**Date**: 2025-03-16
**Status**: Active
**Scope**: Manual-first QA system; lightweight automation roadmap.

---

## QA Goals

1. **Consistent manual testing** — Repeatable flows before any release or deploy.
2. **Regression protection** — Core app flows must pass after UI/config changes.
3. **Clear bug logging** — Standard format so issues are actionable.
4. **Launch readiness** — Marketing site and app boundaries verified before wider use.
5. **Automation direction** — Identify high-value, low-effort automation targets.

---

## Testing Layers

| Layer | Scope | Manual / Automation |
|-------|-------|---------------------|
| **App core regression** | Login, projects, board, tasks, search, admin | Manual now; automate later |
| **Marketing site** | All six pages, nav, CTAs, assets | Manual now |
| **Launch readiness** | Combined app + site + SSL, contact correctness | Manual before launch |
| **E2E critical path** | Login → create task → view board | Future automation candidate |

---

## Manual vs Future Automation

- **Now**: All testing is manual. Use playbook and checklists. Log results.
- **Later**: Automate login → board → task create (highest ROI). See `automation-roadmap-v1.md`.
- **Do not** build a full framework or CI pipeline in v1.

---

## Surfaces That Matter Most

1. **Login** — Blocks everything if broken.
2. **Board view** — Core product surface.
3. **Task create/edit** — Critical workflow.
4. **Marketing site homepage + nav** — First impression.
5. **CTAs** — GitHub, mailto, internal links must work.

---

## Bug Prioritization

| Severity | Definition | Response |
|----------|------------|----------|
| **P0** | Blocks core use (login, board load, task save) | Fix immediately |
| **P1** | Major flow broken (search, project create, key nav) | Fix before next deploy |
| **P2** | Cosmetic or minor (styling, edge case) | Schedule |
| **P3** | Nice-to-have | Backlog |
