#!/usr/bin/env bash
# Run the mobile app against the local Express API.
# Requires: backend listening on BACKEND_PORT (default 5000).
# On Android: also run tool/connect_backend.sh (or let this script do it).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PORT="${BACKEND_PORT:-5000}"
ENV_FILE="${ENV_FILE:-$ROOT/.env}"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing $ENV_FILE" >&2
  exit 1
fi

BASE_URL="$(awk -F= '$1=="API_BASE_URL" { print $2; exit }' "$ENV_FILE")"
BASE_URL="${BASE_URL:-http://127.0.0.1:${PORT}}"
BASE_URL="${BASE_URL%/}"

echo "Checking backend at ${BASE_URL}/health ..."
health="$(curl -sS -m 5 "${BASE_URL}/health" || true)"
if [[ "$health" != *'"ok":true'* ]]; then
  echo "Backend is not reachable at ${BASE_URL}." >&2
  echo "Start it with: cd backend && npm run dev" >&2
  exit 1
fi
echo "Backend OK: $health"

if command -v adb >/dev/null 2>&1 || [[ -x "${ANDROID_HOME:-$HOME/Android/Sdk}/platform-tools/adb" ]]; then
  if "$ROOT/tool/connect_backend.sh" 2>/dev/null; then
    echo "ADB reverse is ready."
  else
    echo "No Android device on ADB (desktop/web runs do not need reverse)."
  fi
fi

cd "$ROOT"
exec flutter run "$@"
