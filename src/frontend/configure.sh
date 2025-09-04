#!/bin/sh
set -e

envsubst '${BACKEND_URL}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

cat > /usr/share/nginx/html/config.js << EOF
window.APP_CONFIG = {
    backendUrl: '${BACKEND_URL:-http://localhost:8080}'
};
EOF
