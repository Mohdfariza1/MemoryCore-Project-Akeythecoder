# Decision Log Protocol

## Purpose
Append-only record of non-obvious decisions — captures context, what was chosen vs rejected, and why. Survives session compaction.

## Storage
- Global technical decisions: `memory/decisions.md`
- Per-project decisions: `memory/Projects/{slug}/decisions.md` (create if needed)

## When to Log
Log a decision when:
- A trade-off was made (chose X over Y)
- A tech/architecture choice was made
- A rejected alternative had merit
- Future-{AGENT_NAME} would ask "why did we do it this way?"

Do NOT log: obvious choices, style preferences, trivial fixes.

## Entry Format
```markdown
### [{YYYY-MM-DD}] {Decision Title}
**Project**: {project name or "global"}
**Context**: {situation that prompted the decision}
**Decision**: Chose `{X}` over `{Y}` (and `{Z}` if applicable)
**Rationale**: {why — constraints, tradeoffs, requirements}
**Consequences**: {what this means going forward}
```

## Commands

### `log decision` or `{AGENT_NAME} log decision`
1. Identify the decision just made in conversation
2. Fill out entry format above
3. Append to appropriate decisions.md (NEVER edit past entries)
4. Confirm: "Decision logged."

### `why did we choose [X]?`
1. Search decisions.md (global + current project) for [X]
2. Return matching entries as narrative
3. If not found: say so — never fabricate

## Rules
- **Append-only**: never edit or delete past entries
- If a decision is reversed: log a NEW entry referencing the original by date
- Search decisions.md before making similar choices in future sessions

## Auto-Behavior
After any significant architecture or tech choice in a session, prompt:
> "Worth logging that decision? [yes/skip]"
If {USER_NAME} says yes or doesn't respond negatively → log it.
