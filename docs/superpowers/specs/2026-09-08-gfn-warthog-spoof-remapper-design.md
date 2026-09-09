# GFN Bridge — Warthog Spoof Remapper Design

**Date:** 2026-09-08  
**Status:** Approved for implementation planning (user sign-off 2026-09-08)  
**Wiki mirrors:** `wiki/design/remapper.md`, `wiki/design/decisions.md` (D3, D5)

## Problem

GeForce NOW on macOS only forwards a whitelist of flight peripherals (including Thrustmaster Warthog HOTAS). WinWing / WinCTRL hardware enumerates as a generic **HID Joystick** (e.g. Orion Base 2 + JGRIP-F16 `0x4098:0xBEA8`). Local X-Plane can bind that joystick; GFN ignores it.

## Goal

Build **GFN Bridge** (macOS): read WinWing joystick and throttle HID, republish as **two** virtual devices that impersonate GFN-whitelisted Warthog units:

| Physical role | Virtual spoof | USB ID |
|---|---|---|
| Joystick | HOTAS Warthog Flight Stick | `0x044F:0x0402` |
| Throttle quadrant | HOTAS Warthog Dual Throttles | `0x044F:0x0404` |

Path: physical HID → bridge mapper → virtual Warthog HID pair → stock GFN Mac → cloud MSFS.

## Non-goals

- MobiFlight, SimConnect, panel displays/LEDs
- Patching or forking the GFN client
- TARGET-style single “Combined” virtual device
- Windows ViGEm as the primary v1 path (documented fallback only: Xbox HID if Warthog spoof fails)
- Perfect 1:1 Warthog button legends in v1 (flight axes first)

## Architecture

```
WinWing stick HID (4098:BEA8) ──► ┐
                                  ├─► GFN Bridge ─┬─► Virtual Warthog Stick  (044F:0402) ─┐
WinWing throttle HID (e.g. BD64) ► ┘              └─► Virtual Warthog Throttle (044F:0404) ┼─► GFN ─► Cloud MSFS
```

### Components

1. **HID readers** — IOHIDManager/hidapi; open stick and throttle by VID/PID; sample standard joystick reports (Orion report ID 1).
2. **Profile mapper** — JSON profiles: `stick→0402`, `throttle→0404` (axis scale, deadzone, button bits).
3. **Virtual HID publishers** — `IOHIDUserDevice` and/or DriverKit; set VID/PID/strings; feed input reports matching Warthog-like collections.
4. **Descriptor pack** — Warthog-like report descriptors (capture from real device docs/dumps or reconstruct). Spike-critical.
5. **Status surface** — CLI (and optional menu-bar later): per source/sink health, last sample, spike checklist.

### Diagrams

- `wiki/diagrams/warthog-spoof-overview.html` — dual-path architecture  
- `wiki/diagrams/warthog-spoof-sequence.html` — capture → spoof → stream  

## Spike plan (fail-fast gate)

Must pass before full Orion mapping work:

1. Publish **empty** virtual `044F:0402` and `044F:0404` with plausible joystick/throttle HID collections.
2. Confirm both appear in macOS (IOKit / controller list).
3. Launch **stock** GFN Mac → MSFS → Controls: both Warthog stick and throttle listed?
4. **Fail:** stop Warthog path; optionally try Xbox HID fallback; do not patch GFN.
5. **Pass:** map Orion X/Y → stick sink; then map WinWing throttle when attached.

Stick-only physical hardware is acceptable for the first mapping milestone after both empty sinks pass detection; throttle mapping waits on hardware presence.

## Mapping (initial)

**Stick → 0402:** Orion X/Y → Warthog stick X/Y (roll/pitch); hat → POV; subset of buttons → Warthog buttons.

**Throttle → 0404:** Primary lever(s) → Warthog throttle axis/axes; optional flaps/speedbrake; button bank as available.

Exact Warthog axis indices locked during spike from descriptor analysis.

## Risks and mitigations

| Risk | Mitigation |
|---|---|
| GFN matches more than VID/PID | Spike with realistic descriptors; abort if undetected |
| Brand/USB identity spoof vs ToS | Explicit experimental scope; user-accepted |
| HID exclusive open vs X-Plane | Document: stop XP or avoid exclusive grabs |
| Throttle PID unknown until plug | Probe on attach; profile keyed by PID |

## Success criteria

- [ ] Empty virtual Warthog stick + throttle visible in cloud MSFS via stock GFN Mac
- [ ] Orion stick drives in-cloud pitch/roll through `0402`
- [ ] WinWing throttle drives in-cloud throttle through `0404` when present
- [ ] Stick and throttle JSON profiles in repo
- [ ] Architecture diagrams match shipped behavior

## Platform

- **Primary:** macOS 13+ (Apple Silicon expected), stock GeForce NOW native app
- **Language/runtime:** Swift or C/C++/Rust with IOKit — choose in implementation plan for HID ergonomics and signing
- **Signing:** local development signing sufficient for spike; notarization out of v1 unless required for DriverKit

## Open items for implementation plan (not blockers for this spec)

- Concrete choice: pure `IOHIDUserDevice` vs DriverKit dext for virtual devices
- Source of Warthog report descriptors (public dump vs reconstruct)
- Confirm WinWing throttle product ID when user plugs the quadrant

## References

- `raw/sources/2026-09-08-mac-orion-hid-probe.md`
- `raw/sources/2026-09-08-warthog-spoof-ids.md`
- `raw/sources/2026-09-08-gfn-hotas-research.md`
- `wiki/queries/xplane-mac-winctrl-hid.md`
- NVIDIA / Thrustmaster GFN HOTAS whitelist (Warthog listed; stick and dual throttles as separate USB devices)
