# Boardroom

Boardroom booking mobile client. Talks only to the Express API at `API_BASE_URL`
in `env/dev.json` (bundled). No Supabase keys in the app.

## Run

```bash
cd mobile && flutter run
```

Use Cursor’s Run and Debug panel (`.vscode/launch.json`) for debug, profile, or
release. Put the server’s Reachable address in `env/dev.json` before running on
a phone on the same Wi‑Fi.
