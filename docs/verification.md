# FrankBoard Verification Guide

## Prerequisites

- Docker and Docker Compose installed
- Port 8080 available (or set `APP_PORT` in `.env`)

## Quick Verify

```bash
# From project root
cp .env.example .env
docker compose up -d

# Wait for healthchecks (~15–30 seconds)
docker compose ps
# Both frankboard and frankboard-db should show "healthy"

# Open in browser
# http://localhost:8080
# Default login: admin / admin (change immediately)
```

## Health Check Endpoint

```bash
curl http://localhost:8080/healthcheck.php
# Expected: {"status":200, "message":"Database connection is OK"}
```

## Verification Checklist

- [ ] `docker compose up -d` completes without errors
- [ ] `frankboard` and `frankboard-db` containers are running and healthy
- [ ] http://localhost:8080 loads the login page
- [ ] Login with admin/admin succeeds
- [ ] Create a test project and add a task
- [ ] `/healthcheck.php` returns 200 OK

## Troubleshooting

| Issue | Action |
|-------|--------|
| Port 8080 in use | Set `APP_PORT=8081` (or other) in `.env` |
| DB connection refused | Ensure `frankboard-db` is healthy; check `docker compose logs db` |
| Login fails | Verify migrations ran; check `docker compose logs app` |
| Image not found | Ensure `kanboard/kanboard:v1.2.51` exists: `docker pull kanboard/kanboard:v1.2.51` |

## Verification Status

**Date**: 2025-03-13  
**Environment**: Docker not available on build machine at setup time  
**Compose file**: Ready; manual verification needed when Docker is available
