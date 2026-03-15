# Wave 4 Product Polish — Verification

**Date**: 2025-03-15  
**Staging**: http://66.179.208.122:8080 (after deploy)

---

## Pre-deploy checklist

- [ ] Run `php cli css` or rebuild Docker image (css builds during image build)
- [ ] Deploy to staging
- [ ] Clear browser cache or hard refresh for CSS

---

## Surfaces to verify

| Surface | URL/Path | Checks |
|---------|----------|--------|
| Dashboard empty | / (no tasks) | "Nothing assigned" alert padding, radius |
| Project list empty | /projects (no projects) | "There is no project" alert styling |
| Board | /board/1 | Column headers, task cards, DnD placeholder |
| Task detail | /task/1 | Summary layout, external-task-view border |
| Search no results | /?controller=SearchController&action=index&search=xyznone | "Nothing found" alert |
| Admin application | /settings/application | Page-header, fieldset spacing, form-actions border |
| Admin board | /settings/board | Same form consistency |

---

## Theme verification

| Theme | Surfaces | Result |
|-------|----------|--------|
| Light | Dashboard, board, task, config | _Pending_ |
| Dark | Dashboard, board, task, config, sidebar | _Pending_ |
| Auto | Same as above | _Pending_ |

---

## Responsive verification

| Breakpoint | Surface | Result |
|------------|---------|--------|
| &lt; 640px | Page margin | _Pending_ |
| &lt; 768px | Board scroll, config form | _Pending_ |

---

## Drag-and-drop

| Check | Result |
|-------|--------|
| Placeholder visible when dragging | _Pending_ |
| Selected item border (theme-aware) | _Pending_ |

---

## Regressions

_None yet — verification pending._

---

## Notes

- CSS-only changes; no behavior regression expected.
- If dark/auto theme issues appear, check for remaining hardcoded #hex in modified files.
