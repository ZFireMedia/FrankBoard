# Wave 2 Interior UI Foundation — Implementation Notes

**Date**: 2025-03-15  
**Status**: Implementation complete  
**Scope**: CSS/template-only; no JS, no API, no routing changes.

---

## Files Changed

| File | Change type |
|------|-------------|
| `assets/css/src/modal.css` | Modal polish — overlay, box, content, header |
| `assets/css/src/form.css` | Label/input/help rhythm, fieldset, form-actions |
| `assets/css/src/header.css` | Topbar padding, border variable |
| `assets/css/src/panel.css` | Border-radius consistency |
| `assets/css/src/page_header.css` | H2 border variable |
| `assets/css/src/dashboard.css` | Page-header spacing, empty-state alert |
| `assets/css/src/project.css` | Project creation options spacing |
| `assets/css/src/table_list.css` | Row padding, header padding/radius |
| `assets/css/src/base.css` | .page spacing, max-width |
| `assets/css/src/themes/light.css` | New vars: header-border, surface-radius, modal-overlay |
| `assets/css/src/themes/dark.css` | Same new vars (dark-appropriate values) |
| `assets/css/src/themes/auto.css` | Same new vars in root + dark media block |

---

## Surfaces Improved

### 1. Modals/dialogs
- Overlay: `rgba(0,0,0,0.9)` → `var(--modal-overlay-color)` (0.45 light, 0.7 dark)
- Box: min-width 320px, max 96%, border-radius 8px, border, shadow
- Content: padding `0 5px 5px` → `20px 24px 24px`
- Header: padding `5px` → `12px 16px 0 0`

### 2. Forms (shared)
- Labels: margin-top 10→16, margin-bottom 4, font-weight 500, color primary
- Inputs: height 25→32, padding 6px 10px, border-radius 6px
- Textareas: padding 4→8px 10px
- Fieldset: margin-top 10→16, padding 16, border-radius, border uses panel var
- Form-actions: padding-top 20→24, margin-top 8, border-top for visual separation
- Form-help: font-size 0.8→0.85em, margin-top 4, margin-bottom 12, line-height 1.4
- Input text color: `color-light` → `color-primary` for readability

### 3. Dashboard/project list
- Page-header: margin-bottom 20→24, ul margin-top 5→12, li padding-right 15→20
- Empty-state `.alert`: padding 8→20 24, border-radius
- Table-list: font-size 0.85→0.9em, margin-bottom 20→24
- Table-list-header: line-height 28→32, padding 3→8 14, border-radius top
- Table-list-row: padding 3→10 14
- Dashboard-table-link: font-weight 500→600

### 4. Header/topbar
- Padding: 5px 10px → 8px 16px
- Border: `#dedede` → `var(--header-border-color)`

### 5. Shared panels/containers
- Panel: border-radius 4→6px via `var(--surface-radius)`
- Page-header h2: border `#ccc` → `var(--header-border-color)`
- `.page`: margin 10→16, padding-top 8, max-width 1400px

### 6. Project creation
- `.js-project-creation-options`: border dotted→solid, padding increased

---

## Theme Variable Additions

| Variable | Light | Dark | Auto (dark) |
|---------|-------|------|-------------|
| `--header-border-color` | #e8e8e8 | rgba(255,255,255,0.08) | rgba(255,255,255,0.08) |
| `--surface-radius` | 6px | 6px | 6px |
| `--modal-overlay-color` | rgba(0,0,0,0.45) | rgba(0,0,0,0.7) | rgba(0,0,0,0.7) |

---

## Compatibility Notes

- All changes use theme variables where appropriate; light/dark/auto preserved
- No selector renames that affect plugins
- Modal DOM structure unchanged (ids: modal-overlay, modal-box, modal-content, modal-header)
- Form structure unchanged; `.form-inline`, `.form-columns` behavior preserved

---

## Intentionally Deferred

- Board columns, swimlanes, task cards, task detail layout (Wave 3)
- Search flows (Wave 3)
- Login page minor cleanup (not needed from live review)
- New project modal template structure (CSS-only changes)
