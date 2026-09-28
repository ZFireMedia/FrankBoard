# FrankBoard Manual QA Playbook v1

**Date**: 2025-03-16  
**Purpose**: Repeatable manual QA flows for operator and Cursor agent.

---

## Prerequisites

- [ ] App URL known (staging: http://66.179.208.122:8080 or app.frankboard.com)
- [ ] Marketing site URL known (https://frankboard.com)
- [ ] Test credentials available (admin / pass123 or equivalent)
- [ ] Browser with DevTools available

---

## Part 1: App Flows

### Flow 1 — Login and Logout

| Step | Action | Expected |
|------|--------|----------|
| 1 | Navigate to app URL | Login page loads with FrankBoard branding |
| 2 | Enter valid username and password | — |
| 3 | Click Login | Dashboard loads |
| 4 | Click user menu / Logout | Return to login page |

**Pass**: All steps succeed. **Fail**: Log blocker or bug per template.

---

### Flow 2 — Dashboard and Project List

| Step | Action | Expected |
|------|--------|----------|
| 1 | Log in | Dashboard shows |
| 2 | Open Projects / board list | Project list or boards visible |
| 3 | If no projects, note empty state | "There is no project" or similar; no error |
| 4 | If projects exist, click one | Board view loads |

**Pass**: Navigation works; empty state renders cleanly. **Fail**: 404, crash, or broken layout → log bug.

---

### Flow 3 — Board View

| Step | Action | Expected |
|------|--------|----------|
| 1 | Open a project with at least one column | Board loads; columns visible |
| 2 | Verify column headers | Readable, styled |
| 3 | Verify task cards (if any) | Cards display; no overlap or truncation |
| 4 | Click "+" or add task | Task create form opens |
| 5 | (Optional) Drag task | Placeholder visible; task moves |

**Pass**: Board renders; add task works. **Fail**: Board blank, cards broken, add fails → log bug.

---

### Flow 4 — Task Create and Edit

| Step | Action | Expected |
|------|--------|----------|
| 1 | From board, open add task form | Form shows title, description, etc. |
| 2 | Enter title; save | Task appears on board |
| 3 | Open task (click card or link) | Task detail view loads |
| 4 | Edit task (change title or description) | Save succeeds; changes persist |
| 5 | Return to board | Task shows updated content |

**Pass**: Create and edit complete without error. **Fail**: Save fails, data lost → log critical bug.

---

### Flow 5 — Search and Filter

| Step | Action | Expected |
|------|--------|----------|
| 1 | Use search box or search page | Search UI responds |
| 2 | Search for known task title | Results include that task |
| 3 | Search for non-existent term | "Nothing found" or empty state; no crash |
| 4 | Use a filter if available | Results update accordingly |

**Pass**: Search returns expected results; no error on empty. **Fail**: Wrong results, crash → log bug.

---

### Flow 6 — Admin / Settings

| Step | Action | Expected |
|------|--------|----------|
| 1 | Log in as admin | — |
| 2 | Open Settings / Application | Settings page loads |
| 3 | Open Settings / Board (or similar) | Board config loads |
| 4 | Verify forms render | Labels, inputs, buttons visible |
| 5 | Do not change critical config | — |

**Pass**: Pages load; forms render. **Fail**: 403, broken layout → log bug.

---

### Flow 7 — Theme and Responsive

| Step | Action | Expected |
|------|--------|----------|
| 1 | Switch theme (light / dark / auto) | Theme changes; no flash or broken contrast |
| 2 | Resize to ~375px width | Layout reflows; no horizontal scroll |
| 3 | Check board and task at narrow width | Usable; buttons tappable |

**Pass**: Theme switches; narrow layout usable. **Fail**: Broken theme, unreadable text → log bug.

---

## Part 2: Marketing Site Flows

### Flow 8 — Homepage and Nav

| Step | Action | Expected |
|------|--------|----------|
| 1 | Navigate to https://frankboard.com | Homepage loads |
| 2 | Verify hero, benefits, trust sections | Content visible; layout correct |
| 3 | Click each nav link: Editions, Migrate, Why, Pricing, Support | Each page loads |
| 4 | Click logo | Returns to homepage |
| 5 | Click "Get Community Free" | GitHub repo opens (new tab) |

**Pass**: All pages load; nav and CTA work. **Fail**: 404, wrong target → log bug.

---

### Flow 9 — All Six Pages

| Page | URL | Expected |
|------|-----|----------|
| Home | / | Hero, benefits, trust, edition teaser, migration teaser |
| Editions | /editions/ | Edition descriptions, comparison table |
| Migrate | /migrate/ | Migration steps, compatibility |
| Why | /why/ | Story, what we solve / won't do |
| Pricing | /pricing/ | Community / Pro / Cloud cards, FAQ |
| Support | /support/ | Self-serve, Community, Pro/Cloud sections |

**Pass**: All return 200; content renders. **Fail**: 404, broken layout, wrong copy → log bug.

---

### Flow 10 — CTAs and Links

| Element | Target | Expected |
|---------|--------|----------|
| Get Community Free (header, hero, footer) | GitHub repo | Opens correct repo |
| Compare editions | /editions/ | Internal link works |
| Migrate from Kanboard | /migrate/ | Internal link works |
| Contact us / mailto | support@zfiremedia.com | Opens mail client or copies |
| Footer: GitHub | GitHub repo | Opens correct repo |
| Footer: Kanboard | kanboard/kanboard | Opens upstream repo |

**Pass**: All CTAs go to correct targets. **Fail**: Wrong URL, broken mailto → log bug.

---

### Flow 11 — Assets and SEO

| Check | Expected |
|-------|----------|
| CSS loads | main.css returns 200 |
| Favicon loads | favicon.svg returns 200 |
| robots.txt | Allow: /, Sitemap URL |
| sitemap.xml | Valid XML; includes all 6 pages |
| HTTPS | No mixed content; cert valid |

**Pass**: All assets and SEO basics correct. **Fail**: 404, invalid cert → log bug.

---

## Recording Observations

1. Use `test-run-log-template-v1.md` for each run.
2. For each flow: Pass / Fail / Skipped.
3. On Fail: Create bug using `bug-report-template-v1.md`.
4. On Blocker: Stop, log blocker, do not continue until resolved.

---

## Pass/Fail Expectations

- **Pass**: Flow completes as expected; no visible errors.
- **Fail**: Error, crash, wrong behavior, or broken layout. Log bug.
- **Skipped**: Flow not applicable (e.g., no projects). Note reason.

---

## When to Stop and Log a Blocker

- Login fails → cannot test app.
- Board never loads → cannot test tasks.
- Marketing site returns 403/500 → cannot test site.
- Critical data loss (e.g., task delete by mistake) → stop and assess.

**Action**: Fill bug report with severity Blocker. Halt further testing. Resolve before next run.
