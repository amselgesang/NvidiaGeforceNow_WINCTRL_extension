---
title: Design — Decisions
status: draft
updated: 2026-09-08
tags: [design, decisions]
---

# Design decisions

## D1 — v1 = GFN input bridge (MobiFlight out) — see D3

## D2 / D4 — Remap to GFN-accepted class — **amended by D5**

**D4 (superseded):** Virtual Xbox 360 HID as the single sink class.

**D5 (current):** Spoof **Thrustmaster Warthog** whitelist devices instead (see below).

## D3 — Skip MobiFlight in v1 (Mac)

Unchanged.

## D5 — Spoof Warthog Flight Stick + Dual Throttle

**Decision:** NVS Bridge publishes **two** virtual HID devices that impersonate
GFN-whitelisted Thrustmaster Warthog hardware:

| Physical role | Virtual sink (spoof) | USB ID |
|---|---|---|
| Joystick (e.g. Orion Base 2 + grip) | **HOTAS Warthog Flight Stick** | `0x044F:0x0402` |
| Throttle quadrant (WinWing throttle when present) | **HOTAS Warthog Dual Throttles** | `0x044F:0x0404` |

**Rationale (user):** Explicitly requested Warthog stick + dual throttle spoof so GFN
treats inputs as official HOTAS, with proper stick vs throttle separation (matches
Thrustmaster’s “each on its own USB port” GFN guidance).

**Sources:** Orion stick confirmed locally (`0x4098:0xBEA8`). Throttle source = WinWing
throttle HID when attached (e.g. Orion Throttle Base II `0xBD64` family — confirm on plug).

**Risks (honest):**
- Report-descriptor / axis layout must be close enough for GFN + MSFS — **unverified** until spike.
- Impersonating Thrustmaster USB IDs may conflict with vendor/NVIDIA terms; experimental.
- Xbox-pad path remains documented fallback if Warthog spoof fails GFN detection.

**Fail-fast spike:** Empty virtual `0402` + `0404` devices must appear in stock GFN Mac →
cloud MSFS Controls **before** wiring Orion maps.

**IDs source:** [raw/sources/2026-09-08-warthog-spoof-ids.md](../../raw/sources/2026-09-08-warthog-spoof-ids.md).
