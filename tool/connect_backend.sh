#!/usr/bin/env bash
# Forward the phone's localhost port to this machine over ADB so the app
# can call the Express API at http://127.0.0.1:5000.
# Works for USB and wireless ADB (adb connect <ip>:<port>) the same way.
set -euo pipefail

PORT="${BACKEND_PORT:-5000}"
ADB="${ADB:-${ANDROID_HOME:-$HOME/Android/Sdk}/platform-tools/adb}"
if [[ ! -x "$ADB" ]]; then
  if command -v adb >/dev/null 2>&1; then
    ADB="$(command -v adb)"
  else
    echo "adb not found. Expected $ADB" >&2
    exit 1
  fi
fi

# Wireless mDNS serials can contain spaces (e.g. "adb-… (2)._adb-tls-connect._tcp").
# Fields are tab-separated: <serial>\t<status>
mapfile -t devices < <("$ADB" devices | awk -F '\t' 'NR > 1 && $2 ~ /^device/ { print $1 }')
if [[ ${#devices[@]} -eq 0 ]]; then
  echo "No Android device is connected over ADB." >&2
  echo "Turn on Wireless debugging, then: $ADB connect <phone-ip>:<port>" >&2
  exit 1
fi

for serial in "${devices[@]}"; do
  "$ADB" -s "$serial" reverse "tcp:${PORT}" "tcp:${PORT}"
  echo "$serial: phone http://127.0.0.1:${PORT} -> this machine :${PORT}"
done
"$ADB" reverse --list
