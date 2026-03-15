# Wave 1 UI Modernization — Implementation Notes

**Date**: 2025-03-14  
**Status**: Implementation complete  
**Scope**: CSS/template-only; no JS, no API, no routing changes.

---

## Files Changed

| File | Change type |
|------|-------------|
| `app/Template/auth/index.php` | Template structure (wrapper, brand header) |
| `assets/css/src/base.css` | Typography font stack |
| `assets/css/src/login.css` | **New** — login card, brand, spacing |
| `assets/css/src/button.css` | Button focus states |
| `assets/css/src/form.css` | No changes (inputs already use theme vars) |
| `assets/css/src/themes/light.css` | `--input-placeholder-color` contrast fix |
| `app/Console/CssCommand.php` | Added `login.css` to `appFiles` (after form.css) |
| `cli` | Added `'css'` to bootstrap skip list |
| `Dockerfile` | Added `RUN cd /var/www/app && php cli css` |

---

## UX Improvements

### 1. Login page polish
- Centered card layout via `.login-page-wrapper` (flexbox, min-height 60vh)
- `.login-card` — max-width 400px, 8px radius, subtle shadow, theme variables for background/border
- FrankBoard brand header (`.login-brand`) above form — 1.5rem, font-weight 600, `--color-primary`
- Spacing: 32px/28px padding, 24px between brand and form, full-width sign-in button

### 2. Login container/card layout
- Card uses `--panel-background-color`, `--panel-border-color` for light/dark/auto
- Responsive: 480px breakpoint reduces padding and font size

### 3. Typography refresh
- Body font stack: `system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif`
- Added `text-rendering: optimizeLegibility` on body
- No external font requests; system-safe, fast-loading

### 4. Button/input consistency
- Buttons: focus styles use `outline: 2px solid var(--input-focus-border-color); outline-offset: 2px` (`.btn:focus`, `.btn:focus-visible`)
- Form inputs: already use theme vars; focus box-shadow unchanged

### 5. Focus states and contrast
- All buttons: visible outline on focus
- Light theme: `--input-placeholder-color` set to `#999` (was `#dedede`) for readable placeholder text

---

## Selectors Introduced

| Selector | Purpose |
|----------|---------|
| `.login-page-wrapper` | Outer flex container, centers content |
| `.login-card` | Card/panel containing the form |
| `.login-brand` | FrankBoard heading above form |

Existing `.form-login` preserved for `session-check.js` (`KB.find('.form-login')`).

---

## Theme Variable Changes

**light.css only:**
- `--input-placeholder-color`: `#dedede` → `#999`

Dark and auto themes unchanged.

---

## Compatibility Notes

- `.form-login` class kept; password reset, 2FA, and other auth flows using it get the new layout
- All login styles use theme variables; light/dark/auto behave correctly
- Plugins and Kanboard templates unchanged
- No DOM changes to plugin injection points

---

## Rollback Notes

1. Revert `app/Template/auth/index.php` to remove wrapper and brand
2. Delete `assets/css/src/login.css`
3. Remove `login.css` from `CssCommand.php` `appFiles`
4. Revert `base.css` font stack
5. Revert `button.css` focus rules
6. Revert `light.css` `--input-placeholder-color` to `#dedede`
7. Run `php cli css` to rebuild minified CSS
8. Revert `cli` and `Dockerfile` if CSS build during image build was added

---

## Intentionally Deferred

- Input font-family: kept `sans-serif` in form.css (body typography propagated globally)
- Dashboard, board, task-specific layout changes (Wave 2)
- Marketing content, hero sections, feature lists on login

---

## Build Requirements

- CSS build: `php cli css` from project root
- `css` command skips `app.bootstrap` (no DB needed)
- Dockerfile runs CSS build during image build
