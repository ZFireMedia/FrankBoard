# FrankBoard / Kanboard UX Audit v1

**Date**: 2025-03-14  
**Scope**: Live FrankBoard instance at http://66.179.208.122:8080 + codebase review  
**Product**: Small-team work board (Kanban)

---

## 1. Summary of Current UX Quality

FrankBoard (Kanboard v1.2.51) provides a functional, utilitarian work-board experience. It delivers core Kanban features without bloat but feels dated visually and in interaction patterns. The UX is **adequate for power users** but **moderately friction-filled for new or casual users**. Overall grade: **C+** — works, but modernization would materially improve perceived quality.

---

## 2. Strengths Worth Preserving

- **Simplicity**: No enterprise clutter. Straightforward project → board → task flow.
- **Fast load**: Lightweight; no heavy SPA overhead.
- **Theme support**: Light, dark, and auto (prefers-color-scheme) via CSS variables.
- **Keyboard-friendly**: Autofocus, tab order, form labels present.
- **Accessibility baseline**: Labels, ARIA where used, semantic structure.
- **Search syntax**: Powerful query language for power users (project:, assignee:, due:, etc.).
- **Board layout**: Clear column headers, swimlanes, drag-and-drop.
- **Task metadata**: Assignee, due date, priority, category, tags — all available without clutter by default.
- **Plugin architecture**: Extensible without core rewrites.

---

## 3. Major Pain Points

| Area | Issue | Severity |
|------|-------|----------|
| **Login** | Bland, generic look; no branding or welcome message | Cosmetic |
| **Visual hierarchy** | Flat; little differentiation between primary/secondary actions | Usability |
| **Typography** | Helvetica Neue/Arial; dated, low character | Cosmetic |
| **Task creation** | Long form, 3 columns; overwhelming for simple tasks | Usability |
| **Board on small screens** | Horizontal scroll; columns stack poorly below ~768px | Responsiveness |
| **Search discoverability** | Advanced syntax hidden; users may not know it exists | IA |
| **Filtering** | Filter UI exists but is not prominent; easy to miss | IA |
| **Modals** | Dense; many fields crammed into small overlays | Usability |
| **Button styles** | Inconsistent; mix of `btn`, `btn-blue`, icon-only | Cosmetic |
| **Feedback** | Limited loading/spinner feedback on async actions | Usability |

---

## 4. Page/Flow-by-Flow Findings

### Login Experience

- **Layout**: Centered form, vertical stack. Clean but anonymous.
- **Fields**: Username, Password, Remember Me (checked by default), Sign in, Forgot password?
- **Strengths**: Clear labels, required attributes, autofocus on username, autocomplete attributes.
- **Gaps**: No product name/logo, no "welcome" copy, no password requirements hint. Feels generic.
- **Accessibility**: Labels associated; focus states present. No obvious contrast issues.

### First-Run / Admin Experience

- **Flow**: Login → Dashboard (or redirect to last project). No onboarding wizard.
- **Dashboard** (live verified): Page header with "New project", "Project management", "My activity stream". Search box and user menu (admin) in header. "My dashboard" heading. Projects list in sidebar; default project ("Default project") with Board, List, Calendar links.
- **Live observation**: Clean post-login; no clutter. Header reflows; search prominent. Project access is clear.
- **New users**: May not know to create a project first. No guided first-step.

### Dashboard / Home

- **Structure**: Sidebar (projects, filters) + main content (activity or project list).
- **Page header**: Icon + text links. Functional but visually flat.
- **Sidebar**: Collapsible; responsive (`max-width: 768px`). Works but feels cramped on mobile.

### Board / Project View

- **Layout**: Table-based board; fixed column width (240px). Swimlanes supported.
- **Columns**: Header + task cards. Drag-and-drop. Works well on desktop.
- **Issues**: Horizontal overflow on narrow screens; columns don't collapse gracefully.
- **Compact mode**: Available but not default; users may not discover it.

### Task Creation Flow

