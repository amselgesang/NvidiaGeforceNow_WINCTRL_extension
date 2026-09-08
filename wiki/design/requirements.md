---
title: Design — Requirements (v1 Warthog spoof)
status: draft
updated: 2026-09-08
tags: [design, requirements]
---

# Requirements — v1

Locked by [D5](decisions.md).

## Goals

1. Spoof **Warthog Flight Stick** (`044F:0402`) from WinWing joystick HID.
2. Spoof **Warthog Dual Throttle** (`044F:0404`) from WinWing throttle quadrant HID.
3. Prove both virtual devices pass stock GFN Mac → cloud MSFS before full mapping.

## Non-goals

MobiFlight; Xbox-pad as primary (fallback only); GFN patches; TARGET Combined device.

## Functional

| ID | Requirement |
|---|---|
| R1 | Read joystick source (Orion `4098:BEA8`) |
| R2 | Read throttle source when present (WinWing throttle PID) |
| R3 | Publish virtual `044F:0402` with joystick-class HID |
| R4 | Publish virtual `044F:0404` with throttle-class HID |
| R5 | Independent JSON profiles stick→0402 and throttle→0404 |
| R6 | Empty-sink spike mode (no physical hardware required) |
| R7 | Status for both sinks + sources |

## Success

- [ ] Both empty Warthog virtual devices bindable in cloud MSFS via GFN
- [ ] Orion → Warthog stick pitch/roll works
- [ ] Throttle quadrant → Warthog throttle works when attached
