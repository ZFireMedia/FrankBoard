# Rollback and Compatibility

## Rollback Procedures

### Revert to Upstream Kanboard

If FrankBoard changes cause issues:

1. **Docker users**: Switch to upstream compose:
   ```bash
   docker compose -f docker-compose.postgres.yml up -d
   ```
   Or use `docker-compose.sqlite.yml` / `docker-compose.mysql.yml` for other DBs.

2. **Keep data**: FrankBoard volumes (`app_data`, `app_plugins`, `db_data`) are compatible with Kanboard. Mount them into a Kanboard container if needed.

3. **Remove FrankBoard-specific files** (optional): `docker-compose.yml`, `.env`, `docs/`, `PROJECT_STATUS.md`, `ACTION_LOG.md`, `README-FRANKBOARD.md` are additive. Deleting them does not affect the underlying Kanboard app.

### Downgrade Kanboard Version

To pin to an older Kanboard release:

```bash
# In .env
KANBOARD_IMAGE=kanboard/kanboard:v1.2.50
```

Then `docker compose up -d`. Review [Kanboard ChangeLog](https://github.com/kanboard/kanboard/blob/main/ChangeLog) for breaking changes before downgrading.

## Compatibility Notes

| Component | FrankBoard | Upstream Kanboard |
|-----------|------------|-------------------|
| Database schemas | Same | Same |
| Plugin API | Same | Same |
| Config options | Same | Same |
| Docker images | Uses `kanboard/kanboard` | Same |
| Data volumes | Compatible | Compatible |

FrankBoard does not modify Kanboard's application code in Phase 1. All compatibility guarantees of upstream Kanboard apply.

## Data Migration

- **SQLite → PostgreSQL**: Use Kanboard migration docs; export from SQLite, import to PostgreSQL.
- **MySQL → PostgreSQL**: Same as above; Kanboard supports both.
- **PostgreSQL → PostgreSQL**: Point new instance at existing DB (backup first) or use pg_dump/pg_restore.
