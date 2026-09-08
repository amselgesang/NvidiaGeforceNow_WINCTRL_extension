---
title: Constraints — Feasibility gates
status: draft
updated: 2026-09-08
tags: [constraints, feasibility]
---

# Feasibility gates

| ID | Gate | Status | Notes |
|---|---|---|---|
| G1 | Pass WinCTRL **as-is** through GFN | **blocked** | Not on HOTAS whitelist |
| G2 | Virtual Xbox / XInput-class pad to GFN | **partial** | Fallback if Warthog spoof fails |
| G3 | Spoof whitelisted Warthog HID (`0402`+`0404`) | **unknown** | **v1 primary** — spike required |
| G4 | Install MobiFlight WASM on GFN MSFS | **blocked** | No Community access |
| G5 | SimConnect from home into GFN | **blocked** | Cloud host locked |
| G6 | Full MobiFlight on local MSFS | **viable** | Deferred (no Mac MF) |
| G7 | Keyboard/mouse injection into GFN | **partial** | Emergency only |

## Decision rule (current)

- v1 pursues **G3** (Warthog spoof). Empty `0402`+`0404` must appear in stock GFN → cloud MSFS.
- On G3 fail → try **G2** once; do not patch GFN; do not burn effort on G4/G5.
