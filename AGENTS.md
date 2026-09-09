# AGENTS.md — GFN Extension Project Wiki Schema

This file is the **operating manual** for any LLM agent working in this repository.
Read it fully at the start of every session before touching the wiki, making design
decisions, or implementing features.

## What this project is

**GFN Extension** explores whether (and how) we can connect **WinCTRL / WinWing**
cockpit hardware and the **MobiFlight** adapter stack to **NVIDIA GeForce NOW (GFN)**
for flight-simulator games that only natively accept a short whitelist of Thrustmaster
and Logitech peripherals.

The work is **research → design → architecture diagrams → plan → implement**, with
honest fail-fast gates when a path is blocked by the cloud platform.

## Working agreement

- **Be honest.** If you don't have information, say so. Mark claims `**(UNVERIFIED)**`
  until backed by a source in `raw/` or a wiki page with citations.
- **Fail fast.** Prove or disprove viability with the cheapest experiment first.
  Do not burn effort on approaches blocked by GFN policy (no Community folder,
  no SimConnect into the cloud session) without documenting the hard stop.
- **Design before code.** No implementation until the relevant design pages are at
  least `draft` and the user has signed off.
- **Compound knowledge in the wiki.** Do not leave research only in chat. Ingest
  sources into `raw/`, update wiki pages, keep `index.md` and `log.md` current.
- **Archify for architecture.** When the user asks for architecture / sequence /
  data-flow diagrams, use the Archify skill and store delivered HTML under
  `wiki/diagrams/` (specs under `wiki/diagrams/specs/`).

## The LLM Wiki pattern (Karpathy)

Three layers (see `raw/sources/karpathy-llm-wiki.md`):

1. **Raw sources** (`raw/`) — immutable inputs: articles, notes, PDFs, screenshots.
   The agent reads but **never edits** these. Images → `raw/assets/`.
2. **The wiki** (`wiki/`) — LLM-owned markdown. Summaries, entity pages, constraints,
   approaches, design decisions, filed query answers. The agent creates and maintains all of it.
3. **The schema** (`AGENTS.md`, this file) — conventions + workflows. Co-evolved over time.

## Directory layout

```
AGENTS.md
raw/
  sources/                 ← immutable text/markdown/PDF source notes
  assets/                  ← images, screenshots
wiki/
  index.md                 ← catalog of every wiki page
  log.md                   ← append-only chronological record
  overview.md              ← project brief + current status
  concepts/                ← domain concepts (GFN input model, MF bridge, etc.)
  entities/                ← products / systems (GFN, WinCTRL, MobiFlight, …)
  constraints/             ← hard platform limits and feasibility gates
  approaches/              ← candidate solution architectures
  design/                  ← requirements, open questions, decisions
  queries/                 ← filed answers to notable questions
  diagrams/                ← Archify HTML outputs + JSON specs
```

## Page conventions

- Every page starts with YAML frontmatter:
  ```yaml
  ---
  title: <Page Title>
  status: stub | draft | stable
  updated: YYYY-MM-DD
  tags: [gfn, winctrl, mobiflight, architecture, ...]
  ---
  ```
- Cross-link with relative paths, e.g. `[GeForce NOW](../entities/geforce-now.md)`.
- Mark uncertainty: `**(UNVERIFIED)**`, gaps: `**(TODO)**`, hard stops: `**(BLOCKED)**`.
- Prefer short sections with headers for easy diffs.

## Workflows

### Ingest (new source / finding)
1. Place immutable material in `raw/sources/` or `raw/assets/`. Never modify it.
2. Extract takeaways; update entity/concept/constraint pages.
3. Update `wiki/index.md`.
4. Append to `wiki/log.md`.

### Query (a question / exploration)
1. Read `index.md`, then relevant pages.
2. Answer with citations to wiki pages (and raw sources where useful).
3. If durably useful, file under `wiki/queries/` and index it.
4. Append to `log.md`.

### Lint (periodic health check)
Scan for contradictions, stale claims, orphans, missing pages for named concepts,
and open questions ready to resolve. Fix bookkeeping; report substantive conflicts.

## Log format

Append-only. Each entry starts with a parseable prefix:

```
## [YYYY-MM-DD] <ingest|query|design|impl|lint|diagram> | <short title>
- what changed / what was decided
- pages touched
```

Last few entries: `grep "^## \[" wiki/log.md | tail -5`

## Domain-specific conventions

- **Separate input path from SimConnect path.** Axes/buttons into GFN ≠ MobiFlight
  display/LVar sync. Never conflate them in requirements or architecture.
- **Whitelist reality.** GFN flight-control support is a device whitelist on the
  native client, not generic DirectInput passthrough.
- **MobiFlight needs the sim host.** WASM in Community + SimConnect. Remote MF is
  documented for a LAN sim PC you control — not for GFN cloud instances.
- Every approach page must state **feasibility**: `viable | partial | blocked | unknown`
  with rationale.