- **Form**: Three columns (main, secondary x2). Many fields: title, description, tags, color, assignee, category, swimlane, column, priority, due date, start date, time estimated, time spent, score, reference, attachments.
- **Overwhelming**: For "add a quick task", too many options. No "quick add" minimal flow.
- **Accordion**: Attachments in collapsible section — good.
- **Checkboxes**: "Create another task", "Duplicate to multiple projects" — useful but add cognitive load.

### Task Detail View

- **Layout**: Sidebar (metadata) + main (title, description, comments, activity).
- **Strengths**: Clear sections; subtasks, links, files, time tracking visible.
- **Gaps**: Dense text; little whitespace. Modals for edits can feel cramped.

### Navigation Structure

- **Header**: Project selector, search, menus. Flex layout; reorders at 480px.
- **Breadcrumbs**: Project > Board/Task. Adequate.
- **Consistency**: Top-level actions in page header; context actions in dropdowns. Predictable.

### Filtering / Search Flow

- **Search**: Dedicated page with input + filter helper. Advanced syntax documented in a panel.
- **Discovery**: Many users won't find "project: X assignee:me due:tomorrow". No saved filters or quick filters on the board.
- **Filter box**: Exists in code; not always surfaced prominently.

### Responsiveness / Mobile Readiness

- **Breakpoints**: 400px, 480px, 560px, 768px, 1000px used across CSS.
- **Behavior**: Headers reorder; sidebars collapse; forms stack. Task list and board have mobile rules.
- **Board**: Horizontal scroll on small screens; table layout constrains good mobile UX.
- **Touch**: No explicit touch optimizations; drag-and-drop may be awkward on touch devices.

### Visual Hierarchy and Clarity

- **Typography**: System fonts (Helvetica Neue, Arial, sans-serif). Readable but plain.
- **Colors**: CSS variables for theme; blue accents (#36C). Low contrast in some spots.
- **Spacing**: Tight in places (e.g. modals, table cells). Generous in others.
- **Buttons**: Inconsistent sizing and styling. Primary vs secondary not always clear.

---

## 5. Responsiveness / Mobile Notes

- **Existing**: Media queries for 480px, 768px, 1000px. Sidebar, header, forms adapt.
- **Board**: `#board-container { overflow-x: auto }` — horizontal scroll on narrow viewports. Columns stay fixed width; no card stacking.
- **Task form**: Stacks at 1000px and 768px. Usable but long scroll on mobile.
- **Gap**: No dedicated mobile navigation (hamburger, bottom nav). Relies on reflow.

---

## 6. Accessibility / Readability Observations

- **Labels**: Form fields have associated labels. Good.
- **Focus**: `:focus` styles with box-shadow. Visible.
- **Color**: Not solely relied upon for meaning. Links and buttons have text/labels.
- **Contrast**: Light theme uses #333 on #FFF — passes. Dark theme uses #a0a0a0 on #222 — verify for WCAG AA.
- **ARIA**: Limited use; modals and dynamic regions could benefit.
- **Screen reader**: Structure is semantic (headings, lists). No known major blockers.
- **Fix (v1.2.51)**: ChangeLog mentions "Fix accessibility issue of insufficient text to background contrast" — addressed in current release.

---

## 7. Modernization Opportunities

| Opportunity | Type | Effort |
|-------------|------|--------|
| Login refresh (logo, spacing, subtle illustration) | Cosmetic | Low |
| Typography upgrade (e.g. Inter, Source Sans) | Cosmetic | Low |
| Quick-add task (minimal form, inline on board) | Usability | Medium |
| Board mobile layout (stacked columns or simplified view) | Usability | Medium |
| Consistent button system (primary, secondary, ghost) | Cosmetic | Low |
| Saved filters / quick filters on board | IA | Medium |
| Modal density reduction (progressive disclosure) | Usability | Medium |
| Loading states for async actions | Usability | Low |
| Better empty states (first project, first task) | Usability | Low |
| Refined spacing and card treatment | Cosmetic | Low |

---

## 8. What Not to Do

- **No Jira-style complexity**: Avoid sprint planning, epics, complex workflows by default.
- **No full frontend rewrite**: Prefer incremental CSS/layout and targeted template tweaks.
- **No removal of power-user features**: Keep advanced search, keyboard use, plugins.
- **No breaking changes**: Preserve URL structure, API, plugin compatibility.
