# FrankBoard First Implementation Wave v1

**Date**: 2025-03-14  
**Scope**: First UI modernization sprint; low risk, high visibility.  
**Principle**: Improve first impression and foundation without architectural change.

---

## 1. Exact Scope for Wave 1

| # | Item | Target | Effort |
|---|------|--------|--------|
| 1 | Login page polish | `app/Template/auth/index.php`, `form.css`, `.form-login` | 0.5 day |
| 2 | Typography refresh | `base.css`, theme CSS; font stack, size scale | 0.5 day |
| 3 | Login container layout | Centered card, subtle shadow, spacing | 0.25 day |
| 4 | Button/input focus states | Ensure consistency with CSS variables | 0.25 day |
| 5 | Basic branding hook | Optional: logo/name area for FrankBoard | 0.25 day |

**Total estimated effort**: 2–3 days for one developer.

---

## 2. Rationale for Priority Order

1. **Login first**: First screen users see; sets tone. Low complexity, high impact.
2. **Typography**: Shared across all pages. Establishes a clearer hierarchy and readability.
3. **Container/layout**: Login feels more intentional with centered layout and subtle depth.
4. **Focus states**: Improves accessibility and consistency with minimal change.
5. **Branding**: Light touch to distinguish FrankBoard from upstream Kanboard.

---

## 3. Expected User-Visible Impact

- **Login**: Cleaner, more modern look; centered card instead of left-aligned bare form.
- **Typography**: Slightly more refined font stack; improved readability on headings and body text.
- **Across app**: More consistent buttons and inputs; better focus visibility.
- **Perception**: FrankBoard feels more deliberate and less "default."

---

## 4. Technical Risk Level

**Low.**

- Changes are limited to CSS and minor template markup (e.g., wrapper divs).
- No controller or routing changes.
- No database or API changes.
- No removal of existing behavior.
- Kanboard plugin surface unchanged.
- Easy rollback: revert CSS and template changes.

---

## 5. Intentionally Excluded from Wave 1

| Excluded | Reason |
|----------|--------|
| Dashboard changes | Keep scope tight; login + typography first |
| Board view changes | Higher complexity; table layout; Wave 2 |
| Task creation form | Multi-column form; Wave 2 |
| Search/filter UX | Separate flow; Wave 3 |
| Mobile-specific fixes | Requires broader responsiveness pass; Wave 4 |
| New JavaScript | Stay CSS/template-only in Wave 1 |
| Theme switching logic | Light/dark/auto already works; no changes |
| Removing or renaming features | Out of scope; polish only |

---

## 6. Acceptance Criteria for Wave 1

- [ ] Login page has centered card layout with subtle shadow/border
- [ ] Typography uses updated font stack (e.g., system-ui or agreed font)
- [ ] All form inputs and buttons use CSS variables for colors
- [ ] Focus states are visible and consistent
- [ ] No regressions on dashboard, board, or task views
- [ ] Existing light/dark/auto themes still work

---

## 7. Files Likely Touched

- `app/Template/auth/index.php` (wrapper/structure)
- `assets/css/src/form.css`
- `assets/css/src/base.css`
- `assets/css/src/button.css`
- Possibly `assets/css/src/themes/light.css`, `dark.css`, `auto.css` for variable tweaks
- New or updated: `assets/css/src/login.css` (optional, for login-specific rules)
