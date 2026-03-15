# FrankBoard.com — Site Design System v1

**Date**: 2025-03-15  
**Status**: Architecture document  
**Scope**: Visual direction and component guidance for the static launch site.

---

## Recommended Visual Direction

The launch site should feel:

| Attribute | Guidance |
|-----------|----------|
| **Clear** | Legible typography, enough contrast, unambiguous hierarchy |
| **Professional** | Cohesive, intentional, not playful or flashy |
| **Aligned** | Visually consistent with the FrankBoard product (Wave 1–4 polish) |
| **Lightweight** | Minimal decorative elements; content-first |

**Mood**: Calm, trustworthy, practical — like the product. Avoid startup clichés (gradients, glassmorphism, excessive animation).

---

## Typography Guidance

### Font Stack (Recommended)

| Use | Font | Fallback | Notes |
|-----|------|----------|-------|
| **Headings** | System font stack or modest web font | system-ui, -apple-system, sans-serif | Prefer system fonts for speed; or 1–2 weights of a readable sans (e.g., Source Sans 3, DM Sans) |
| **Body** | Same as headings | — | Single family; 2 weights (regular, semibold) max |
| **Monospace** | system-ui monospace | monospace | Code, paths; use sparingly |

**Avoid**: Inter, Roboto, Arial as primary (overused); display/script fonts; more than 2 font families.

### Scale

| Element | Size | Weight |
|---------|------|--------|
| H1 (hero) | 2rem–2.5rem | 600–700 |
| H2 (section) | 1.5rem–1.75rem | 600 |
| H3 (subhead) | 1.2rem–1.35rem | 600 |
| Body | 1rem | 400 |
| Small | 0.875rem | 400 |
| CTA button text | 1rem | 600 |

Line-height: 1.4–1.6 for body; 1.2–1.4 for headings.

---

## Spacing and Layout Guidance

### Spacing Scale

| Token | Value | Use |
|-------|-------|-----|
| `--space-xs` | 4px | Tight inline gaps |
| `--space-sm` | 8px | Small gaps, icon/text |
| `--space-md` | 16px | Section internal padding |
| `--space-lg` | 24px | Section spacing |
| `--space-xl` | 32px | Major section breaks |
| `--space-2xl` | 48px | Hero to content |
| `--space-3xl` | 64px | Page section dividers |

### Layout

- **Max content width**: 960px–1200px for text-heavy pages; hero can span full width with constrained inner content
- **Page padding**: 16px–24px on mobile; 24px–32px on desktop
- **Section spacing**: 48px–64px between major sections on desktop; 32px–48px on mobile

### Grid

- Simple: single-column for most content; 2–3 columns only for comparison tables, feature grids
- No complex grid systems required; CSS Grid or Flexbox sufficient

---

## Component List

| Component | Description | Used On |
|-----------|-------------|---------|
| **Header** | Logo, nav links, primary CTA | All pages |
| **Hero** | Headline, subhead, 1–2 CTAs | Homepage |
| **Section** | H2, body copy, optional sub-sections | All pages |
| **Benefit block** | Icon/placeholder + headline + 2–3 lines | Homepage |
| **Trust block** | Short bullets or grid | Homepage |
| **Edition card** | Name, one-line, CTA | Homepage teaser, edition comparison, pricing |
| **Comparison table** | Rows × Community/Pro/Cloud | Edition comparison |
| **FAQ block** | Question + answer pairs | Pricing, support |
| **CTA block** | 1–2 buttons or links | All pages |
| **Footer** | Links (Compare, Migrate, Pricing, Support, GitHub), copyright | All pages |

---

## Button and Link Treatment

### Primary Button

- Background: solid brand/primary color (e.g., #3366CC or equivalent)
- Text: white, 600 weight
- Padding: 12px 24px
- Border-radius: 6px
- Hover: slightly darker background
- Focus: visible outline (2px offset)

### Secondary Button

- Background: transparent or light gray
- Border: 1px solid
- Text: primary color
- Same padding and radius as primary

### Link

- Color: primary blue (or theme primary)
- Underline on hover; optionally underline by default for in-page links
- No prominent "Learn more" arrows unless part of a list

**Avoid**: Rounded pill buttons (unless intentional); gradient buttons; tiny click targets.

---

## Icon and Illustration Guidance

### Icons

- **Style**: Simple, line or outline; 24px or 32px for benefit blocks
- **Source**: Lucide, Heroicons, or similar MIT-licensed set; single style throughout
- **Use**: Sparingly — benefit blocks, nav (optional), trust indicators
- **Avoid**: Mixing icon styles; decorative icons everywhere

### Illustrations

- **Recommendation**: Omit initially. Use whitespace and typography.
- **If needed later**: Simple, flat, product-focused (e.g., board or task card sketch); no stock illustration clutter
- **Avoid**: Generic "team collaboration" illustrations; 3D renders; AI-generated imagery

---

## Color Guidance

### Palette (Recommended)

| Role | Light | Dark (optional) |
|------|-------|-----------------|
| **Background** | #ffffff | #1a1a1a |
| **Text primary** | #333333 | #e0e0e0 |
| **Text secondary** | #555555 | #999999 |
| **Primary (CTA, links)** | #3366CC | #5b9aff |
| **Border** | #e5e5e5 | #333333 |
| **Success** | #2d7d46 | — |
| **Error** | #b94a48 | — |

Keep palette minimal. No gradients unless subtle and purposeful.

---

## What to Avoid Visually

| Avoid | Why |
|-------|-----|
| **Heavy gradients** | Dated, distracting |
| **Glassmorphism / blur** | Overused, accessibility concerns |
| **Autoplay animation** | Annoying, not professional |
| **Tiny body text** | Below 14px harms readability |
| **Low-contrast text** | Accessibility failure |
| **More than 3 font families** | Visual noise |
| **Cluttered hero** | Distracts from message |
| **Generic stock photos** | Feels inauthentic |
| **Countdown timers / urgency** | Not aligned with product tone |
| **Dark mode by default** | Light is safer for broad appeal; dark can be optional |

---

## Alignment with Product

The marketing site should **feel consistent** with the FrankBoard app (Wave 1–4):

- Similar typography approach (readable, modest)
- Similar spacing rhythm
- Same primary/accent color if possible
- No visual disconnect (e.g., marketing site in one aesthetic, app in another)

The site is not the app — it markets the app. Visual alignment builds trust.

---

## Summary

- **Typography**: System fonts or 1 web font; 2 weights max
- **Layout**: Max width 960–1200px; generous section spacing
- **Components**: Header, hero, sections, blocks, footer — no complex UI library
- **Buttons/links**: Clear primary/secondary; accessible focus states
- **Icons**: Simple, consistent set; use sparingly
- **Colors**: Minimal palette; primary for CTAs and links
- **Avoid**: Gradients, glassmorphism, animation, clutter, stock photos
