---
title: Constraints — Feasibility gates
status: draft
updated: 2026-09-08
tags: [constraints, feasibility]
---

# Feasibility gates

Hard stops and partial paths. Update when NVIDIA expands the whitelist or APIs.

| ID | Gate | Status | Notes |
|---|---|---|---|
| G1 | Pass WinCTRL **as-is** through GFN client | **blocked** | Not on published HOTAS whitelist; generic DI often ignored |
| G2 | Present **virtual XInput** gamepad to GFN | **partial** | Community-proven for axes/buttons; limited axes vs full cockpit; latency/mapping UX |
| G3 | Spoof / emulate **whitelisted HOTAS HID** | **unknown** | Possibly fragile, legally/ToS sensitive; research only with care |
| G4 | Install MobiFlight **WASM** on GFN MSFS | **blocked** | No Community folder access |
| G5 | Open **SimConnect** from home PC into GFN session | **blocked** | Cloud host not under user control |
| G6 | Run full MobiFlight on **local** MSFS | **viable** | Existing user workflow |
| G7 | Keyboard/mouse injection from panel buttons into GFN | **partial** | Works for many cockpit commands; poor for continuous axes; loses MF profile richness |

## Decision rule

- If user chooses **full MF parity on GFN** → fail-fast: document blocked gates G4/G5; offer hybrid (G6 + G2/G7).
- If user chooses **input-only on GFN** → pursue G2 (and optionally G7) as primary architecture.
