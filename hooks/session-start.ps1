# MemoryCore SessionStart hook.
# Prints bounded prior context to stdout so it lands in the agent's context automatically
# on startup, resume, /clear and after every compaction (source=compact).
#
# Register in ~/.claude/settings.json:
# "hooks": { "SessionStart": [ { "hooks": [ { "type": "command",
#   "command": "powershell -NoProfile -ExecutionPolicy Bypass -File \"<path-to-this-repo>\\hooks\\session-start.ps1\"" } ] } ] }

[Console]::OutputEncoding = [Text.Encoding]::UTF8
$raw = [Console]::In.ReadToEnd()
$source = 'startup'
$cwd = (Get-Location).Path
try {
  $j = $raw | ConvertFrom-Json
  if ($j.cwd) { $cwd = $j.cwd }
  if ($j.source) { $source = $j.source }
} catch {}

$memRoot = Join-Path (Split-Path $PSScriptRoot -Parent) 'memory'
$maxLines = 150
$out = @()

$sm = Join-Path $cwd 'session-memory.md'
if (Test-Path $sm) {
  $lines = @(Get-Content $sm -Encoding UTF8)
  $age = [int]((Get-Date) - (Get-Item $sm).LastWriteTime).TotalMinutes
  $out += "[MemoryCore hook] source=$source | session-memory.md: $($lines.Count) lines, last saved $age min ago"
  if ($lines.Count -gt 500) { $out += '[MemoryCore hook] session-memory.md is over 500 lines. Auto-reset is due: keep ## Session Recap only, rebuild the rest from the template.' }
  if ($source -eq 'compact') {
    $out += '[MemoryCore hook] Context was just compacted. Re-read the recap below and update session-memory.md now if it is stale.'
    $idx = -1
    for ($k = 0; $k -lt $lines.Count; $k++) { if ($lines[$k] -like '## Session Recap*') { $idx = $k; break } }
    if ($idx -ge 0) { $out += $lines[$idx..($lines.Count - 1)] } else { $out += $lines | Select-Object -First 40 }
  } else {
    $out += $lines | Select-Object -First $maxLines
    if ($lines.Count -gt $maxLines) { $out += "... ($($lines.Count - $maxLines) more lines, read the file for the rest)" }
  }
} else {
  $out += "[MemoryCore hook] source=$source | no session-memory.md in $cwd. Create one from memory/06-session-memory-format.md if this is a project."
}

$lru = Join-Path $memRoot 'projects-lru.md'
if (Test-Path $lru) {
  $out += ''
  $out += '[MemoryCore hook] projects-lru.md (top):'
  $out += Get-Content $lru -Encoding UTF8 | Select-Object -First 15
}

$out += ''
$out += '[MemoryCore hook] Before coding: read Anti-Patterns + Learned Skills in memory/07-self-evolution.md. Run the Fact Gate (memory/core-observation.md) before the first edit to any existing file.'
$out -join "`n"
