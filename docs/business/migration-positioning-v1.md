# FrankBoard Migration and Positioning v1

**Date**: 2025-03-15  
**Status**: Strategy document  
**Scope**: How FrankBoard positions relative to Kanboard; migration promise; trust language.

---

## Positioning Relative to Kanboard

FrankBoard is a **modernization fork** of Kanboard. It is not a replacement, competitor, or hostile fork. The relationship should be framed as:

| Message | Rationale |
|---------|-----------|
| **"Built on Kanboard"** | Accurate; preserves compatibility and plugin ecosystem |
| **"Modernized for small teams"** | Clear value add without denigrating upstream |
| **"Same core, better UX"** | Honest; no claim to rewrite or reimagine |

### Language to Use

- **"FrankBoard is a modernization fork of Kanboard"**
- **"We preserve Kanboard's simplicity and self-hosted roots"**
- **"Data and plugins stay compatible"**

### Language to Avoid

- **"Kanboard replacement"** — implies displacement
- **"Better than Kanboard"** — divisive; "more polished" is sufficient
- **"The new Kanboard"** — confuses identity

---

## Migration Promise

### For Existing Kanboard Users

1. **Data compatibility**: Same database schema (SQLite, MySQL, PostgreSQL). Migration is standard Kanboard procedure: backup, point FrankBoard at DB, verify.
2. **Plugin compatibility**: FrankBoard uses the Kanboard plugin API. Most plugins should work; test before production migration.
3. **Config continuity**: `config.php` and `data/config.php` patterns carry over. Environment variables align with Kanboard where applicable.
4. **No lock-in**: Export and migration back to Kanboard remain possible. Data is standard SQL.

### Migration Promise (Explicit Statement)

> **"If you run Kanboard today, you can move to FrankBoard with a backup and config swap. Your data, plugins, and workflows stay intact. You can also move back if needed."**

### What We Don't Promise

- Automatic one-click migration (manual backup/restore required)
- 100% plugin compatibility (we test common plugins; edge cases may differ)
- Upstream feature parity forever (we may diverge intentionally over time)

---

## Compatibility Guidance

| Component | Compatibility | Notes |
|-----------|---------------|-------|
| Database | Full | Same schema; PostgreSQL preferred |
| Plugins | High | Same API; validate per plugin |
| Config | High | `config.php`, env vars align |
| Themes | Partial | FrankBoard uses its own CSS variables |
| API | Full | Kanboard REST API preserved |

---

## Trust and Continuity Language

### For Community Users

- **"FrankBoard is open and self-hosted. Your data stays where you put it."**
- **"Community edition remains fully functional. No forced upgrades or paywalls for core features."**

### For Pro/Cloud Prospects

- **"Pro gives you commercial use rights and support. Same product, same deployment — plus assurance."**
- **"Cloud is for teams that want zero hosting. We run it; you use it."**

### For Kanboard Users Considering Migration

- **"We don't fork and run. We maintain compatibility and respect the work Kanboard has done."**
- **"Migration is reversible. Your data isn't locked into FrankBoard."**

---

## Comparison Page Recommendations

When creating a FrankBoard vs Kanboard comparison:

1. **Be factual**: List differences (UI polish, deployment defaults, commercial path) without hype.
2. **Acknowledge Kanboard**: Credit upstream; link to Kanboard docs and repo.
3. **Use neutral tone**: "FrankBoard adds …" not "FrankBoard fixes …"
4. **Focus on fit**: "For teams that want …" rather than "Kanboard lacks …"

### Suggested Comparison Structure

| Aspect | Kanboard | FrankBoard |
|--------|----------|------------|
| Core | Boards, tasks, swimlanes | Same |
| UI | Stock Kanboard | Modernized (typography, modals, board) |
| Deployment | Self-hosted, various | Docker + PostgreSQL default |
| Commercial | N/A | Pro (self-hosted), Cloud (managed) |
| Support | Community | Community; Pro/Cloud: paid support |
| Plugins | Kanboard API | Same API |

---

## Summary

FrankBoard should position itself as a **friendly, compatible evolution** of Kanboard—not a replacement. The migration promise is practical and reversible. Trust language emphasizes data ownership, compatibility, and optional commercial paths.
