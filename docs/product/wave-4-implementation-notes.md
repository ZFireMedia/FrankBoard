# Wave 4 Product Polish and Readiness — Implementation Notes

**Date**: 2025-03-15  
**Status**: Implementation complete  
**Scope**: CSS-only; no JS, no API, no template/controller changes. Build adds two new CSS files to `CssCommand`.

---

## Files Changed

| File | Change type |
|------|-------------|
| `assets/css/src/empty_states.css` | **New** — page-level empty state polish |
| `assets/css/src/responsive.css` | **New** — mobile, narrow-width, config consistency |
| `assets/css/src/filter_box.css` | Search/filter polish |
| `assets/css/src/board.css` | Theme fix: draggable-item-selected |
| `assets/css/src/table_list.css` | Theme fix: table-list-category |
| `assets/css/src/sidebar.css` | Theme fix: sidebar hover/active borders |
| `assets/css/src/task_summary.css` | Theme fix: external-task-view border |
| `app/Console/CssCommand.php` | Added `empty_states.css`, `responsive.css` to build |

---

## Surfaces Improved

### 1. Empty states
- **Page-level alerts** (no project, nothing assigned, nothing found): padding 20px 24px, border-radius from theme, line-height 1.5
- Search “nothing found” and similar: margin-top emphasis

### 2. Search / filter
- **Filter box**: margin-bottom 20px, spacing around input-addon
- Search results continue to use existing table-list styles

### 3. Mobile / narrow-width
- **Page shell**: margin-left/right 12px below 640px
- **Board**: touch scrolling, narrow margin adjustments on small screens
- **Config sidebar**: form-actions and fieldset spacing on mobile

### 4. Admin / settings
- **Sidebar-content**: page-header margin, h2 weight/size
- **Fieldset**: margin-bottom 24px
- **Form-actions**: border-top, padding-top, margin-top
- **Panel**: margin-top in config context

### 5. Theme consistency (light / dark / auto)
- **draggable-item-selected**: `#000` → `var(--color-primary)`
- **table-list-category**: `#000`, `#ccc` → `var(--color-primary)`, `var(--panel-border-color)`
- **sidebar hover/active**: `#555`, `#333` → `var(--color-medium)`, `var(--color-primary)`
- **#external-task-view**: `#ccc` → `var(--panel-border-color)`

---

## Build

- Run `php cli css` (or `docker compose run --rm app php cli css`) to regenerate minified CSS.
- Docker image build already runs `php cli css`.

---

## Verification

See `docs/product/wave-4-verification.md`.
