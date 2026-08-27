---
type: system
status: active
created: 2026-08-27
tags:
  - system
  - agents
  - context
---
# Agent Protocol

This vault is shared by the owner and AI agents. The protocol optimizes for low-token, high-signal context.

## Context Budget Rule
Start narrow. Expand only when the task proves it needs more context.

### L0 — Always
- Read [[AGENTS]] (routing) and [[99 System/Now|Now]] (current focus).

### L1 — If Needed
- Specific project: one note in `03 Projects/`.
- Specific client: `04 Areas/clients/<client>/index.md`, then only the needed `scope.md`, `offer.md`, or `communication.md`.
- Specific idea: one note in `05 Ideas/`.
- Specific repo: one note in `07 Repositories/`.

### L2 — Rare
- Your own recent session files only when same-day continuity matters.
- [[Home]] only when a dashboard overview is explicitly useful.
- Broad maps only after targeted search fails.

## Search Before Reading
Use search/list tools to find the smallest relevant note. Avoid opening dashboards, journals, and long history notes just to orient.

## Session Files
Session files are write sinks, not default startup context. At the end of substantive work, write your session file to `01 Journal/agents/YYYY-MM/YYYY-MM-DD__<host>__<agent>__<session-id>.md` with 3–8 bullets:
- what was worked on
- what was accomplished
- open next steps or blockers

One writer per file. Never append to another agent's session file; never touch `01 Journal/owner/**`.

## Durable Knowledge Routing
Save without asking when the session produces durable material:
- business ideas, revenue, GTM -> `05 Ideas/`
- project plans, architecture -> `03 Projects/`
- goals and progress -> `02 Goals/` or `04 Areas/`
- reusable knowledge, tools, prompts -> `06 Knowledge/`
- decisions with reasoning -> `08 Decisions/`
- client information -> `04 Areas/clients/<client>/`

Skip casual chat, transient command output, and vague ideas with no future value.

## Writing Rules
- File names: `kebab-case.md`.
- New notes require frontmatter with `type`, `status`, `created`, and `tags`.
- Use `[[wikilinks]]`.
- Update existing notes instead of creating duplicates.
- Keep notes short, durable, and scan-friendly.

## Client Rule
Anything about a client is documented automatically:
- text/updates/decisions -> `communication.md`
- files/photos/logos/reviews -> `assets/`
- price/offer/billing -> `offer.md`
- deliverables/tech -> `scope.md`

## Capture The Why
For meaningful decisions, ask the owner briefly why before recording the decision. Store decision + reasoning in `08 Decisions/`. Do not trigger for formatting, obvious defaults, or trivial reversible changes.

## Canonical Status Gate
For substantive work, session end has two layers:
1. Journal what happened in your session file.
2. Update the affected canonical state note.

Canonical updates are required when the session changes project/repo/client reality:
- active project: update `last_verified`, `next_action`, `priority`, repo/client links
- repository: update `last_synced_at`, `last_pushed_at`, `local_path`, linked project
- client: update `index.md` plus `scope.md`, `offer.md`, or `communication.md`
