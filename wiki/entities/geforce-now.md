---
title: Entity — GeForce NOW (NVS)
status: draft
updated: 2026-09-08
tags: [entity, gfn, nvs]
---

# GeForce NOW (NVS)

Cloud game streaming service. In this project, **NVS** means the NVIDIA remote play /
GeForce NOW path the user wants WinCTRL + MobiFlight to reach.

## Relevant behavior for peripherals

- Official flight-control support is a **device whitelist** on the **native** Windows /
  macOS clients (not a generic "any USB joystick" passthrough).
- Published HOTAS examples (as of early 2026 NVIDIA materials): Thrustmaster T.Flight
  Hotas One / Hotas 4 / Rudder Pedals; Logitech X52 / X52 Pro.
- Community reports: devices that appear as **DirectInput** joysticks are often ignored;
  **XInput** (Xbox-style) virtual controllers are the practical remapping target.
- Cloud session does **not** give the user a writable MSFS Community folder or the ability
  to run arbitrary local middleware against the remote sim process.

## Sources

- [raw GFN research notes](../../raw/sources/2026-09-08-gfn-hotas-research.md)
- Related: [GFN input model](../concepts/gfn-input-model.md), [feasibility gates](../constraints/feasibility-gates.md)
