# FrankBoard Migration Page Copy v1

**Status**: Draft  
**Source**: docs/marketing/migration-page-v1.md

---

## Headline

**Migrate from Kanboard**

## Subhead

Your data, plugins, and workflows stay intact. Migration is reversible.

---

## Reassurance Intro

Moving from Kanboard to FrankBoard is straightforward. FrankBoard uses the same database schema and plugin API as Kanboard. You backup your data, point FrankBoard at your database, and verify. You can also migrate back if needed — your data isn’t locked in.

**What stays the same:**
- Database schema (SQLite, MySQL, PostgreSQL)
- Plugin API and most plugins
- Config patterns (`config.php`, env vars)
- Your projects, tasks, and users

---

## Step-by-Step Migration

1. **Backup your Kanboard data.** Export your database. Keep a copy somewhere safe.

2. **Install FrankBoard.** Use Docker, or deploy FrankBoard alongside your existing setup.

3. **Point FrankBoard at your database.** Configure `DATABASE_URL` (or equivalent) to use your Kanboard database. FrankBoard will use the existing schema.

4. **Verify.** Log in. Check projects, tasks, and columns. Confirm plugins if you use them.

5. **Switch over.** When satisfied, retire the old Kanboard instance and use FrankBoard.

**Reversing:** Restore your backup to Kanboard. Your data is standard SQL — no lock-in.

---

## Compatibility Section

| Component | Compatibility | Notes |
|-----------|----------------|-------|
| Database | Full | Same schema. PostgreSQL preferred for new installs. |
| Plugins | High | Same API. Validate per plugin before migration. |
| Config | High | `config.php`, env vars align with Kanboard. |
| Themes | Partial | FrankBoard uses its own CSS. Stock Kanboard themes may need adjustment. |

---

## Plugin Caveat Section

**About plugins**

FrankBoard uses the Kanboard plugin API. Most plugins work. We don’t test every plugin. Before migrating, test your critical plugins in a staging environment. We document known compatibility where we can. If something breaks, open an issue and we’ll look into it.

**We do not guarantee 100% plugin compatibility.** Edge cases exist. Test first.

---

## Support CTA

**Need help with migration?** We offer migration assistance: backup review, config help, and verification. [Contact us for migration assistance →]

**Prefer to do it yourself?** [Get Community Free] and follow the steps above.

---

## Sidebar / Secondary CTA

[Compare FrankBoard vs Kanboard] — See how we differ and what stays the same.
