# Meeting Analysis Skill

> Analyse meeting recordings and extract key points using AI tools (free workflow).

---

## When to Use
- After any meeting (client, team, planning session)
- When you need to document what was discussed
- When you need action items from a long call
- When you want a summary to share with others

---

## Step-by-Step Workflow

### Step 1 — Transcribe the Recording (Free)

| Tool | Free Tier | Best For |
|---|---|---|
| **Otter.ai** | 300 min/month | Easiest — just upload and wait |
| **Microsoft Word** | Free (if you have Office) | Dictate → Transcribe feature |
| **Whisper (Google Colab)** | Free | Best accuracy, slightly technical |
| **YouTube auto-captions** | Free | Upload as unlisted → download captions |

**Recommended**: Otter.ai for ease, Whisper for accuracy.

### Step 2 — Copy the Transcript

Copy the full transcript text from whichever tool you used.

### Step 3 — Paste into Claude

Use **Claude Sonnet 4.6** — best balance of speed and cost for this task.
- Website: claude.ai (free plan works)
- API model ID: `claude-sonnet-4-6`

### Step 4 — Use This Prompt

```
Here is the transcript from a meeting:

[paste transcript here]

Please do the following:
1. Identify the important points discussed
2. List any decisions made
3. List any action items and who is responsible
4. Write everything as clear bullet points grouped by topic
```

---

## Output Format (What to Expect)

Claude will return something like:

```
## Key Points
- [Topic 1]: ...
- [Topic 2]: ...

## Decisions Made
- ...

## Action Items
- [ ] Task — Person responsible
- [ ] Task — Person responsible
```

---

## Model Choice

| Task | Model | Why |
|---|---|---|
| Meeting analysis | **Sonnet 4.6** | Summarization task, fast, cost-efficient |
| Very long transcript (100K+ tokens) | **Sonnet 4.6** | 1M context window handles it |
| Need 100+ page detailed report | **Fable 5** | Only if extremely complex reasoning needed |

**Rule**: Sonnet 4.6 is almost always enough for meetings.

---

## Cost

- **Transcription**: Free (Otter.ai free tier)
- **Claude.ai website**: Free plan available
- **Claude API**: ~$0.003 per meeting transcript (very cheap)

---

## Trigger

When user says **"analyse meeting"** or **"meeting analysis"** or **"summarise recording"**:
1. Ask for the transcript (or help them transcribe first)
2. Apply the Step 3 prompt above
3. Return structured bullet points grouped by topic
