# Audio Transcription Skill

> Transcribe any audio or video into text, then process with Claude for any purpose.

---

## When to Use

- Voice notes, voice memos
- Client calls / sales calls
- Interviews, podcasts, lectures
- Meeting recordings (use `core-meeting-analysis.md` for structured meeting output)
- Video content (YouTube, reels, webinars)
- Any audio you want turned into usable text

---

## Trigger

When user says any of:
- **"transcribe this"**
- **"listen to this audio"**
- **"audio to text"**
- **"transcribe recording"**
- **"convert audio to text"**

---

## Step 1 — Choose Your Transcription Tool

| Tool | Free Tier | Language | Best For |
|---|---|---|---|
| **Whisper (local)** | Free, unlimited | BM + EN + 90+ langs | Best accuracy, offline |
| **Whisper (Google Colab)** | Free | BM + EN | Best accuracy, no install |
| **Otter.ai** | 300 min/month | EN only | Easiest for English |
| **YouTube auto-captions** | Free | Multi-language | Upload unlisted → download |
| **AssemblyAI** | 100 min free/month | EN + 15 langs | API integration, speaker diarization |
| **Deepgram** | $200 free credit | EN + multi | Developer-friendly, fast |

**Malaysia context**: Whisper handles BM, Manglish, and mixed BM/EN best. Use it if accuracy matters.

---

## Step 2 — Whisper (Google Colab, Free + Accurate)

Best option for most use cases. No install needed, free.

1. Go to [colab.research.google.com](https://colab.research.google.com)
2. Create a new notebook
3. Run this code:

```python
# Cell 1 — Install
!pip install openai-whisper

# Cell 2 — Upload your audio
from google.colab import files
uploaded = files.upload()  # upload your .mp3/.mp4/.wav/.ogg

# Cell 3 — Transcribe
import whisper
model = whisper.load_model("medium")  # use "large" for max accuracy
audio_file = list(uploaded.keys())[0]
result = model.transcribe(audio_file, language="ms")  # "ms" for BM, "en" for English, None for auto-detect
print(result["text"])
```

4. Copy the output text — that's your transcript

**Supported formats**: .mp3, .mp4, .wav, .ogg, .m4a, .webm

---

## Step 3 — Paste Transcript into Claude

After getting the transcript, paste it with one of these prompts based on what you need:

### General Summary
```
Here is an audio transcript:

[paste transcript]

Please:
1. Summarize the key points in bullet form
2. Highlight any important details or facts
3. Note anything that needs action or follow-up
```

### Sales Call Analysis
```
Here is a sales call transcript:

[paste transcript]

Please extract:
1. What the prospect said their problem is
2. Any objections raised
3. What was agreed or next steps
4. My rating: did I handle it well? Any missed opportunities?
```

### Interview / Q&A Extraction
```
Here is an interview transcript:

[paste transcript]

Please:
1. List each question asked
2. Summarize each answer in 1-2 sentences
3. Highlight the most valuable quotes or insights
```

### Content Repurposing (Audio → Post)
```
Here is a voice note or talk transcript:

[paste transcript]

Please turn this into a structured social media post:
- Hook (first line that grabs attention)
- Body (main story or insight)
- Call to action
- Tone: [casual / professional / storytelling]
- Language: [BM / EN / mixed]
```

### Lecture / Training Notes
```
Here is a lecture/training transcript:

[paste transcript]

Please:
1. Extract the main concepts taught
2. List key terms and their definitions
3. Summarize in structured notes format
4. Note any examples given
```

---

## Step 4 — Optional: Save the Output

If the transcript is important (client call, strategic meeting, etc.):
- Save summary to `session-memory.md` under relevant project section
- If it contains decisions → trigger `log decision`
- If it was a meeting → also run `core-meeting-analysis.md` for action items

---

## Language Handling

| Audio Language | Whisper Setting | Notes |
|---|---|---|
| Full English | `language="en"` | Fastest |
| Full BM | `language="ms"` | Good accuracy |
| Mixed BM/EN (Manglish) | `language=None` | Auto-detect, works well |
| Formal BM | `language="ms"` | Best result |

---

## Model Choice (Claude Processing)

| Task | Model | Why |
|---|---|---|
| Short transcript (<30 min) | **Sonnet 4.6** | Fast, accurate, cheap |
| Long transcript (1hr+) | **Sonnet 4.6** | 1M context window handles it |
| Complex analysis + reasoning | **Fable 5** | Only if deep insight needed |

**Rule**: Sonnet 4.6 is almost always enough.

---

## Cost Estimate

| Step | Cost |
|---|---|
| Transcription (Whisper) | Free |
| Transcription (Otter.ai free) | Free (300 min/month) |
| Claude.ai website | Free plan works |
| Claude API (per transcript) | ~RM0.01–0.05 depending on length |

---

## Common Gotchas

- **Noisy audio**: Whisper handles it well, but clean audio = better accuracy
- **Multiple speakers**: Use AssemblyAI for speaker labeling ("Speaker 1:", "Speaker 2:")
- **Long recordings (1hr+)**: Split into 30-min chunks for Colab (RAM limit)
- **BM dialect (Kelantanese, Sarawak)**: Whisper may struggle — use `medium` or `large` model

---

## Related Skills

- Meeting recordings with action items → [Meeting Analysis](./core-meeting-analysis.md)
- Voice note → social post → use Content Repurposing prompt above
- Client call → follow-up → [Handoff Protocol](./core-handoff-protocol.md)
