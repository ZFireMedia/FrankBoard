# FrankBoard UI Modernization Roadmap v1

**Date**: 2025-03-14  
**Based on**: Live UX Audit v1  
**Scope**: Practical roadmap for a small engineering team; preserves simplicity; avoids Jira-style enterprise creep.

---

## 1. Prioritized Roadmap Overview

| Phase | Focus | Est. Effort | Risk |
|-------|-------|-------------|------|
| Wave 1 | Login + typography + polish | Low | Low |
| Wave 2 | Task creation simplification + board polish | Medium | Low |
| Wave 3 | Search/filter UX + navigation clarity | Medium | Low |
| Wave 4 | Mobile responsiveness improvements | Medium | Medium |
| Later | Deeper IA changes, accessibility audit | High | Variable |

---

## 2. Must-Do Items (Before Wave 2)

| Item | Rationale | Dependency |
|------|------------|------------|
| Login page polish | First impression; low-risk win | None |
| Typography refresh (font stack, scale) | Foundation for all screens | None |
| CSS variable consolidation | Enables consistent theming | None |
| Basic button/input consistency | Reduces visual noise | Typography |

---

## 3. Should-Do Items (Wave 2–3)

| Item | Rationale | Dependency |
|------|------------|------------|
| Task creation form simplification | High-friction flow; collapsible sections | Must-do polish |
| Board column header clarity | Improves scannability | None |
| Search UX (discoverability, examples) | Power feature underused | None |
| Page header hierarchy | Reduces cognitive load | Typography |
| Modal/dropdown styling consistency | Affects many flows | Button/input consistency |

---

## 4. Later / Nice-to-Have

| Item | Rationale |
|------|------------|
| Full mobile-first board redesign | Higher effort; board is table-based |
| Custom dashboard widgets | Adds complexity; defer |
| Keyboard shortcuts overlay | Power-user; niche |
| RTL language support | Depends on user base |
| Advanced accessibility audit (WCAG) | Important but can follow polish |

---

## 5. Implementation Sequencing Recommendations

1. **Wave 1** (see first-implementation-wave-v1.md): Login + typography + base polish. Est. 2–4 days for a single dev.
2. **Wave 2**: After Wave 1 is deployed and validated, tackle task creation form (accordion layout, progressive disclosure) and board header polish.
3. **Wave 3**: Search UX (inline help, recent searches), navigation labels, sidebar tweaks.
4. **Wave 4**: Responsiveness. Audit breakpoints (480px, 768px); improve board horizontal scroll UX on small screens; test task form on mobile.

---

## 6. Dependency Notes

- **Typography** unlocks consistent sizing across modals, forms, and boards.
- **CSS variables** (light/dark/auto) already exist; ensure any new styles use them.
- **No framework adoption** in Wave 1–2; stick to Kanboard’s existing CSS/JS patterns.
- **Plugins**: Consider plugin compatibility when changing class names or DOM structure.

---

## 7. Out of Scope (Explicitly Excluded)

- Full frontend rewrite
- React/Vue/Svelte migration
- AI features
- New major features (e.g., custom fields, automation)
- Enterprise SSO/audit trails (unless explicitly requested)
- Replacing jQuery or major JS refactors
