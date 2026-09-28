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
# Set ownership so nginx (www-data) can read — required to avoid 403 Forbidden
chown -R www-data:www-data "$SITE_DEST"
find "$SITE_DEST" -type d -exec chmod 755 {} \;
find "$SITE_DEST" -type f -exec chmod 644 {} \;
echo "  -> $SITE_DEST"

# Install nginx configs if present
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
APP_CONF="$REPO/config/nginx/app.frankboard.com.conf"
if [ -f "$APP_CONF" ]; then
    echo "Installing app subdomain config..."
    cp "$APP_CONF" /etc/nginx/sites-available/app.frankboard.com.conf
    ln -sf /etc/nginx/sites-available/app.frankboard.com.conf /etc/nginx/sites-enabled/
    echo "  -> sites-enabled/app.frankboard.com.conf"
fi

# Test and reload nginx
echo "Testing nginx config..."
nginx -t
echo "Reloading nginx..."
systemctl reload nginx

echo "=== Site deploy complete. Verify at https://frankboard.com ==="
