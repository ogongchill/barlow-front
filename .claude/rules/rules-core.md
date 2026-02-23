---
paths:
  - "core/**"
---

# Auth Feature Rules

- Treat auth flow changes as user-facing and failure-sensitive.
- Ensure token/session expiry cases produce a clear UX path.
- Avoid leaking transport/network concerns into presentation widgets.
- Provider changes must keep state transitions explicit and testable.