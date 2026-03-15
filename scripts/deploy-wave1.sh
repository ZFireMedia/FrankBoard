#!/bin/bash
# Deploy Wave 1 to staging VPS
# Run from FrankBoard repo root on the VPS (e.g. after git pull)
# Requires: Docker, Docker Compose, SSH access to this machine

set -e
cd "$(dirname "$0")/.."

echo "=== FrankBoard Wave 1 deploy ==="
echo "Building image (includes CSS build)..."
docker build -t frankboard:wave1 .

echo "Updating .env to use Wave 1 image..."
# Create or update .env with KANBOARD_IMAGE override
if [ -f .env ]; then
  if grep -q "^KANBOARD_IMAGE=" .env; then
    sed -i.bak 's|^KANBOARD_IMAGE=.*|KANBOARD_IMAGE=frankboard:wave1|' .env
  else
    echo "KANBOARD_IMAGE=frankboard:wave1" >> .env
  fi
else
  cp .env.example .env 2>/dev/null || true
  echo "KANBOARD_IMAGE=frankboard:wave1" >> .env
fi

echo "Recreating containers..."
docker compose down
docker compose up -d

echo "Waiting for app to be healthy..."
sleep 5
docker compose ps

echo "=== Deploy complete. Verify at http://$(hostname -I | awk '{print $1}'):8080 ==="
