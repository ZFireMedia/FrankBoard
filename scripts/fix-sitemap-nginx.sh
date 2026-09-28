#!/bin/bash
# Add explicit sitemap.xml location to frankboard.com nginx config
# Run on VPS. Inserts before "location / {"

set -e
CONF="/etc/nginx/sites-available/frankboard.com.conf"

# Only add if not already present
if grep -q 'location = /sitemap.xml' "$CONF"; then
    echo "sitemap location already present"
    exit 0
fi

# Insert sitemap location before "location / {"
perl -i -0pe "s/(location \/ \{)/    location = \/sitemap.xml {\n        default_type application\/xml;\n        add_header Cache-Control \"public, max-age=3600\";\n    }\n\n    \$1/s" "$CONF"

echo "Added sitemap location"
nginx -t
systemctl reload nginx
echo "Done"
