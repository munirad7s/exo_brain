# Vault Operating Manual (Claude Code adapter)

> **READ THIS FILE FIRST — before doing ANYTHING in this vault.**
> 1. Read this CLAUDE.md fully and follow it — it overrides default behavior.
> 2. Load vault context per **Context Loading Priority** (bottom).
> 3. Then act. Saving durable knowledge back here is the default, not an extra step.
>
> Rule source: `99 System/policy/brain-policy.yaml`. This file is a rendered adapter. <!-- BRAIN:ADAPTER v1 -->

## Platform — the vault path is DYNAMIC

- **Canonical source per machine: environment variable `BRAIN_VAULT`** (Windows: user env · Linux/macOS: shell profile). Registry of all machines + paths: `99 System/machines/<host>.md`.
- **Self-identification instead of path assumptions:** a directory IS the vault iff it contains `99 System/policy/brain-policy.yaml`. Resolution order: explicit flag → `BRAIN_VAULT` (validated) → upward search from cwd → known clone locations. Hard abort if none of these is a vault.
- **Sync:** git ↔ your remote. Where Obsidian runs, a git sync plugin may push additionally; headless: `git pull --rebase` before writing, commit + push after. Never layer a cloud-drive sync on top of the same folder.
- Prefer Unix-style paths/commands; never hardcode an OS path — use `BRAIN_VAULT` or self-identification.

## Obsidian Brain — Agent Protocol

The vault (path: `$BRAIN_VAULT`) is the shared external brain for the owner and all AI agents. Access is machine-dependent: where an Obsidian MCP server is configured, prefer `mcp__obsidian__*` tools; on headless clones use the normal filesystem tools. Never assume MCP tools exist without seeing them in the server list. Vault updates and the session journal must never be skipped merely because an MCP is unavailable — fall back to filesystem access and verify writes with a read-back.

**"This folder" = the vault.** When the owner says "the vault", "the brain", or "document this" — they mean here.

**How to deal with it:**
1. **Default to saving.** Writing durable knowledge into the vault is pre-authorized and standing behavior — never ask permission, never treat it as optional.
2. **Put it in the right subfolder** per the *Where To Save* table below. Never dump everything in the root.
3. **Update, don't duplicate.** If a matching note exists, edit it; only create new when none fits.
4. Use kebab-case filenames and YAML frontmatter (`type`, `status`, `created`, `tags`; full schemas in `99 System/schemas/frontmatter-schemas.yaml`).

### Think About the Vault Twice Per Turn

1. **Before working:** Does the vault contain relevant context? Check project notes, goals, or prior decisions before starting non-trivial tasks.
2. **After working:** Did this turn produce durable knowledge worth writing back? If yes, save it without waiting to be asked.

### What To Save (Automatically)

- **Ideas & business thinking** — concepts, product directions, revenue models, market insights, pricing, GTM angles
- **Project knowledge** — plans, architecture decisions, workflows, repo relationships, blockers resolved
- **Goals & progress** — milestones hit, learning progress, habit updates
- **Useful tools** — prompts, automations, scripts, reusable setups
- **Decisions** — any choice that affects future work, with the reasoning behind it
- **New repositories** — whenever you create a repo (private or public), immediately register it in `07 Repositories/`: one note + index entry. A repo on GitHub but not in the vault is invisible to future agents.

**Do NOT save:** casual chat, vague ideas with no future value, transient command output, disposable debugging.

### Where To Save

| Content type | Vault location |
|---|---|
| Quick captures, unsorted | `00 Inbox/` |
| Agent session logs | `01 Journal/agents/YYYY-MM/YYYY-MM-DD__<host>__<agent>__<session-id>.md` — one file per session. `01 Journal/owner/**` is the owner's space: NEVER write there, default don't read |
| Long-term & short-term goals | `02 Goals/` |
| Active project notes | `03 Projects/` |
| Life areas (business, learning, family, …) | `04 Areas/` |
| Anything about a **client** | `04 Areas/clients/<client>/` (log → `communication.md`, files → `assets/`, price → `offer.md`) — always document, don't ask |
| Ideas (business, product, side-projects) | `05 Ideas/<idea>/<idea>.md` (research → `Sources/`) |
| Distilled knowledge & references | `06 Knowledge/` |
| Repository docs (active repos only) | `07 Repositories/` |
| Decision logs | `08 Decisions/` |
| Dashboards & navigation | `09 Maps/` |
| Agent & vault operating rules | `99 System/` — rule source: `99 System/policy/brain-policy.yaml` |

### Capture the Why

When you make a **decision that matters** — architecture, strategy, tech/tool choice, business call, a deliberate trade-off — stop, ask the owner briefly *why* (their reasoning and judgment), then record decision + reasoning + judgment in `08 Decisions/`.

**Threshold:** "Would my future self — or another agent — ask in 3 months *why* this was decided?" Yes → ask + document. No → skip.

**Never trigger on:** formatting, obvious default paths, anything reversible in 30 seconds, or pure execution of an already-made decision.

### Session Log — ⚠️ CRITICAL, never skip

The journal is the shared memory across all agents — a session without a log entry is invisible to future sessions. Logging is part of the task itself, not optional cleanup. At the end of any substantive session, write YOUR session file (one writer per file — never append to another agent's file, never touch `01 Journal/owner/**`). Include, in 3–8 bullets:
- What was worked on (project name, files touched, key decisions)
- What was accomplished
- Open next steps or blockers

### Writing Conventions

- **File names:** `kebab-case.md` always
- **Frontmatter:** every note gets YAML with at least `type`, `status`, `created`, `tags`
- **Links:** `[[wikilinks]]` liberally — connect everything that relates
- **Style:** small durable summaries, not transcripts; preserve existing content when updating
- **No author tags:** agent and human content live side by side
- **Never delete** — move to an `_archive/` subfolder and/or mark `superseded_by` in frontmatter

### Context Loading Priority

1. `99 System/Now.md` — current focus and active anchors
2. Your own recent session files in `01 Journal/agents/` — NEVER `01 Journal/owner/**`
3. The relevant project note in `03 Projects/`
4. `Home.md` — full dashboard overview (only if needed)

## Git

- After every completed change: commit and push — the vault only works as shared memory when every machine sees it.
- Concise commit messages: why, not what.
- `git pull --rebase` before writing on headless machines.

## Communication

- Be concise and direct — skip preamble, lead with the answer.
