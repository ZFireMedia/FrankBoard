# FrankBoard Migration to New VPS (66.179.208.122)

This guide covers moving FrankBoard from the current VPS (209.46.122.129) to the new, smaller VPS at **66.179.208.122**.

---

## New VPS Details

- **IP**: 66.179.208.122
- **Root access**: Yes
- **Current use**: Idle (no conflicting services)

---

## Prerequisites to Verify on New VPS

SSH in first:

```bash
ssh root@66.179.208.122
```

Then run:

```bash
# 1. Docker installed?
docker --version
docker compose version

# 2. Disk space
df -h /

# 3. Port 80 or 8080 available?
ss -tlnp | grep -E ':80|:8080|:8888'

# 4. Public IP matches
curl -s ifconfig.me
```

---

## Option A: Fresh Install (No Data Migration)

If you don't need to keep existing FrankBoard projects/tasks:

```bash
ssh root@66.179.208.122

# Install Docker if missing (Ubuntu/Debian)
apt update && apt install -y docker.io docker-compose-plugin

# Clone FrankBoard
cd /root
git clone https://github.com/zfiremedia-stack/FrankBoard.git frankboard
cd frankboard

# Configure
cp .env.example .env
# Edit .env: set POSTGRES_PASSWORD (required for prod)
nano .env

# Start
docker compose up -d

# Verify
docker compose ps
curl -I http://localhost:8888/
```

**Access**: `http://66.179.208.122:8888` (ensure port 8888 is open in the provider firewall).

---

## Option B: Migrate Data from Old VPS

If you want to keep existing FrankBoard data (projects, tasks, users):

### 1. On OLD VPS (209.46.122.129)

```bash
cd /root/frankboard

# Backup PostgreSQL
docker compose exec db pg_dump -U kanboard kanboard > /tmp/frankboard_backup.sql

# Backup app data (attachments, cache)
docker compose exec app tar czf - -C /var/www/app data > /tmp/frankboard_data.tar.gz

# Copy to new VPS (run from your local machine or old VPS)
scp /tmp/frankboard_backup.sql root@66.179.208.122:/root/
scp /tmp/frankboard_data.tar.gz root@66.179.208.122:/root/
```

### 2. On NEW VPS (66.179.208.122)

```bash
# Install Docker, clone FrankBoard (see Option A)
cd /root/frankboard
cp .env.example .env
nano .env  # set POSTGRES_PASSWORD

# Start stack (creates fresh DB)
docker compose up -d

# Wait for DB to be ready
sleep 15

# Restore PostgreSQL
docker compose exec -T db psql -U kanboard kanboard < /root/frankboard_backup.sql

# Restore app data
docker compose exec app sh -c "cd /var/www/app && tar xzf -" < /root/frankboard_data.tar.gz

# Fix permissions (Kanboard runs as nginx)
docker compose exec app chown -R nginx:nginx /var/www/app/data

# Restart app to pick up restored data
docker compose restart app
```

---

## Firewall: Open Port 8888

On the new VPS provider’s control panel, add an **inbound** rule:

- **Protocol**: TCP
- **Port**: 8888
- **Source**: 0.0.0.0/0

If the provider blocks non-standard ports, use `APP_PORT=80` in `.env` (ensure nothing else uses port 80).

---

## Decommission Old FrankBoard (After Migration)

On the old VPS (209.46.122.129):

```bash
cd /root/frankboard
docker compose down
# Optionally remove volumes: docker compose down -v
```

---

## Summary Checklist

| Step | Action |
|------|--------|
| 1 | SSH to 66.179.208.122, verify Docker |
| 2 | `git clone` FrankBoard, create `.env` |
| 3 | `docker compose up -d` |
| 4 | Open port 8888 in provider firewall |
| 5 | (Optional) Migrate backup from old VPS |
| 6 | Access `http://66.179.208.122:8888` |
| 7 | Change default admin password |
| 8 | Stop FrankBoard on old VPS when ready |
