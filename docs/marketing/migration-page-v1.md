# FrankBoard Migration Page v1

**Date**: 2025-03-15  
**Status**: Strategy document  
**Scope**: Page structure for Kanboard users considering FrankBoard; documentation only.

---

## Target Audience

- **Primary**: Existing Kanboard users (self-hosted, any scale)
- **Secondary**: Teams evaluating Kanboard vs FrankBoard before first deployment

---

## Migration Page Purpose

1. **Reassure** — Migration is practical and reversible
2. **Set expectations** — What works, what to verify
3. **Guide** — Steps, compatibility notes, resources
4. **Reduce friction** — Clear path from Kanboard to FrankBoard

---

## Reassurance Messaging

| Message | Purpose |
|---------|---------|
| "Your data, plugins, and workflows stay intact" | Reduce fear of loss |
| "Migration is reversible" | Emphasize no lock-in |
| "Same database schema" | Technical confidence |
| "We preserve Kanboard's simplicity" | Respect, compatibility |
| "Backup first — we'll walk you through it" | Safety, clarity |

### Suggested Lead Paragraph

> **Moving from Kanboard to FrankBoard is straightforward.** FrankBoard uses the same database schema and plugin API. You backup your data, point FrankBoard at your database, and verify. You can also migrate back if needed — your data isn't locked in.

---

## Compatibility and Migration Promises We Can Support

| Promise | Supported | Notes |
|---------|-----------|-------|
| Same DB schema (SQLite, MySQL, PostgreSQL) | ✓ | Standard Kanboard migration procedure |
| Plugin compatibility | ✓ with caveats | Same API; validate per plugin |
| Config continuity | ✓ | config.php, env vars align |
| Data export / migration back | ✓ | Standard SQL export |
| One-click automated migration | ✗ | Manual backup/restore required |
| 100% plugin guarantee | ✗ | Test common plugins; edge cases may differ |
| Upstream feature parity forever | ✗ | May diverge intentionally |

---

## Suggested Page Structure

1. **Hero** — "Migrate from Kanboard" + one-line reassurance
2. **Overview** — 3–4 bullet promise (data intact, reversible, same schema, plugins)
3. **Steps** — Numbered migration steps (backup, config, point at DB, verify)
4. **Compatibility table** — DB, plugins, config (as in migration-positioning-v1.md)
5. **Plugins** — "Test your plugins; most work; we document known compatibility"
6. **Reverting** — "You can move back to Kanboard with a restore"
7. **Support** — "Need help? Migration assistance is available" (if offering services)
8. **CTA** — Download Community, Get migration assistance

---

## CTA Recommendations

| CTA | Placement | Audience |
|-----|-----------|----------|
| **Get Community** | Hero, end of steps | Self-service migrators |
| **Migration assistance** | After steps, support section | Teams wanting help |
| **Compare FrankBoard vs Kanboard** | Sidebar or mid-page | Evaluators |

---

## Language to Avoid

- "Upgrade" (implies Kanboard is inferior)
- "Replace Kanboard"
- "Seamless" or "zero-downtime" (unless explicitly supported)
- Promises about untested plugins or configs
