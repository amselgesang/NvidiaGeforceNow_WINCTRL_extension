---
title: Design — HID → Warthog spoof remapper
status: stable
updated: 2026-09-08
tags: [design, remapper, macos, gfn, warthog]
---

# Remapper design — HID → Warthog Flight Stick + Dual Throttle

Locked by [D5](decisions.md).

## Goal

```
WinWing joystick HID  ──►  GFN Bridge  ──►  Virtual Warthog Flight Stick (044F:0402)
WinWing throttle HID  ──►  GFN Bridge  ──►  Virtual Warthog Dual Throttle (044F:0404)
                                              │
                                              ▼
                                    GeForce NOW Mac (HOTAS whitelist)
                                              │
                                              ▼
                                         Cloud MSFS
```

## Sink class (GFN-accepted)

| Virtual device | Name | VID:PID |
|---|---|---|
| Stick sink | HOTAS Warthog Joystick / Flight Stick | `044F:0402` |
| Throttle sink | HOTAS Warthog Throttle / Dual Throttles | `044F:0404` |

Two separate virtual USB HID devices (not TARGET “Combined”).

## Source class

| Physical | Example | Maps to |
|---|---|---|
| Joystick | Orion Base 2 + JGRIP-F16 `4098:BEA8` (probed) | Warthog stick |
| Throttle quadrant | WinWing throttle (confirm PID on attach; Orion Throttle Base II often `4098:BD64`) | Warthog dual throttle |

## Components

| Piece | Role |
|---|---|
| Dual HID readers | Open stick + throttle sources (shared VID `0x4098`) |
| Profile mapper | Two profiles: stick→0402 axes/buttons; throttle→0404 axes/buttons |
| Dual virtual publishers | `IOHIDUserDevice` (or DriverKit) with Warthog VID/PID + joystick/throttle HID collections |
| Descriptor pack | Captured or reconstructed Warthog-like report descriptors **(spike-critical)** |
| Status | Per-device: source OK / sink OK / last sample |

## Default map sketch (tune after spike)

**Stick → `0402`:** Orion X/Y → Warthog stick X/Y (roll/pitch); hat → POV; grip buttons → Warthog button bits.

**Throttle → `0404`:** Primary lever(s) → Warthog throttle axes; flaps/speedbrake axes if present → matching Warthog axes; buttons → throttle button bank.

Exact Warthog axis indices require descriptor capture or public HID dumps during spike.

## Spike order (fail-fast)

1. Publish **empty** virtual `044F:0402` and `044F:0404` with plausible HID joystick/throttle collections.
2. Confirm macOS sees both devices.
3. Stock GFN Mac → MSFS Controls: both Warthog stick + throttle listed?
4. If **no** → abort spoof path; fall back to documented Xbox HID option or stop.
5. If **yes** → map Orion stick X/Y; then attach/map WinWing throttle.

## Risks

- GFN may whitelist by more than VID/PID (descriptor, usage pages, string descriptors).
- Legal/ToS: spoofing Thrustmaster identities is experimental; user-accepted.
- Incomplete throttle hardware on desk: stick-only spike still valid for `0402`.

## Non-goals

- MobiFlight; SimConnect; LEDs
- Patching GFN
- Single combined virtual device
- Perfect 1:1 Warthog button legend in v1 (good-enough axis flight first)

## Success criteria

- [ ] Empty virtual Warthog stick + throttle visible in cloud MSFS via stock GFN
- [ ] Orion stick drives Warthog stick pitch/roll in-cloud
- [ ] WinWing throttle drives Warthog throttle axis in-cloud (when hardware present)
- [ ] Profiles checked into repo
