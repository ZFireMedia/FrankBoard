#!/bin/bash
# Deploy FrankBoard static marketing site to /var/www/frankboard-site
# Run from FrankBoard repo root on VPS (e.g. after git pull)
# Serves frankboard.com. Does NOT touch the app (app.frankboard.com / port 8080)

set -e
REPO="$(cd "$(dirname "$0")/.." && pwd)"
SITE_SRC="$REPO/site"
SITE_DEST="/var/www/frankboard-site"
NGINX_CONF="$REPO/config/nginx/frankboard.com.conf"

echo "=== FrankBoard static site deploy ==="

# Create destination directory
mkdir -p "$SITE_DEST"

# Copy site files (preserves structure: index.html, editions/, assets/, etc.)
echo "Copying site files..."
cp -r "$SITE_SRC"/* "$SITE_DEST/"
echo "  -> $SITE_DEST"

# Install nginx config if present
if [ -f "$NGINX_CONF" ]; then
    echo "Installing nginx config..."
    cp "$NGINX_CONF" /etc/nginx/sites-available/frankboard.com.conf
    if [ ! -L /etc/nginx/sites-enabled/frankboard.com.conf ]; then
        ln -sf /etc/nginx/sites-available/frankboard.com.conf /etc/nginx/sites-enabled/
    fi
    echo "  -> sites-enabled/frankboard.com.conf"
else
    echo "  (No nginx config at $NGINX_CONF — config may exist already)"
fi

# Test and reload nginx
echo "Testing nginx config..."
nginx -t
echo "Reloading nginx..."
systemctl reload nginx

echo "=== Site deploy complete. Verify at https://frankboard.com ==="
