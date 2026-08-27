---
type: system
status: active
created: 2026-08-27
tags:
  - system
  - agents
  - protocol
---
# Agent Briefing

Read this file first, but do not use it as the full brain dump. Its job is routing.

> **Rule source: `99 System/policy/brain-policy.yaml`.** This file is a rendered adapter — rule changes start in the policy, never here. <!-- BRAIN:ADAPTER v1 -->

## Journal ownership
- **`01 Journal/owner/**` belongs to the human owner alone.** No agent ever creates, appends to, or corrects a file there. Default `visibility: private` also means: do not read it or load it into context. No LLM interprets the owner's diary.
- **Agents write session files:** `01 Journal/agents/YYYY-MM/YYYY-MM-DD__<host>__<agent>__<session-id>.md` — exactly ONE file per session, one writer per file (commutative, conflict-free). Structured events optionally go to `01 Journal/_events/YYYY/MM/` (same naming scheme, append-only).

## Who is bound by this protocol

**Every agent working for the owner uses this vault — no exceptions, regardless of harness.** There is no agent class for which this is optional. The vault is the shared memory; an agent that doesn't write into it works invisibly to all the others and makes them repeat the same work.

That includes every CLI agent, IDE agent, local model, and remote runner you connect — and every harness added in the future.

### The four duties — identical for all

1. **Read before working.** For non-trivial tasks: this file, plus `99 System/Now.md` and the one relevant project/client/idea note if the task is scoped. Do not load half the vault.
2. **Write after working.** Session file in `01 Journal/agents/YYYY-MM/YYYY-MM-DD__<host>__<agent>__<session-id>.md`, 3–8 bullets: what was worked on, what was achieved, what is open. **Never skip** — not even under time pressure. NEVER write into `01 Journal/owner/**`.
3. **Save durable knowledge immediately**, into the right folder (see *Save Durable Knowledge* below). Update the existing note instead of creating a duplicate. Don't ask — this is pre-approved.
4. **Update the canonical note**, not just the journal (see *Canonical Status Gate*).

### Vault sync

Committing and pushing the vault is expected agent behavior, not something to ask about. On machines where Obsidian runs, a git sync plugin may push additionally — that is no reason to wait. On headless machines manual syncing is the *only* sync: **`git pull --rebase` before writing, commit + push after writing.** Otherwise the copies diverge.

## Hot Start
1. Read `99 System/Now.md` — current focus.
2. Use the user request to choose the smallest relevant note set.
3. Read `99 System/agent-protocol.md` only when you need full operating rules.
4. Do not read `Home.md`, full journals, dashboards, or long histories by default.

## What This Vault Is
Shared Obsidian brain for the owner and their AI agents. It tracks projects, business, goals, decisions, clients, ideas, and daily progress.

> **Customize here:** two or three sentences about who the owner is, what they are building, and what their scarcest resource is. Agents calibrate every trade-off against this.

## Vault Map
- `00 Inbox/` raw capture (+ `_candidates/` for research findings before triage)
- `01 Journal/` owner diary (owner only) + agent session files
- `02 Goals/` goals and reviews
- `03 Projects/` active projects
- `04 Areas/` life/business areas and clients
- `05 Ideas/` business/product ideas
- `06 Knowledge/` distilled reusable knowledge
- `07 Repositories/` repo docs
- `08 Decisions/` decisions with reasoning
- `09 Maps/` dashboards and MOCs
- `99 System/` operating rules + `policy/` (THE rule source) + `schemas/` + `machines/`

## Context Loading
- Default context is this file plus `99 System/Now.md`.
- For a project, read only the matching project/client/area note.
- For daily continuity, read your own recent session files in `01 Journal/agents/` — never the owner journal.

## Writing Rules
- File names: `kebab-case.md`.
- New notes need YAML frontmatter: `type`, `status`, `created`, `tags` (full schemas: `99 System/schemas/frontmatter-schemas.yaml`).
- Use `[[wikilinks]]` and update existing notes instead of creating duplicates.
- Keep notes short and durable; no transcripts.
- Convert relative dates ("next week") to absolute dates when writing.

## Save Durable Knowledge
Save automatically when the session creates durable material:
- ideas, revenue models, GTM -> `05 Ideas/`
- project plans, architecture -> `03 Projects/`
- goals/progress -> `02 Goals/` or `04 Areas/`
- reusable tools/prompts/setups -> `06 Knowledge/`
- decisions with reasoning -> `08 Decisions/`
- client material -> `04 Areas/clients/<client>/`
- new code repositories -> `07 Repositories/` (register immediately; a repo not in the vault is invisible to future agents)

Skip casual chat, vague ideas, and transient command output.

## Client Rule
Whenever the owner sends or mentions anything about a client, document it without asking:
- communication -> `communication.md`
- files/photos/logos/reviews -> `assets/`
- price/offer/billing -> `offer.md`
- deliverables/tech -> `scope.md`

One client = one folder `04 Areas/clients/<client>/`. New client -> copy `04 Areas/clients/_template/`.

## Capture The Why
For meaningful decisions — architecture, strategy, tool choice, business call, deliberate trade-off — stop briefly, ask the owner *why*, then record decision + reasoning in `08 Decisions/`. Trigger only when future you or another agent would ask in 3 months why it was decided. Do not trigger for formatting, obvious defaults, or trivial reversible changes.

**Why:** the owner's judgment is the scarcest, least-replaceable input in the system. Capturing it builds the shared context between human intent and AI execution.

## Canonical Status Gate
Journals are not enough for project/repo/client work. At session end, update the affected source-of-truth note:
- project state -> `03 Projects/<project>.md` with `last_verified`, `next_action`, `priority`, and repo/client links
- repo state -> `07 Repositories/<repo>.md` with `last_synced_at`, `last_pushed_at`, `local_path`, and linked project
- client state -> `04 Areas/clients/<client>/index.md` plus `scope.md`, `offer.md`, or `communication.md` as needed

## New Machine Bootstrap
Freshly cloned vault on a new machine?

1. `sh "99 System/policy/hooks/install.sh"` — installs the protection pre-commit hook.
2. Set `BRAIN_VAULT=<absolute vault path>` in the machine's environment.
3. Create `99 System/machines/<host>.md` from the template in that folder.
4. Reference this vault's `AGENTS.md`/`CLAUDE.md` from each agent harness's global config (e.g. `~/.claude/CLAUDE.md`, `~/.codex/AGENTS.md`), so the protocol also applies to sessions working *outside* the vault folder.

## Routing Rules (owner-specific)

> **Customize here:** add trigger-based routing rules for your recurring life/business domains. Pattern: *Trigger* (keywords that fire the rule) → *Action* (which notes to read BEFORE answering, never answer from memory) → *Core stance* (the strategic position the agent must internalize). Delete this section if you have none yet.
