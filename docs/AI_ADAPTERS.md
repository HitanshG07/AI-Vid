# AI Adapters: how each AI tool sets itself up for AI-Vid

**Who reads this:** an AI agent opening `C:\AI-Vid` in its own tool (Antigravity, Codex, Gemini CLI, Cursor, ChatGPT...).
**Your job:** create the thin config files your tool needs so that `/new-story`, `/produce-video` and `/verify-originality` work for you, the same way they work in Claude Code. Then run the self-test in `docs/SETUP_GUIDE.md` Part 1.

## The one rule for adapters
**Start every session by reading `AGENTS.md` and then `docs/HANDOFF.md`** (current story status, next steps, known pitfalls). Every adapter file you create should tell the tool to do the same.

**Never copy workflow content.** The real workflows live in `.claude/skills/<name>/SKILL.md` and the rules live in `AGENTS.md`. Every adapter file you create must be a short pointer ("read and follow X") so there is one source of truth. If you find yourself pasting steps, stop.

Tool config formats change. Before creating files, **check your own tool's current docs** for where rules, slash commands/workflows and MCP servers go. The paths below were correct when written. If yours differ, use your tool's real paths and update the table in this file.

---

## Step 1: The 3 commands every tool needs

Create one command/workflow per row, in your tool's format, each containing only the pointer text:

| Command | Pointer text to put in the command file |
|---|---|
| `new-story` | Read AGENTS.md, then follow `.claude/skills/new-story/SKILL.md` step by step. Arguments: optional theme or count. |
| `verify-originality` | Read AGENTS.md, then follow `.claude/skills/verify-originality/SKILL.md` step by step. Never skip writing `ledger/verification/<ID>.md`. |
| `produce-video` | Read AGENTS.md, then follow `.claude/skills/produce-video/SKILL.md` for story ID `<arg>`. Stop if the verification file is not PASS. |

## Step 2: Roles → your models

The skills say "spawn researcher/verifier/showrunner/render-qa". Map each role to your tool's models. Role prompts live in `.claude/agents/<role>.md`.

| Role | Tier | Gemini (Antigravity / Gemini CLI) | OpenAI (Codex) |
|---|---|---|---|
| researcher | low | Gemini Flash | smallest/mini model, low reasoning |
| verifier | mid | Gemini Pro | standard model, medium reasoning |
| render-qa | mid | Gemini Pro | standard model, medium reasoning |
| showrunner | high | Gemini Pro (highest thinking) | best model, high reasoning |

- **If your tool can spawn sub-agents or switch models per task:** do that, passing the role file as the prompt.
- **If not:** play the role yourself. Read `.claude/agents/<role>.md` before each step and keep the steps and output files identical. The cheaper tier is a cost guideline; the files and checks are mandatory.

## Step 3: Roblox Studio MCP
Asset generation and rendering go through the Roblox Studio MCP server (Studio → Assistant → `...` → Manage MCP Servers → enable "Studio as MCP server"). Register that server in your tool's MCP settings, then confirm by calling `get_studio_state` with Studio open. Without it you can still brainstorm, verify, script and do voice/subtitles; tell the user rendering is blocked.

---

## Antigravity (Google)

| What | Where |
|---|---|
| Rules | Antigravity reads `AGENTS.md`/`GEMINI.md` from the workspace root. If it doesn't load them automatically, create `.agent/rules/ai-vid.md` with: "Always read and follow AGENTS.md and docs/SETUP_GUIDE.md." |
| Commands | Workflows, run with `/name`: create `.agent/workflows/new-story.md`, `verify-originality.md`, `produce-video.md`, each with a short description frontmatter + the pointer text from Step 1. |
| Models | Use the Gemini mapping in Step 2. Use the Agent Manager to run researcher work in a separate Flash agent if available. |
| Browser | Antigravity's built-in browser agent is good for the originality searches (researcher role). Record real URLs only. |
| MCP | Add the Roblox Studio server via the MCP store / `mcp_config.json` (Agent panel → `...` → MCP Servers). |

Example `.agent/workflows/new-story.md`:
```markdown
---
description: Create a new web-verified, engaging Roblox story for AI-Vid
---
Read AGENTS.md, then follow .claude/skills/new-story/SKILL.md step by step. Optional argument: theme or count.
```

## Codex (OpenAI CLI / IDE)

| What | Where |
|---|---|
| Rules | Codex reads `AGENTS.md` at the repo root automatically. Nothing to add. |
| Commands | Repository pointer skills live in `.agents/skills/<name>/SKILL.md`. Invoke `$new-story`, `$verify-originality`, or `$produce-video` and provide the theme, premise, or story ID in the message. Restart or start a new session if the skills are not yet listed. |
| Models | Use the OpenAI mapping in Step 2. Codex usually runs one model per session, so set reasoning effort per step (low for researcher, high for showrunner) or play the roles yourself. |
| Web | Originality checks need web search. Enable it (e.g. `codex --search`, or `web_search = true` in `~/.codex/config.toml`). If search is unavailable, STOP: never mark a premise PASS without real searches. |
| MCP | Add the Roblox Studio server under `[mcp_servers.<name>]` in `~/.codex/config.toml`. |
| Sandbox | The pipeline needs network (Edge-TTS, searches) and file writes in the repo. Use workspace-write with network allowed. |

Example `~/.codex/prompts/produce-video.md`:
```markdown
---
description: Produce the final AI-Vid short for a story ID
argument-hint: ID=<3-digit id>
---
Read AGENTS.md, then follow .claude/skills/produce-video/SKILL.md for story $1. Stop if ledger/verification/$1.md is not PASS.
```

## Gemini CLI
Rules: `GEMINI.md` (already present). Commands: `.gemini/commands/new-story.toml` etc. with `description = "..."` and `prompt = "<pointer text>. Args: {{args}}"`. MCP: `mcpServers` in `.gemini/settings.json`.

## Cursor
Rules: `.cursor/rules/main.mdc` (already present). Commands: `.cursor/commands/new-story.md` etc. containing the pointer text. MCP: `.cursor/mcp.json`.

## ChatGPT / any chat-only AI (no file access)
Paste `AGENTS.md`, `docs/ENGAGEMENT_RULES.md`, the ledger, and the relevant `SKILL.md`. Ask it to output each file's contents for you to save. It must actually browse for the originality check; if it can't browse, don't accept a PASS.

## Every tool: Production Manifest + cast builder (mandatory)
Characters use the locked R6 catalog method (AGENTS.md Asset process); Argon is retired for characters/props/sets (2026-11-17). For every story, any AI must output `stories/<ID>_<slug>/MANIFEST.md` from `templates/production_manifest_template.md`, at minute detail with no vague lines:
- what each character does
- where it is set
- every emotion
- every asset/mesh
- every animation
- every VFX
- a beat table every ~1.2–2 s

It must also produce `engines/roblox/cast_<ID>.luau` (see `.claude/skills/new-story/SKILL.md` step 6c). Chat-only AIs: paste the template and ask for the filled manifest plus the cast table (catalog ids, skin, default face).

---

## Step 4: Confirm and report
After setup, tell the user:
1. Which files you created (paths).
2. How to run each command in your tool.
3. Your model mapping.
4. The SETUP_GUIDE self-test result (pass/fail).
5. Whether the Roblox Studio MCP is connected.
