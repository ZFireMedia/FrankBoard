# FrankBoard Product Packaging v1

**Date**: 2025-03-15  
**Status**: Strategy document  
**Scope**: Commercial packaging and positioning — no technical gating or code changes.

---

## Product Summary

FrankBoard is a modernized, Kanboard-based work board product for small teams. It preserves the simplicity, self-hosting, and low operational overhead of Kanboard while delivering a cleaner, more consistent UI and a path to commercial editions (Community, Pro, Cloud). The product targets teams who want a practical work board without enterprise complexity.

---

## Target Users

| Segment | Description | Primary need |
|---------|--------------|--------------|
| **Small teams (2–10)** | Startups, agencies, remote pods | Simple boards, low friction, self-hosted control |
| **Kanboard users** | Existing Kanboard installs | Continuity, better UX, optional paid support |
| **Ops/solopreneurs** | Individuals managing multiple boards | Reliability, low maintenance, Docker-first deployment |
| **Privacy-conscious orgs** | Teams requiring data on-prem | Self-hosted, no vendor lock-in |

FrankBoard is **not** for:
- Large enterprises expecting SSO, audit trails, and 24/7 SLA
- Teams needing Jira-level customization (custom fields, complex workflows)
- Organizations wanting AI-first or automation-heavy tooling

---

## Product Editions Overview

| Edition | Delivery | Primary use case |
|---------|----------|------------------|
| **Community** | Free, self-hosted | Full-featured work board; individuals and small teams |
| **Pro** | Paid, self-hosted | Teams wanting support, priority updates, commercial use |
| **Cloud** | Paid, managed SaaS | Teams that prefer no hosting burden |

See [edition-strategy-v1.md](edition-strategy-v1.md) for feature boundaries and migration paths.

---

## Core Value Proposition

**"A modern work board for small teams — simple to run, straightforward to use."**

- **Modern UI**: Clean typography, consistent spacing, light/dark themes, improved board and task layouts.
- **Self-hosted first**: Your data, your infra. Docker + PostgreSQL out of the box.
- **Kanboard compatibility**: Built on Kanboard; plugin ecosystem, data migration paths preserved.
- **Practical evolution**: Incremental improvement, no bloat. Avoids Jira-style feature creep.

---

## What FrankBoard Is

- A **modernization fork** of Kanboard with UI polish and deployment improvements
- **Simple** — boards, tasks, swimlanes, columns; no complex workflows
- **Self-hosted friendly** — Docker Compose, VPS deployment, PostgreSQL
- **Commercially sustainable** — clear path from Community to Pro to Cloud
- **Respectful of upstream** — open, compatible, migration-friendly

---

## What FrankBoard Is Not

- **Not a Jira replacement** — no enterprise SSO, audit trails, or complex customization
- **Not an AI-first product** — no AI-generated tasks or automation emphasis
- **Not a closed platform** — community edition remains fully functional
- **Not a SaaS-only product** — self-hosted Pro remains a first-class option

---

## Positioning Summary

FrankBoard positions between "bare Kanboard" and "enterprise PM tools." It targets teams that want:
- More polished UX than stock Kanboard
- Less complexity than Jira, Asana, or Monday
- Control over hosting and data
- A clear commercial path when they need support or managed hosting
