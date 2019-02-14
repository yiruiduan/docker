#!/bin/sh
sed -ri "s/NGX_PORT/${PORT:-80}/" /etc/nginx/nginx.conf
sed -ri "s#NGX_DOC_ROOT#${NGX_DOC_ROOT:-/usr/share/nginx/html}#" /etc/nginx/nginx.conf
sed -ri "s#SER_NAME#${NGX_SERVER_NAME:-localhost}#" /etc/nginx/nginx.conf
exec "$@"
