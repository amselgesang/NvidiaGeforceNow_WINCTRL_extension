---
title: Entity — MobiFlight
status: draft
updated: 2026-09-08
tags: [entity, mobiflight]
---

# MobiFlight

Open ecosystem for mapping cockpit hardware to flight sims. Components:

| Piece | Role |
|---|---|
| **MobiFlight Connector** | Desktop UI + runtime: profiles, device IO, sim event mapping |
| **Firmware modules** | Arduino-class boards (not required for WinCTRL game controllers) |
| **WASM module** | MSFS Community package; executes calculator code / LVars; shared ClientData with SimConnect clients |
| **SimConnect** | Transport between Connector and MSFS (local or remote IPv4 when configured) |

## Why users care here

The user already configures WinCTRL hardware via MobiFlight profiles for local simulator
games. The desired "connector to NVS" ideally preserves that workflow.

## Remote operation (important nuance)

MobiFlight **can** run on a different PC from MSFS **if** you control both ends: install
WASM on the sim PC, open SimConnect IPv4, point `SimConnect.cfg` at that host. That is
**not** the same as GeForce NOW, where the sim host is a locked cloud VM.

## Sources

- [raw MF/WinCTRL notes](../../raw/sources/2026-09-08-mobiflight-winctrl-research.md)
- Related: [SimConnect / WASM bridge](../concepts/simconnect-wasm-bridge.md), [feasibility gates](../constraints/feasibility-gates.md)
