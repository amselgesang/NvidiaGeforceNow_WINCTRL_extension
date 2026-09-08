---
title: Wiki Index
status: draft
updated: 2026-09-08
tags: [meta]
---

# Wiki Index

Catalog of every wiki page. Update on every ingest. Read this first when answering a query.

## Meta

- [overview.md](overview.md) — project brief, goals, current status
- [log.md](log.md) — chronological ingest/query/design record
- [../AGENTS.md](../AGENTS.md) — wiki schema and working agreement

## Concepts

- [concepts/gfn-input-model.md](concepts/gfn-input-model.md) — how GFN filters/forwards peripherals
- [concepts/input-vs-output-split.md](concepts/input-vs-output-split.md) — hardware→sim vs sim→hardware
- [concepts/simconnect-wasm-bridge.md](concepts/simconnect-wasm-bridge.md) — why MF needs the sim host

## Entities

- [entities/geforce-now.md](entities/geforce-now.md) — GFN / NVS streaming platform
- [entities/winctrl.md](entities/winctrl.md) — WinCTRL / WinWing hardware
- [entities/mobiflight.md](entities/mobiflight.md) — MobiFlight Connector + WASM

## Constraints

- [constraints/feasibility-gates.md](constraints/feasibility-gates.md) — viable / partial / blocked gates

## Approaches

- [approaches/candidates.md](approaches/candidates.md) — A1–A5 index
- [approaches/hybrid-options.md](approaches/hybrid-options.md) — Options 1–3 under hybrid (D1)

## Design

- [design/decisions.md](design/decisions.md) — D3 skip MF; D4 remapper
- [design/remapper.md](design/remapper.md) — HID Joystick → Xbox HID design
- [design/requirements.md](design/requirements.md) — v1 Mac remapper requirements
- [design/architecture.md](design/architecture.md) — components + path
- [design/open-questions.md](design/open-questions.md) — Q5 → D decided; Q2–Q4 open

## Diagrams

- [diagrams/hybrid-system-overview.html](diagrams/hybrid-system-overview.html) — Archify GFN-only overview (showcase + visual-check pass)
- [diagrams/gfn-xinput-sequence.html](diagrams/gfn-xinput-sequence.html) — Archify sequence (showcase + visual-check pass)
- Specs: [diagrams/specs/](diagrams/specs/)

## Queries

- [queries/mac-without-windows.md](queries/mac-without-windows.md) — Mac-only feasibility vs ViGEm/Windows
- [queries/xplane-mac-winctrl-hid.md](queries/xplane-mac-winctrl-hid.md) — how XP12 reads WinCTRL on Mac (local Orion probe)

## Raw sources (immutable)

- [raw/sources/karpathy-llm-wiki.md](../raw/sources/karpathy-llm-wiki.md)
- [raw/sources/2026-09-08-gfn-hotas-research.md](../raw/sources/2026-09-08-gfn-hotas-research.md)
- [raw/sources/2026-09-08-mobiflight-winctrl-research.md](../raw/sources/2026-09-08-mobiflight-winctrl-research.md)
