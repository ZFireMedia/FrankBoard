# Wave 2 Scope Review

**Date**: 2025-03-15  
**Purpose**: Document what was in/out of scope and recommend next steps.

---

## In Scope (Wave 2)

| Surface | Status |
|---------|--------|
| Shared modal/dialog polish | ✓ Done |
| Shared form spacing and field rhythm | ✓ Done |
| Project list/dashboard shell | ✓ Done |
| Header/topbar refinement | ✓ Done |
| Shared panel/container consistency | ✓ Done |
| Minor login cleanup | Skipped (not needed from live review) |

---

## Excluded (by design)

| Surface | Reason |
|---------|--------|
| Board columns, swimlanes | Higher complexity; Wave 3 |
| Task cards | Board-level redesign; Wave 3 |
| Task detail layout | Task-focused; Wave 3 |
| Task creation form layout | Task-focused; Wave 3 |
| Search flows | Separate flow; Wave 3 |
| New JavaScript | Avoided; CSS-only |
| Dashboard sidebar nav structure | Low priority; could be Wave 3 |

---

## Ready for Wave 3?

**Yes.** The interior foundation is cleaner:
- Modals feel less cramped
- Form hierarchy is improved
- Dashboard/project list shell is visually refined
- Header is more polished
- Shared surfaces (panel, page-header, table-list) use consistent variables

**Recommended Wave 3 focus:**
1. Board view — column headers, swimlane styling, card density
2. Task cards — typography, spacing, color treatment
3. Task detail/sidebar — layout polish
4. Task creation/edit form — field grouping, multi-column layout
5. Search results presentation

---

## Verification

- [ ] Deploy to staging
- [ ] Login page
- [ ] Dashboard/project list
- [ ] New project modal
- [ ] One additional modal (e.g. user creation, activity stream)
- [ ] Topbar in light/dark/auto
- [ ] No console/runtime/template errors
