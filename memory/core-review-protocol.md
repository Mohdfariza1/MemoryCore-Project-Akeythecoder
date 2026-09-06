# Review Protocol
> Self-review checklist before delivering code. Run after every significant task.

## When to Run
- After multi-file changes
- After new feature implementation
- After payment/auth/security-related changes
- After database schema changes
- Before saying "done" to {USER_NAME}

---

## Checklist

### 0. Planning Gate ⛔
- [ ] `Planning.md` exists in project root — if not, **stop and create it first**
- [ ] Planning.md has: Overview, Stack, Structure, Flow Plan, Estimated Delivery
- [ ] No code was written before Planning.md existed

### 1. Variables & Types
- [ ] All variables initialized before use
- [ ] No undefined variable warnings
- [ ] Type definitions updated (if using TypeScript)

### 2. Security
- [ ] **SQL Injection** — parameterized queries or ORM only, never string concat
- [ ] **XSS** — user content escaped before render, no dangerouslySetInnerHTML with user data
- [ ] **RCE** — no eval/exec/shell_exec with user input, no dynamic require from user paths
- [ ] **SSRF** — no outbound fetch to user-supplied URLs without domain allowlist + block internal IPs
- [ ] **IDOR** — every resource fetch/update/delete checks `owner_id === current_user.id`
- [ ] **Path Traversal** — file paths never built from user input, strip `../` always
- [ ] **Publicly accessible DB** — DB port not exposed, not default credentials
- [ ] No mass assignment vulnerability (use allowlists)
- [ ] CSRF exempted ONLY for payment/webhook callbacks
- [ ] File uploads validated (type, size, renamed to UUID)
- [ ] No sensitive data exposed to frontend (passwords, secrets, tokens)
- [ ] Auth middleware on all protected routes

### 3. Data Isolation (Multi-User / Multi-Tenant)
- [ ] Queries scoped by user/tenant/owner ID
- [ ] No cross-user data leaks in show/edit/delete routes
- [ ] Authorization check: user owns the resource before update/delete

### 4. File Uploads (if applicable)
- [ ] Using correct upload method for framework
- [ ] Old file deleted on re-upload
- [ ] Storage accessible (symlinks, permissions)
- [ ] Using relative paths (not hardcoded URLs)

### 5. Payment Integration (if applicable)
- [ ] Callback route CSRF-exempted
- [ ] Return route handles cross-site POST (session loss)
- [ ] Status only set to paid/active AFTER payment confirmation
- [ ] Transaction ID stored
- [ ] Duplicate payment prevention

### 6. Database
- [ ] Timestamp columns nullable (strict mode)
- [ ] No reserved table names (avoid framework conflicts)
- [ ] Foreign keys have proper `onDelete` behavior
- [ ] New columns have defaults or are nullable
- [ ] Migration is reversible

### 7. Frontend (if applicable)
- [ ] Forms work for both create AND edit
- [ ] Flash/toast messages display (success + error)
- [ ] Loading states on submit buttons
- [ ] Mobile responsive (no overflow, no hidden content)

### 8. Controller → View Data
- [ ] Controller passes ALL data the view/component uses
- [ ] No missing prop causing crash or blank page
- [ ] Pagination data included if using paginated queries

### 9. Routes
- [ ] New routes added to correct group
- [ ] Middleware applied (auth, role, subscription)
- [ ] Route names consistent with existing convention
- [ ] No duplicate route names or URIs

### 10. Edge Cases
- [ ] Empty state handled (no data yet)
- [ ] Deleted parent doesn't crash child queries
- [ ] Concurrent access handled (lock for update on stock/balance)
- [ ] Soft-deleted records excluded from active lists

### 11. Silent Failures
- [ ] No empty `catch {}` — every catch handles, rethrows, or logs with context
- [ ] No fallback that hides a failure (`.catch(() => [])`, `?? 0`, `|| "N/A"` on a failed fetch) — an empty result must look different from an error
- [ ] Wrapped errors unwrapped before matching — ORMs and fetch libraries nest the real error (Drizzle: `err.cause.code`, not `err.code`)
- [ ] Network, file and DB calls have a timeout and a failure path
- [ ] Multi-step writes run in a transaction with rollback
- [ ] The user sees a message on failure — never a silent 500 or a form that "just resets"
- [ ] Logs carry enough context to find the row (id, user, action), not just "error"

---

## Verification Order (before saying "done")
Run in this order. Stop at the first failure and fix it before moving on. Type-checks prove shape, not behaviour.
1. **Build** — `npm run build` (or the stack's equivalent). Tail the output and read it.
2. **Typecheck** — `npx tsc --noEmit` / `pyright`.
3. **Lint** — `npm run lint` / `ruff check`. Never weaken the lint config to pass. Fix the code.
4. **Tests** — if the project has them, run them. Do not write a suite just to tick this box.
5. **Secret + debug grep** — `sk-`, `api_key`, `password=`, `console.log` inside `src/`. Anything found is a blocker.
6. **Live run** — a row goes in and comes back out, a page renders, an action fires. DB-backed builds need this on a real cluster (see the throwaway Postgres skill in `07-self-evolution.md`). No live run, no "done".
7. **Diff review** — `git diff --stat`. Every changed file was meant to change. A size delta that does not match the edit is a red flag (CRLF, BOM, formatter).

---

## Quick Scan (3-Second Check)
For small changes, at minimum verify:
1. **Will it crash?** — Missing data, undefined vars, null references
2. **Is it safe?** — Auth check, data scoping, no injection
3. **Does it match?** — Existing code style, naming convention, UI pattern

---

## Stack-Specific Extras
<!-- Add your own stack-specific checks as you discover them -->
<!-- Example:
### Laravel + Blade
- [ ] @csrf in forms
- [ ] @method('PUT') for update forms
- [ ] old() values in form inputs

### React + Inertia
- [ ] router.post with _method for file upload updates
- [ ] preserveScroll on delete actions
- [ ] Error display from page props
-->
