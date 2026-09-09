---
title: Entity — GeForce NOW
status: draft
updated: 2026-09-08
tags: [entity, gfn]
---

# GeForce NOW

Cloud game streaming service. In this project, **GFN** means the NVIDIA remote play /
GeForce NOW path the user wants WinCTRL + MobiFlight to reach.

## Relevant behavior for peripherals

- Official flight-control support is a **device whitelist** on native Windows / macOS
  clients (includes Thrustmaster Warthog HOTAS as separate stick + throttle USB devices).
- Generic HID joysticks (e.g. WinWing Orion) are usually **not** forwarded.
- Remapping options: whitelist-device HID spoof (v1), or virtual Xbox/gamepad class (fallback).
- Cloud session does **not** allow Community folder / SimConnect middleware.

## Sources

- [raw GFN research notes](../../raw/sources/2026-09-08-gfn-hotas-research.md)
- [Warthog IDs](../../raw/sources/2026-09-08-warthog-spoof-ids.md)
- Related: [GFN input model](../concepts/gfn-input-model.md), [feasibility gates](../constraints/feasibility-gates.md)
