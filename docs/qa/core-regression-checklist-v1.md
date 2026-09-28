# FrankBoard Core Regression Checklist v1

**Date**: 2025-03-16  
**Purpose**: App flows that must pass before any release.

---

## Environment

| Field | Value |
|-------|-------|
| App URL | _e.g. http://66.179.208.122:8080 or https://app.frankboard.com_ |
| Test user | _e.g. admin_ |
| Browser | _e.g. Chrome 120_ |
| Date | _YYYY-MM-DD_ |

---

## Login / Logout

| # | Check | Pass | Fail |
|---|-------|------|------|
| 1 | Login page loads | ☐ | ☐ |
| 2 | Valid credentials → dashboard | ☐ | ☐ |
| 3 | Invalid credentials → error message | ☐ | ☐ |
| 4 | Logout returns to login | ☐ | ☐ |

---

## Project Create / Edit

| # | Check | Pass | Fail |
|---|-------|------|------|
| 5 | Project list loads | ☐ | ☐ |
| 6 | Create project succeeds | ☐ | ☐ |
| 7 | New project appears in list | ☐ | ☐ |
| 8 | Edit project succeeds | ☐ | ☐ |

---

## Board View

| # | Check | Pass | Fail |
|---|-------|------|------|
| 9 | Board loads for project | ☐ | ☐ |
| 10 | Column headers visible | ☐ | ☐ |
| 11 | Task cards render | ☐ | ☐ |
| 12 | Add task link/button works | ☐ | ☐ |
| 13 | (Optional) Drag task works | ☐ | ☐ |

---

## Task Create / Edit / Detail

| # | Check | Pass | Fail |
|---|-------|------|------|
| 14 | Task create form opens | ☐ | ☐ |
| 15 | Save task → appears on board | ☐ | ☐ |
| 16 | Task detail view loads | ☐ | ☐ |
| 17 | Edit task → save → persists | ☐ | ☐ |
| 18 | Task shows correct data | ☐ | ☐ |

---

## Search / Filter Basics

| # | Check | Pass | Fail |
|---|-------|------|------|
| 19 | Search UI accessible | ☐ | ☐ |
| 20 | Search for known task → results | ☐ | ☐ |
| 21 | Search for non-existent → empty state (no crash) | ☐ | ☐ |

---

## Admin / Settings Sanity

| # | Check | Pass | Fail |
|---|-------|------|------|
| 22 | Settings / Application loads | ☐ | ☐ |
| 23 | Settings / Board (or equivalent) loads | ☐ | ☐ |
| 24 | Forms render correctly | ☐ | ☐ |

---

## Theme / Responsive

| # | Check | Pass | Fail |
|---|-------|------|------|
| 25 | Light theme applies | ☐ | ☐ |
| 26 | Dark theme applies | ☐ | ☐ |
| 27 | Auto theme (if available) applies | ☐ | ☐ |
| 28 | Narrow width (~375px) layout usable | ☐ | ☐ |
| 29 | No horizontal scroll at mobile width | ☐ | ☐ |

---

## Basic Navigation

| # | Check | Pass | Fail |
|---|-------|------|------|
| 30 | Dashboard link works | ☐ | ☐ |
| 31 | Project/board navigation works | ☐ | ☐ |
| 32 | Breadcrumb or back navigation works | ☐ | ☐ |
| 33 | User menu / logout accessible | ☐ | ☐ |

---

## Summary

| Total Pass | Total Fail | Blockers |
|------------|------------|----------|
| _/_ | _/_ | _list any_ |

**Ready for release?** ☐ Yes ☐ No — _reason_
