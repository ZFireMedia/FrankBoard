# FrankBoard Edition Strategy v1

**Date**: 2025-03-15  
**Status**: Strategy document  
**Scope**: Community, Pro, and Cloud edition boundaries.

---

## Overview

FrankBoard will offer three editions aligned with delivery model and support level:

1. **Community Edition** — Free, self-hosted, full core features
2. **Pro Edition** — Paid, self-hosted, commercial use + support
3. **Cloud Edition** — Paid, managed SaaS, no hosting required

The boundary between editions is defined by **support**, **commercial use rights**, and **hosting responsibility**, not by feature gating. All core board/task functionality remains available in Community.

---

## Community Edition

**Delivery**: Self-hosted (Docker, VPS, bare metal)  
**Price**: Free  
**Target**: Individuals, hobby projects, small teams, evaluation

### Included

- All core work board features (boards, tasks, swimlanes, columns, categories, tags)
- Modernized UI (Wave 1–3: typography, modals, forms, board, task detail)
- Plugin compatibility (Kanboard plugin API)
- Data migration from Kanboard (SQLite, MySQL, PostgreSQL)
- Community support (GitHub issues, docs, community channels)
- Unlimited projects, users, tasks

### Restrictions

- No commercial support SLA
- No formal commercial use license (see license terms)
- Community-best-effort updates and security patches

### What Stays Free

- Core product functionality
- Self-hosting and deployment flexibility
- Plugin ecosystem access
- Documentation and community resources

---

## Pro Edition

**Delivery**: Self-hosted (same deployment model as Community)  
**Price**: Paid (subscription or perpetual + maintenance)  
**Target**: Teams with commercial use, need for support, or formal licensing

### Differentiators vs Community

| Aspect | Community | Pro |
|-------|-----------|-----|
| License | OSS / evaluation | Commercial use license |
| Support | Community best-effort | Priority support, SLA |
| Updates | Community release cadence | Priority security/update path |
| Commercial use | Evaluation / non-commercial | Explicit commercial rights |

### Pro-Specific (Future Candidates)

- **Support**: Email support, response-time SLA, incident handling
- **Updates**: Priority access to patches, early access to releases
- **Assurance**: Commercial indemnity, formal license terms

### What Remains in Both Community and Pro

- Same feature set for boards, tasks, and core workflows
- Same deployment model (self-hosted)
- Same plugin compatibility

---

## Cloud Edition

**Delivery**: Managed SaaS (FrankBoard-hosted)  
**Price**: Paid (subscription, per-seat or per-project)  
**Target**: Teams that prefer zero hosting, backups, and maintenance

### Differentiators vs Pro

| Aspect | Pro (self-hosted) | Cloud |
|-------|-------------------|-------|
| Hosting | Customer-owned | FrankBoard-managed |
| Maintenance | Customer | FrankBoard |
| Backups | Customer | Included |
| Upgrades | Customer-initiated | Managed |

### Cloud-Only Considerations

- **Managed infrastructure**: Backups, uptime, scaling
- **Simplified onboarding**: No Docker or VPS setup
- **Billing**: Recurring subscription; per-seat or tiered pricing

### What Stays Consistent Across All Editions

- Same core application
- Same board/task UX
- Same API (where exposed)

---

## Recommended Feature Boundaries

| Capability | Community | Pro | Cloud |
|------------|-----------|-----|-------|
| Boards, tasks, swimlanes | ✓ | ✓ | ✓ |
| Plugins | ✓ | ✓ | ✓ |
| Self-hosting | ✓ | ✓ | — |
| Commercial use license | — | ✓ | ✓ |
| Priority support | — | ✓ | ✓ |
| Managed hosting | — | — | ✓ |
| Backups | Customer | Customer | Included |

---

## What Should Remain Free

- **Core features**: No feature gates on board, task, or workflow functionality
- **Self-hosting**: Community remains fully self-hostable
- **Plugins**: Plugin API and ecosystem access
- **Data ownership**: Export and migration paths in all editions

---

## What Should Be Paid

- **Commercial use**: Explicit license for commercial deployment (Pro, Cloud)
- **Support**: SLA-backed, priority support (Pro, Cloud)
- **Managed hosting**: Cloud Edition subscription
- **Future premium add-ons**: Optional modules (e.g., advanced reporting) — only if clearly additive

---

## What Should Be Cloud-Only

- **Managed hosting**: By definition, Cloud = FrankBoard-hosted
- **Built-in backups/restore**: When part of Cloud infrastructure
- **Simplified billing**: Subscription tied to Cloud delivery

---

## Implementation Notes

- **No technical gating yet**: Edition strategy is documentation-only. No license checks, feature flags, or paywalls in this phase.
- **Realistic scope**: Pro and Cloud require operational capacity (support, infra). Launch sequence should match team size. See [revenue-model-v1.md](revenue-model-v1.md).
