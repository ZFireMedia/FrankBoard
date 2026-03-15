# FrankBoard Homepage — Card Alignment Refinement Pass

**Date**: 2025-03-15  
**Status**: Complete  
**Scope**: Desktop-focused layout correction; no redesign.

---

## Sections Adjusted

| Section | Change | Breakpoint |
|---------|--------|------------|
| **Benefits** (4 value cards) | Container max-width 720px (matches hero); explicit `margin-inline: auto` | ≥768px |
| **Trust** ("No lock-in. No bait-and-switch.") | Container max-width 720px; section title centered; `margin-inline: auto` | ≥768px |
| **Editions teaser** ("Three ways to run") | Container max-width 720px; section title and CTA link centered; `margin-inline: auto` | ≥768px |

---

## Layout / Container Changes

1. **CSS variable**: `--max-width-cards: 720px` — matches hero width for consistent vertical alignment.
2. **Benefits `.container`**: At `min-width: 768px`, `max-width: var(--max-width)` (720px) and `margin-inline: auto`.
3. **Trust `.container`**: Same at 768px+. Section title `text-align: center`.
4. **Editions-teaser `.container`**: Same at 768px+. Section title and `.section__cta` `text-align: center`.

---

## Widths / Breakpoints Affected

- **Desktop / tablet**: `min-width: 768px` — all refinements apply
- **Mobile** (&lt;768px): No changes — retains original 960px effective max-width

---

## Mobile Preserved

- No media queries added or modified below 768px.
- Benefits grid remains 2 columns at ≥640px, 1 column below.
- Trust grid remains 2 columns at ≥480px, 4 columns at ≥720px.
- Edition cards remain 3 columns at ≥640px, 1 column below.
- Padding, spacing, typography, and button styles unchanged.
- Nav, CTA rows, footer layout unchanged.

---

## Refinement, Not Redesign

- No new sections added.
- No visual treatments or styling beyond container width and text alignment.
- No copy changes.
- No JavaScript changes.
- Existing design system (colors, fonts, spacing) preserved.

---

## Verification

- [x] Desktop/tablet (≥768px): Card groups 720px, centered beneath hero
- [x] Mobile (&lt;768px): Layout unchanged (960px container)
- [x] Nav, footer, CTAs: No regression
