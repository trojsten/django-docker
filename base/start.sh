#!/bin/bash
exec /bin/multirun "caddy run --config /base/Caddyfile" "$BASE_START"
