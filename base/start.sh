#!/bin/bash
exec /bin/multirun "caddy run --config /app/Caddyfile" "$BASE_START"
