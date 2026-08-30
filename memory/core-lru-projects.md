# LRU Project Management Protocol

## Purpose
Track active projects in Least Recently Used order. Most recent = #1. Max 10 active; #11 auto-archives.

## Storage
- Active list: `memory/projects-lru.md`
- Per-project profile: `memory/Projects/{slug}.md` (uses existing `_template.md`)

## LRU Entry Format
```
## [{POSITION}] {PROJECT_NAME}
- **Slug**: {slug}
- **Stack**: {stack}
- **Last Active**: {YYYY-MM-DD}
- **Status**: active | paused | archived
- **Profile**: [link](./Projects/{slug}.md)
```

## Commands

### `{AGENT_NAME} project new [name]`
1. Create profile from `memory/Projects/_template.md`
2. Prepend as #1 in `memory/projects-lru.md`
3. Renumber all entries
4. If count > 10: move #11 to archived section with status: archived

### `{AGENT_NAME} project load [name]`
1. Fuzzy-match name against projects-lru.md
2. Read matching profile from `memory/Projects/{slug}.md`
3. Move matched project to #1 position
4. Renumber all entries

### `{AGENT_NAME} project save`
1. Update current project's profile with session changes
2. Update `last-active` date in projects-lru.md
3. Run self-evolution check

### `{AGENT_NAME} project list`
1. Read and display `memory/projects-lru.md`
2. Show: position, name, stack, last active, status

## Auto-Behavior
- On session start: if a project is active, note it as #1 after loading
- On task completion: auto-update last-active date for current project
- Never delete archived projects — only change status

## File Size Limit
If a project profile exceeds 500 lines: summarize older session entries, preserve last 3 sessions in full.
