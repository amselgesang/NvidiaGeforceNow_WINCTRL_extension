---
title: Concept — SimConnect / WASM bridge
status: draft
updated: 2026-09-08
tags: [concept, mobiflight, simconnect]
---

# SimConnect / WASM bridge

MobiFlight's MSFS integration depends on:

1. **WASM package** installed in the MSFS **Community** folder on the **sim host**.
2. **SimConnect** session from Connector (or another client) to that host.
3. Optional remote IPv4 SimConnect when LAN allows — still requires (1) on the sim host.

## Implication for GFN

Stock GeForce NOW sessions do not permit installing Community packages or exposing
SimConnect to the member's LAN. Therefore the **output / LVar half** of MobiFlight is
`**(BLOCKED)**` on stock GFN until a new NVIDIA/MS capability exists.

Local MSFS (or a self-hosted remote sim PC) remains the path for full panel sync.

See [MobiFlight](../entities/mobiflight.md), [feasibility gates](../constraints/feasibility-gates.md).
