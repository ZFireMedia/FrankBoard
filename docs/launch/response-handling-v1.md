# FrankBoard Response Handling v1

**Date**: 2025-03-16  
**Scope**: Lightweight analytics and response-handling plan for soft launch.

---

## Analytics (Minimal)

### What to Track

| Item | How | Frequency |
|------|-----|-----------|
| GitHub stars | Manual or GitHub API | Weekly |
| GitHub clones / traffic | GitHub repo insights | Weekly |
| GitHub issues / discussions | Email notifications; triage | As received |
| Contact (mailto) | Inbox | As received |
| Site traffic | Optional: Plausible, Fathom, or Cloudflare Analytics | If configured, weekly |

### Recommendation

- **Phase 1**: Rely on GitHub metrics + inbox. No need to add analytics until you have traffic to measure.
- **If adding**: Use privacy-friendly, low-friction option (Plausible, Fathom). Avoid heavy Google Analytics setup for now.

---

## Response Handling

### GitHub Issues

| Type | Action |
|------|--------|
| Bug report | Triage within 48h. Confirm, label, acknowledge. |
| Feature request | Acknowledge. Add to backlog or explain why not now. |
| Question | Answer directly. If common, add to docs or FAQ. |
| Spam / off-topic | Close with brief note. |

**Tone**: Helpful, concise. No corporate speak.

### GitHub Discussions

| Type | Action |
|------|--------|
| Question | Answer within 2–3 days. |
| Feedback | Thank them. Ask clarifying questions if useful. |
| "How do I…" | Point to docs or migration guide. |

### Contact (mailto:support@frankboard.com)

| Type | Action |
|------|--------|
| Pro/Cloud interest | Reply within 48h. Capture: use case, team size, timeline. Add to waitlist. |
| Migration help | Reply. Offer migration assistance if scope is clear. |
| General question | Answer directly. |
| Sales / spam | Archive. |

### Social / Channel Comments

| Channel | Action |
|---------|--------|
| HN | Reply to top-level comments. Be substantive. Don't argue. |
| Reddit | Same. Answer questions, thank feedback. |
| Twitter | Like, reply to genuine engagement. Don't chase every mention. |

---

## Response SLA (Founder-Speed)

| Channel | Target |
|---------|--------|
| GitHub issues | 48h acknowledgment |
| Contact form / mailto | 48h first reply |
| HN / Reddit comments | Same day when possible; next day acceptable |
| Discussions | 2–3 days |

If you can't meet this, say so in an autoresponder or repo README. Under-promise.

---

## Logging (Lightweight)

Keep a simple log:
- Date, channel, type (issue / contact / comment)
- Summary of inquiry
- Action taken
- Follow-up if any

Format: Markdown in `docs/launch/response-log.md` or a spreadsheet. Purpose: learn patterns for Phase 2.

---

## Escalation

None for Phase 1. Founder handles everything. If volume exceeds capacity, prioritize:
1. Bugs (product integrity)
2. Pro/Cloud interest (revenue signal)
3. Migration help (conversion)
4. General questions
