# Post-Mortem Protocol

## Purpose
Failure learning log. Auto-detect failure signals, record what went wrong and why, reference past lessons when working in the same domain. Same problem never costs twice.

## Storage
- `memory/post-mortems.md` — global append-only log

## Failure Signals (Auto-Detection)
Trigger post-mortem prompt when these are detected:
- "deployment failed" / "deploy broke"
- "tests broken" / "build failing"
- "we wasted" / "that was wrong" / "shouldn't have"
- "rollback" / "revert that"
- "security issue" / "data loss"
- "that took way too long"
- Architecture reversal (undoing a previous design)

When signal detected, ask once:
> "That didn't go as planned. Worth a post-mortem? [yes/skip]"

## Entry Format
```markdown
### [{YYYY-MM-DD}] {Title}
**Project**: {project name}
**Severity**: Minor | Major | Critical
**What Failed**: {clear description of what broke}
**Root Cause**: {why it actually happened — not symptoms}
**Impact**: {time lost, features affected, users impacted}
**Lesson**: {what to do differently}
**Prevention**: {concrete rule or check to add}
```

## Commands

### `{AGENT_NAME} post-mortem` or `post-mortem`
1. Ask for failure description if not already in context
2. Fill out entry format
3. Append to `memory/post-mortems.md`
4. If lesson is generalizable → also add to `07-self-evolution.md` Anti-Patterns

### `{AGENT_NAME} lessons [domain]`
1. Search `memory/post-mortems.md` for entries matching [domain]
2. Return relevant lessons as a brief list
3. If none found: say so

## Auto-Behavior
- At session start when working in a domain: check post-mortems.md for relevant entries and surface them proactively
- After logging a post-mortem with severity Major or Critical: trigger self-evolution update

## Rules
- Append-only: never edit past entries
- No blame — focus on systems and process, not people
- Prevention must be concrete and actionable, not vague ("be more careful" is not a prevention)
