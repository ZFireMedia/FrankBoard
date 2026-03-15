# FrankBoard Revenue Model v1

**Date**: 2025-03-15  
**Status**: Strategy document  
**Scope**: First revenue paths; no implementation of billing or licensing yet.

---

## Likely First Revenue Sources

| Source | Type | Effort to enable | Realistic timeline |
|--------|------|------------------|--------------------|
| **Pro self-hosted license** | Recurring or perpetual + maintenance | Medium | First paid offering |
| **Cloud subscription** | Recurring | High (infra, billing) | After Pro validated |
| **Support / consulting** | Project-based | Low | Can start immediately |
| **Migration assistance** | One-time | Low | Complementary to Pro |

---

## Service Revenue Opportunities

| Service | Description | Price shape |
|---------|-------------|-------------|
| **Migration assistance** | Help moving from Kanboard or another tool to FrankBoard | Fixed fee or hourly |
| **Deployment setup** | VPS setup, Docker config, reverse proxy | Fixed fee |
| **Customization** | Theme tweaks, plugin configuration | Hourly or fixed |
| **Training** | Team onboarding, admin training | Per-session or fixed |

Service revenue is **non-recurring** but can fund early operations and validate demand before building subscription infrastructure.

---

## Recurring Revenue Opportunities

| Offering | Description | Price shape |
|----------|-------------|-------------|
| **Pro (self-hosted)** | Commercial license + support | Annual or monthly subscription |
| **Cloud** | Managed hosting | Per-seat or tiered monthly |
| **Support retainer** | Ongoing support SLA | Monthly retainer |

Recurring revenue requires:
- License/entitlement mechanism (later phase)
- Billing system (Stripe, Paddle, etc.)
- Support capacity (for Pro/Cloud)

---

## Recommended Monetization Sequence

1. **Phase 0 (current)**: Community only. No paid offerings. Build awareness, validate UI modernization.

2. **Phase 1**: **Pro self-hosted**
   - Introduce Pro as "Community + commercial license + support"
   - Manual license issuance (no automated gating)
   - Simple pricing: annual or one-time + optional support tier
   - Target: 5–20 paying teams in first 12 months

3. **Phase 2**: **Support and services**
   - Offer migration assistance, deployment setup, training
   - Project-based; no recurring billing required
   - Validates willingness to pay; informs Pro/Cloud feature asks

4. **Phase 3**: **Cloud**
   - After Pro and support are stable
   - Requires: managed infra, backups, billing automation
   - Higher operational lift; defer until Pro validates demand

---

## Pricing-Shape Recommendations

### Pro (Self-Hosted)

- **Structure**: Flat annual or tiered by team size (e.g., 1–5, 6–15, 16+)
- **Not**: Per-seat per month (adds friction for self-hosted)
- **Consider**: Perpetual license + annual maintenance (optional updates/support)
- **Avoid**: Complex tiers; keep 2–3 options max

### Cloud

- **Structure**: Per-seat monthly or tiered (e.g., 5 seats, 10 seats, 25 seats)
- **Consider**: Free tier (1–2 users, limited projects) for trial
- **Align**: With typical small-team sizes (2–10)

### Services

- **Structure**: Fixed fee for discrete tasks (migration, setup); hourly for open-ended work
- **Transparent**: Publish ranges or "starting at" to reduce friction

---

## Constraints and Safeguards

- **Community remains viable**: No feature removal from Community to force upgrades
- **No bait-and-switch**: Pro/Cloud value is support + license + (for Cloud) hosting — not locked features
- **Match team size**: Revenue model should be realistic for 1–3 person operation initially
- **Defer complexity**: Automated billing, usage metering, and enterprise contracts come later

---

## Summary

First revenue should come from **Pro self-hosted** (manual licensing) and **services** (migration, deployment). Cloud follows once Pro and support are proven. Pricing should stay simple: flat or tiered, annual where possible for self-hosted. No technical gating in this phase—strategy and packaging only.
