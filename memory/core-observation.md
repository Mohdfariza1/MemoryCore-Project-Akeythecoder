# Observation Protocol

## Purpose
Structured code awareness at 4 depth tiers. Match observation depth to actual need — frequent cheap surveys prevent expensive deep audits.

## Tiers

### Lv.1 — Survey (~30 sec, low cost)
Quick health check. Run often.
- Scan file structure & recent changes
- Check for obvious issues: missing files, broken imports, TODO/FIXME flags
- Output: 5-bullet health summary

### Lv.2 — Investigate (~5 min, medium cost)
Deep dive into a specific area, file, or bug.
- Read target files fully
- Trace data flow, check edge cases, review logic
- Output: findings + recommended actions

### Lv.2 — Refine (~5 min, medium cost)
Review changed code for quality, then fix.
- Run after completing a feature or fix
- Check: correctness, security, simplicity, style consistency
- Output: issues found + fixes applied (with permission)
- Connects to: Review Protocol (`core-review-protocol.md`)

### Lv.3 — Audit (~15 min, high cost)
Full system analysis. Run sparingly.
- Architecture mapping, dependency check, security scan, performance review
- Cross-references: post-mortems, decision log, pattern library
- Output: full report with severity-ranked findings
- Connects to: Security Protocol (`core-security-protocol.md`)

## Fact Gate (before the first edit to any existing file, ~1 min)
Reading the file is not enough. Before the first Edit/Write to a file, answer three things:
1. **Who uses it** — grep for importers and callers. A change here breaks them, not just this file.
2. **What the data really is** — check the schema, type, or DB column, not the variable name. The name says `price`; the column may say `price_cents`.
3. **What was actually asked** — re-read the request. If the edit goes beyond it, say so before making it.

On Windows, also check line endings (`file <path>`) before any shell-based rewrite. CRLF files get Python binary-mode edits, never `sed -i`.
Skip the gate only for a file created in this session.

## Escalation Logic
Survey → finds issues → escalate to Investigate
Investigate → finds systemic problems → escalate to Audit
Refine → finds security issues → escalate to Audit

## Commands

### `{AGENT_NAME} survey`
Run Lv.1 Survey on current project directory.

### `{AGENT_NAME} investigate [target]`
Run Lv.2 Investigation on [target] (file, feature, bug, area).

### `{AGENT_NAME} refine`
Run Lv.2 Refine on recently changed code.

### `{AGENT_NAME} audit`
Run Lv.3 Audit on full project. Confirm with {USER_NAME} before starting (it's expensive).

## Auto-Behavior
- Fact Gate runs before the first edit to any existing file
- After every significant feature: auto-run Refine (same as review protocol)
- If Survey finds Critical issues: immediately propose escalation to Investigate
- Passive observation: note recurring patterns in {USER_NAME}'s code for self-evolution

## Cost Awareness
Always state the tier and estimated effort before starting. For Audit, ask:
> "Full audit will take ~15 min and a lot of context. Proceed? [yes/no]"
