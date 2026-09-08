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
- [../docs/superpowers/specs/2026-09-08-nvs-warthog-spoof-remapper-design.md](../docs/superpowers/specs/2026-09-08-nvs-warthog-spoof-remapper-design.md) — approved design spec
- [../docs/superpowers/plans/2026-09-08-nvs-warthog-spoof-remapper.md](../docs/superpowers/plans/2026-09-08-nvs-warthog-spoof-remapper.md) — implementation plan

## Concepts

- [concepts/gfn-input-model.md](concepts/gfn-input-model.md) — how GFN filters/forwards peripherals
- [concepts/input-vs-output-split.md](concepts/input-vs-output-split.md) — hardware→sim vs sim→hardware
- [concepts/simconnect-wasm-bridge.md](concepts/simconnect-wasm-bridge.md) — why MF needs the sim host

## Entities

- [entities/geforce-now.md](entities/geforce-now.md) — GFN / NVS streaming platform
- [entities/winctrl.md](entities/winctrl.md) — WinCTRL / WinWing hardware
- [entities/mobiflight.md](entities/mobiflight.md) — MobiFlight (research only; deferred)

## Constraints

- [constraints/feasibility-gates.md](constraints/feasibility-gates.md) — G1–G7; v1 = G3 Warthog spoof

## Approaches

- [approaches/candidates.md](approaches/candidates.md) — A6 primary (Warthog); A1 fallback
- [approaches/hybrid-options.md](approaches/hybrid-options.md) — historical pre-D5 notes

## Design

- [design/decisions.md](design/decisions.md) — D3 skip MF; D5 Warthog spoof
- [design/remapper.md](design/remapper.md) — dual Warthog sink remapper
- [design/requirements.md](design/requirements.md) — R1–R7
- [design/architecture.md](design/architecture.md) — system path
- [design/open-questions.md](design/open-questions.md) — Q2–Q4 open; Q5 decided

## Diagrams

- [diagrams/warthog-spoof-overview.html](diagrams/warthog-spoof-overview.html) — Archify architecture
- [diagrams/warthog-spoof-sequence.html](diagrams/warthog-spoof-sequence.html) — Archify sequence
- Specs: [diagrams/specs/](diagrams/specs/)

## Queries

- [queries/gfn-empty-warthog-spike.md](queries/gfn-empty-warthog-spike.md) — G3 empty spoof gate **(BLOCKED)** on provisioning
- [queries/mac-without-windows.md](queries/mac-without-windows.md) — Mac-only feasibility (historical)
- [queries/xplane-mac-winctrl-hid.md](queries/xplane-mac-winctrl-hid.md) — XP12 HID path on Mac

## Raw sources (immutable)

- [raw/sources/karpathy-llm-wiki.md](../raw/sources/karpathy-llm-wiki.md)
- [raw/sources/2026-09-08-gfn-hotas-research.md](../raw/sources/2026-09-08-gfn-hotas-research.md)
- [raw/sources/2026-09-08-mobiflight-winctrl-research.md](../raw/sources/2026-09-08-mobiflight-winctrl-research.md)
- [raw/sources/2026-09-08-mac-orion-hid-probe.md](../raw/sources/2026-09-08-mac-orion-hid-probe.md)
- [raw/sources/2026-09-08-warthog-spoof-ids.md](../raw/sources/2026-09-08-warthog-spoof-ids.md)
