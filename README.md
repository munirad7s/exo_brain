# exo_brain

**A shared external brain for you and your AI agents — plain Markdown, Git, and a small set of hard rules.**

exo_brain is an Obsidian-compatible vault template designed to be operated *jointly* by a human owner and any number of AI coding agents (Claude Code, Codex, Gemini, local LLMs, …). The human thinks in it. The agents read context from it before working and write their results back into it after working. Git is the only sync layer, so it works across machines, headless servers, and every agent harness that can touch a filesystem.

This is not a note-taking theory. It is the extracted structure of a vault that has been run in production by one human and 6+ different agent harnesses in parallel — with the personal content removed and the operating rules kept.

## Why this exists

Agents without shared memory repeat each other's work, contradict each other's decisions, and forget everything between sessions. A shared vault fixes that — but only if the rules are strict enough that ten concurrent writers don't destroy it. The rules here are the interesting part:

1. **One normative rule source.** `99 System/policy/brain-policy.yaml` is the single place rules live. `AGENTS.md`, `CLAUDE.md`, and any per-harness config are *rendered adapters* of it — rule changes start in the policy, never in an adapter.
2. **The owner's journal is untouchable.** `01 Journal/owner/**` belongs to the human alone. No agent creates, edits, or even *reads* files there by default. Enforced three times: policy, tooling convention, and a pre-commit hook that blocks agent-marked content.
3. **One writer per file.** Agents log sessions as `01 Journal/agents/YYYY-MM/YYYY-MM-DD__<host>__<agent>__<session-id>.md` — one file per session, one writer per file. Concurrent writes become commutative; merge conflicts become structurally impossible.
4. **Write-back is part of the task.** A session that produced durable knowledge and didn't write it into the vault is treated as unfinished. Routing table below.
5. **Capture the why.** When a decision with weight is made, the agent asks the owner *why*, then logs decision + reasoning to `08 Decisions/`. The owner's judgment is the scarcest input in the system — it gets persisted.
6. **Canonical status over chat logs.** Journals record *what happened*; project/repo/client notes record *what is true now* (`next_action`, `last_verified`). Both get updated, or future sessions navigate by stale maps.

## Vault layout

```
00 Inbox/          Raw capture + _candidates/ (research findings before triage)
01 Journal/        owner/ (human ONLY) · agents/ (session files) · _events/ (append-only)
02 Goals/          Life & business goals, monthly/quarterly reviews
03 Projects/       Active projects — one canonical note each
04 Areas/          Ongoing life/business areas + clients/ (one folder per client)
05 Ideas/          Business & product ideas with their research sources
06 Knowledge/      Distilled reusable understanding
07 Repositories/   One note per code repo (metadata, never the code) + _archive/
08 Decisions/      Decision log with reasoning
09 Maps/           Dashboards, MOCs + _generated/ (projections, rebuildable)
90 Templates/      Note scaffolds (daily, project, idea, decision, client, …)
99 System/         policy/ (THE rule source) · schemas/ · machines/ · Now.md
Excalidraw/        Diagrams
```

## Quickstart

```bash
git clone <your-fork-url> my-brain && cd my-brain

# 1. Install the protection hook (blocks agents from the owner journal, caps Now.md)
sh "99 System/policy/hooks/install.sh"

# 2. Open the folder as a vault in Obsidian (optional but recommended)

# 3. Point your agents at it:
#    - Claude Code: import this vault's CLAUDE.md from your ~/.claude/CLAUDE.md
#    - Codex:       reference AGENTS.md from ~/.codex/AGENTS.md
#    - Anything else: "Read AGENTS.md in <vault path> before working, write a
#      session file after working."

# 4. Set the vault path per machine (agents resolve it via this variable)
export BRAIN_VAULT="$PWD"          # persist in your shell profile / Windows user env
```

Then tell your agent something worth remembering and watch it land in the right folder.

## The agent contract (short version)

Every agent, in every harness, follows the same four duties — the full version lives in [AGENTS.md](AGENTS.md):

1. **Read before working** — `AGENTS.md`, `99 System/Now.md`, and the one relevant project/client note. Not half the vault.
2. **Write after working** — one session file in `01 Journal/agents/`, 3–8 bullets: what was done, what was achieved, what is open.
3. **Save durable knowledge immediately** into the right folder, updating existing notes instead of duplicating. Pre-authorized — no asking.
4. **Update the canonical note** (project/repo/client) whenever the session changed its reality.

## Multi-machine

Each machine registers itself with a note in `99 System/machines/<host>.md` and sets `BRAIN_VAULT`. A directory *is* the vault iff it contains `99 System/policy/brain-policy.yaml` — self-identification instead of hardcoded paths. Sync is plain Git: `git pull --rebase` before writing, commit + push after. The one-writer-per-file journal rule is what makes this safe without locks or a central writer.

## Deliberately not built

The design was stress-tested by a panel of four different models; these were considered and **rejected** (see `rejected_by_consensus` in the policy — don't rebuild them without a new decision):

- A mandatory kernel/daemon as the only write path
- A central sync writer or file leases (commutative writes beat coordination)
- Forgetting curves / auto-deletion (facts expire via `valid_until`, they are never deleted)
- One file per event (too granular; session files are the unit)
- Status encoded as folder path (status lives in frontmatter)
- `mtime` as archive criterion (only the last *content* commit counts)

## What to customize first

- `AGENTS.md` — put your name, your priorities, and your routing rules in
- `99 System/Now.md` — your current focus (cap: 120 lines, enforced by the hook)
- `99 System/policy/brain-policy.yaml` — the rules themselves
- `90 Templates/` — adjust scaffolds to your workflow
- `04 Areas/clients/_template/` — if you do client work

## License

MIT — see [LICENSE](LICENSE).
