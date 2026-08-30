# Echo Memory Recall Protocol

## Purpose
Search session memory and project profiles for past context. Present findings as natural narrative. Never fabricate — search first, ask if nothing found.

## Storage Searched (in priority order)
1. Current project's `session-memory.md`
2. Current project profile `memory/Projects/{slug}.md`
3. `memory/decisions.md`
4. `memory/post-mortems.md`
5. `memory/07-self-evolution.md` (learned skills & anti-patterns)

## Trigger Phrases
- "do you remember [X]?"
- "recall [X]"
- "what did we decide about [X]?"
- "have we done [X] before?"
- "what happened with [X]?"

## Recall Process
1. Extract 2-4 keywords from the query
2. Search all storage files for keyword matches (prioritize exact → partial)
3. If found: narrate the finding in 2-4 sentences, cite the source file
4. If not found: say clearly — "I don't have a record of that. Can you give me more context?"

## Narration Format
> "Yes — on {date}, we {what happened}. {key detail}. This is recorded in {source}."

## Rules
- **Never fabricate** past context — only narrate what's in files
- If uncertain: say "I found something related — {X} — but I'm not sure if that's what you mean."
- Cite the source file so {USER_NAME} can verify
- If memory files don't exist yet for a project: say so and offer to create them

## Commands

### `recall [X]` or `do you remember [X]?`
Run the recall process above for query [X].

### `{AGENT_NAME} recall [X]`
Same as above, explicit trigger.

## Quality Note
Recall quality depends on what's been saved to session memory and project profiles. Better saves = better recall. Remind {USER_NAME} to run `{AGENT_NAME} project save` at session end.
