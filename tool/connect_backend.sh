#!/usr/bin/env bash
# Forward the phone's localhost ports to this machine over ADB.
# 5000 is the old API port. 54321 is the local Supabase API.
# Works for USB and wireless ADB (adb connect <ip>:<port>) the same way.
set -euo pipefail

PORT="${BACKEND_PORT:-5000}"
API_PORT="${SUPABASE_PORT:-54321}"
ADB="${ADB:-${ANDROID_HOME:-$HOME/Android/Sdk}/platform-tools/adb}"
if [[ ! -x "$ADB" ]]; then
  if command -v adb >/dev/null 2>&1; then
    ADB="$(command -v adb)"
  else
    echo "adb not found. Expected $ADB" >&2
    exit 1
  fi
fi

mapfile -t devices < <("$ADB" devices | awk 'NR > 1 && $2 == "device" { print $1 }')
if [[ ${#devices[@]} -eq 0 ]]; then
  echo "No Android device is connected over ADB." >&2
  echo "Turn on Wireless debugging, then: $ADB connect <phone-ip>:<port>" >&2
  exit 1
fi

for serial in "${devices[@]}"; do
  "$ADB" -s "$serial" reverse "tcp:${PORT}" "tcp:${PORT}"
  "$ADB" -s "$serial" reverse "tcp:${API_PORT}" "tcp:${API_PORT}"
  echo "$serial: phone http://127.0.0.1:${PORT} -> this machine :${PORT}"
  echo "$serial: phone http://127.0.0.1:${API_PORT} -> this machine :${API_PORT}"
done
"$ADB" reverse --list
