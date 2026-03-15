# Wave 3 Board and Task Experience — Implementation Notes

**Date**: 2025-03-15  
**Status**: Implementation complete  
**Scope**: CSS-only; no JS, no API, no template/controller changes.

---

## Files Changed

| File | Change type |
|------|-------------|
| `assets/css/src/board.css` | Board container, column headers, swimlane, task list, placeholder |
| `assets/css/src/task_board.css` | Task card layout, padding, borders, title, closed state |
| `assets/css/src/task_summary.css` | Task detail container, columns, spacing |
| `assets/css/src/task_form.css` | Form columns, secondary column, bottom section |
| `assets/css/src/task_category.css` | Category badge on cards |
| `assets/css/src/task_tags.css` | Tag pills on cards/detail |

---

## Surfaces Improved

### 1. Board page
- **#board-container**: margin-top 12px, padding 0 4px
- **board-column-header**: padding 12px 14px, font-weight 600, font-size 0.95em
- **board-swimlane-header**: padding 10px 14px, font-weight 600, border-bottom 2px
- **board-task-list**: padding 10px 8px
- **draggable-placeholder**: border-radius, margin preserved for DnD

### 2. Task cards
- **task-board**: margin-bottom 4→10px, padding 2→10px 12px, border `#000`→`var(--panel-border-color)`, background explicit
- **task-board-status-closed**: border dotted `var(--color-medium)`, opacity 0.9
- **task-board-recent**: border-width 2px, border-color link-primary
- **task-board-title**: margin 8px/10px, font-weight 600, line-height 1.35
- **task-board a**: color `#000`→`var(--color-primary)` for theme support

### 3. Task category and tags on cards
- **task-board-category**: border, padding, radius, color from theme vars
- **task-tags li**: margin 2px 4px 2px 0, padding 2px 6px, border/radius theme vars

### 4. Task detail
- **task-summary-container**: border 2px→1px, padding 10→20px 24px, background panel, radius
- **#task-summary h2**: font-size 1.6→1.5em, font-weight 600, margin-bottom 16px
- **task-summary-columns**: gap 24px (12px mobile)
- **task-summary-column li**: line-height 1.6, margin-bottom 4px

### 5. Task create/edit form
- **task-form-container**: gap 0 32px
- **task-form-main-column**: padding-right 8px
- **task-form-secondary-column**: padding 16px 0 0 20px, border-left panel
- **task-form-bottom**: margin-top 24px, padding-top 20px, border-top panel
- Responsive: secondary column gets border-top on stack, margin-top 16px

---

## Theme Variables Used

- `--panel-border-color`, `--panel-background-color`, `--surface-radius`
- `--board-card-border` (fallback: panel-border-color)
- `--board-card-closed-border` (fallback: color-medium)
- `--board-column-border-color`, `--board-column-header-background`, `--board-swimlane-header-background` (fallback to table vars)

No new theme variables added; uses existing Wave 1/2 vars.

---

## Compatibility Notes

- Drag-and-drop: draggable-item, draggable-placeholder structure unchanged
- Board table layout, column widths, collapse/expand logic preserved
- Task card data attributes and classes unchanged
- Plugin injection points (template:board:*, template:task:*) unchanged

---

## Intentionally Deferred

- Search results presentation (not touched by shared task patterns)
- Board column width (240px) — kept for consistency
- Task list view (table-list) — uses Wave 2 styling
- Subtask table layout
- Comment block spacing
