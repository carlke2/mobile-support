COMPLETE ALL DASHBOARDS FOR FIRST TESTING. The mobile app talks ONLY to the
backend via API_BASE_URL. No Supabase, no database strings, no keys. No commits,
no git commands, never print secrets, tokens or passwords. List the files you will
touch first. Label every claim VERIFIED (you ran it) or NOT VERIFIED. Build only
against routes and shapes in docs/API.md; if a field or route is missing or
differs, report it instead of guessing. Keep the existing palette and every colour
in app_tokens.dart.

CONTEXT: the backend is finished and four seeded roles exist: USER, AGENT,
TEAM_LEAD, ADMIN. Sign-up is disabled; accounts are created by an admin.

1. CLEAN-UP
   - Remove Create account / register from the UI, router, repository and tests.
     Keep Sign in and Forgot password.
   - Android: android:allowBackup="false" plus data extraction rules excluding
     everything; cleartext only in the debug manifest.
2. API LAYER (one typed client per area, freezed models, parsed exactly as in
   docs/API.md)
   - DashboardApi: /dashboard/user, /dashboard/staff, /dashboard/admin.
   - TicketsApi: list (filters, keyset paging), detail, create, comment,
     transition, rate. RoomsApi and BookingsApi: rooms, day view, create, cancel,
     mine. NotificationsApi: list, unread count, mark read, mark all read.
   - Map error codes everywhere: token_expired (refresh once, retry),
     refresh_invalid and token_invalid (sign out with the expired message),
     forbidden ("not allowed", no sign out), not_found, conflict (show the clash
     with the conflicting booking), validation (show the message). 5xx and network
     failures never sign anyone out.
3. DASHBOARDS: one call per screen, hero glass metric card, count pills, segmented
   control where a screen has two views, bottom navigation, minimal layout.
   USER (/home): hero = open tickets; awaiting my reply, next booking, recent
     tickets, unread alerts; New ticket button.
     Tabs: Home, Tickets, Rooms (only if the backend setting allows customers to
     book), Alerts, Profile.
   AGENT (/staff): hero = my queue; unassigned, SLA at risk, SLA overdue, waiting
     on customer. Tabs: Queue, Tickets, Rooms, Alerts, Profile.
   TEAM_LEAD (/staff): agent view plus team workload by agent, SLA compliance, CSAT
     average. Tabs: Queue, Team, Rooms, Alerts, Profile.
   ADMIN (/admin): hero = summary; by status, by priority, trend, SLA, workload,
     CSAT, today's bookings, user count. Tabs: Overview, Tickets, Bookings, Users,
     Profile.
   Every card is tappable and opens the matching list with the filter applied
   (for example SLA at risk opens tickets filtered to at-risk).
4. SCREENS BEHIND THE CARDS (minimal, same widgets)
   - Tickets: list with status filter, search and keyset paging; detail with the
     comment thread (internal notes visible to staff only, clearly marked); create
     ticket (subject, description, category, priority); reply; customers can rate a
     resolved ticket; staff can change status through the allowed transitions and
     see SLA state and assignee.
   - Rooms and bookings: room list, day view with free slots, create booking (show
     the clash message from the backend), my bookings, cancel. Admin Bookings tab
     shows today's bookings.
   - Alerts: notification list, unread badge on the tab, mark read and mark all read.
   - Users (admin): read-only user count and list if the API exposes it; otherwise a
     clearly labelled "not available yet" and list it in your report.
   - Profile (every role): name, email, role, support phone from config, Sign out.
     Sign out clears secure storage and all cached data and goes to /welcome.
5. NAVIGATION AND SESSION
   - Each role reaches only its own route tree; other private routes redirect to
     its own dashboard. The backend enforces the real rules.
   - Back on a non-home tab goes to the home tab; back on the home tab minimizes
     the app; detail screens pop to their list. Login and welcome are unreachable
     while signed in and never in the back stack.
   - Tokens, role and profile stay in flutter_secure_storage. Cold start restores
     the session and opens the role dashboard with no login flash. Cache the last
     dashboard response per role (counts only, no ticket text) for instant paint,
     with an "Offline, retrying" banner and backoff retry on network failure.
6. QUALITY
   - Skeleton loading, pull to refresh, empty and error states on every screen;
     44px touch targets, text scale to 1.3, Semantics labels.
   - ListView.builder with pagination from config; const widgets; Riverpod select;
     blur limited to hero cards and the nav bar; dispose controllers.
7. TESTS (full suite must pass)
   - Each dashboard parses the example JSON from docs/API.md and renders its widgets.
   - Each role lands on its dashboard and cannot open another role's routes.
   - forbidden does not sign out; token_expired refreshes once; refresh_invalid
     signs out; network failure keeps the session and shows the banner.
   - Back behaviour per case above; Profile and Sign out exist for every role.
   - Booking clash shows the backend message; internal notes hidden for USER.
   - No "supabase" or "anon" in lib/, pubspec.yaml or env; register code is gone.
8. REPORT: files changed; exact flutter analyze and flutter test counts; a table of
   role vs tab vs backend route vs status (real data, empty state, or blocked);
   every gap or mismatch against docs/API.md; and what is NOT VERIFIED because it
   needs the phone and seeded accounts. Stop. Do not build push notifications.
