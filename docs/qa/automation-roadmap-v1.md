# FrankBoard QA Automation Roadmap v1

**Date**: 2025-03-16  
**Status**: Planning  
**Scope**: Prioritized automation candidates; no implementation in v1.

---

## Top Candidate Flows for Automation

| Rank | Flow | Rationale | Effort (est.) |
|------|------|----------|---------------|
| 1 | Login → Dashboard | Blocks everything; simple; high regression risk | Low |
| 2 | Login → Board load | Core surface; catches routing and data issues | Low |
| 3 | Login → Task create → appears on board | Critical path; catches save/data bugs | Medium |
| 4 | Marketing site homepage + nav links | Quick smoke; catches site deploy breaks | Low |
| 5 | Login → Search → results | Validates search; moderate complexity | Medium |

---

## Suggested Tooling Direction

| Option | Pros | Cons |
|--------|------|------|
| **Playwright** | Fast, modern, multi-browser, good API | New dependency |
| **Cypress** | Popular, good DX | Heavier; some quirks |
| **Selenium + pytest** | Mature, Python ecosystem | More boilerplate |
| **Simple curl/HTTP** | No browser; smoke only | Limited coverage |

**Recommendation**: Playwright or Cypress for E2E when automation starts. Start with one flow (login → board) before expanding.

---

## What Should Wait

- Full test suite before product stability
- CI integration before manual process is solid
- Visual regression (screenshot diff) before design is stable
- Performance testing before scale matters
- Mobile-specific automation before mobile is validated manually

---

## What Should Never Be Overbuilt Early

- Complex page object models
- Custom test framework
- Hundreds of tests
- Tests that require constant maintenance
- Tests for theoretical edge cases over real user flows

---

## Implementation Sequence (Future)

1. **Phase 1**: Single smoke — login → dashboard loads. Run locally.
2. **Phase 2**: Add board load, task create. Still local.
3. **Phase 3**: Add to CI (e.g. GitHub Actions) on PR or nightly.
4. **Phase 4**: Marketing site smoke (homepage + nav HTTP checks).
5. **Phase 5**: Expand coverage only as regression history justifies.

---

## Assumptions

- Staging URL and test credentials remain stable
- App and site structure do not change drastically
- No SPA rewrite in near term (Kanboard is server-rendered)
- Single tester/operator initially; scale when needed
