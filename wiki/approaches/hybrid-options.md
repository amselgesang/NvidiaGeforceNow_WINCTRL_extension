---
title: Approaches — Hybrid dual-path options
status: draft
updated: 2026-09-08
tags: [approaches, architecture, hybrid]
---

# Hybrid dual-path — approach options

Parent strategy locked by [D1](../design/decisions.md). Below are **three ways** to
implement the GFN input half while keeping local MobiFlight intact.

## Shared skeleton (all options)

```
Mode: Local MSFS
  WinCTRL ──► MobiFlight Connector ──► WASM/SimConnect ──► Local MSFS
  (full inputs + displays/LEDs)

Mode: GeForce NOW
  WinCTRL ──► NVS Bridge (this project) ──► GFN client ──► Cloud MSFS
  (inputs only; MobiFlight still optional for local LED tests / offline)
```

---

## Option 1 — XInput bridge (recommended)

**Idea:** Local service reads WinCTRL HID axes/buttons → virtual Xbox 360 controller
(ViGEmBus or equivalent) → GFN forwards XInput → bind in cloud MSFS.

| Pros | Cons |
|---|---|
| Matches community-proven GFN workaround | ~axes/buttons of one gamepad; not a full FCU map |
| Clear fail-fast spike (ViGEm + one stick) | Users rebuild bindings for "Xbox Controller" profile |
| No ToS-grey HID spoofing of branded HOTAS | Continuous axes compete for few XInput axes |
| Leaves MobiFlight untouched for local mode | Displays on GFN still dark |

**Feasibility:** partial / viable for flight controls subset ([G2](../constraints/feasibility-gates.md)).

---

## Option 2 — XInput + keyboard/mouse layer

**Idea:** Option 1 for stick/throttle/rudder; map panel buttons/encoders to keyboard
shortcuts / mouse that GFN already forwards. Optional profile importer from a subset of
MobiFlight input configs (events → keys), not full MF runtime.

| Pros | Cons |
|---|---|
| Covers many cockpit switches Option 1 cannot | Encodes lose fidelity; key spam / focus issues |
| Still avoids blocked SimConnect path | Maintaining key maps per aircraft is churn |
| Incremental on Option 1 | Not "MobiFlight profiles just work" |

**Feasibility:** partial ([G2](../constraints/feasibility-gates.md)+[G7](../constraints/feasibility-gates.md)).

---

## Option 3 — Whitelist HOTAS HID emulation

**Idea:** Present WinCTRL (or a virtual device) as a Thrustmaster/Logitech device GFN
already whitelists.

| Pros | Cons |
|---|---|
| Might unlock more axes if GFN treats HOTAS specially | **Unknown** — may break on GFN updates |
| Closer to "native" flight device in-game | Legal/ToS and reverse-engineering risk |
| | Harder spike; not fail-cheap |

**Feasibility:** unknown ([G3](../constraints/feasibility-gates.md)). Defer unless Options 1–2 fail.

---

## Explicitly rejected for v1

- **Full MobiFlight on GFN** — blocked ([G4](../constraints/feasibility-gates.md)/[G5](../constraints/feasibility-gates.md)).

## Recommendation

**Ship Option 1 as v1 core**, design the bridge so Option 2 is a clean plugin layer,
keep Option 3 as research backlog. Local MobiFlight remains the documented path for
full panels (mode switch in UI/docs, not a fake cloud MF).
