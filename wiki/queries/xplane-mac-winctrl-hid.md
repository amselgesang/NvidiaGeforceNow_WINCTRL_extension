---
title: Query — How X-Plane 12 reads WinCTRL on Mac
status: draft
updated: 2026-09-08
tags: [query, xplane, macos, winctrl, hid]
---

# How X-Plane 12 reads WinCTRL / WinWing joysticks on Mac

## Local evidence (this Mac)

Attached right now: **WINWING Orion Joystick Base 2 + JGRIP-F16**

- VID/PID `0x4098:0xBEA8`
- IOKit `DeviceUsagePairs` = Generic Desktop / **Joystick** (`1` / `4`)
- Standard axes + buttons on report ID 1; vendor page `0xFF` on report ID 2

Full dump: [raw probe](../../raw/sources/2026-09-08-mac-orion-hid-probe.md).

## Two parallel paths in X-Plane on Mac

```
WinWing Orion (USB HID joystick)
        │
        ├─► Path A — X-Plane built-in joystick stack
        │     IOKit / SDL-style HID enumeration
        │     Settings → Joystick → calibrate & assign axes/buttons
        │     Used for pitch/roll/yaw/throttle-class axes
        │
        └─► Path B — winctrl X-Plane plugin (optional, Mac/Linux critical for panels)
              Opens HID directly (same VID 0x4098 family)
              Maps panel/button protocols + drives displays/LEDs via datarefs
              Explicitly leaves primary flight axes to Path A (community docs)
```

### Path A — native X-Plane joystick

- X-Plane does **not** need SimApp Pro on Mac for a device that already enumerates as a HID Joystick.
- User assigns axes in **Settings → Joystick** (calibrate, then map pitch/roll/etc.).
- OS-level drivers are not required for basic plug-and-play HID joysticks; X-Plane owns assignment.
- Historical Mac note: other apps (e.g. browsers with Gamepad API) can contend for HID open — close competing clients if the stick “vanishes” ([Laminar CSI: Joystick Edition](https://developer.x-plane.com/2012/08/csi-joystick-edition/)).

### Path B — `winctrl` plugin

- Repo: [rswilem/winctrl-xplane-plugin](https://github.com/rswilem/winctrl-xplane-plugin)
- Purpose on Mac/Linux: replace Windows-only **SimApp Pro** for WinWing **panels** (FCU, MCDU, EFIS, …) and richer device profiles.
- Compatibility matrix includes **ORION Joystick Base II** (your `0xBEA8` device).
- Linux docs stress: without the plugin you still get **basic joystick** behaviour; plugin unlocks displays/LEDs/aircraft-specific mappings.
- Emvisio summary: *“Axes (throttle levers, joystick) are deliberately left to X-Plane's built-in joystick configuration.”*

## What this means for NVS / GeForce NOW

| Consumer | Sees Orion as… | Result |
|---|---|---|
| macOS IOKit | HID Joystick `0x4098:0xBEA8` | Available to local apps |
| X-Plane 12 | Joystick device (+ optional winctrl HID client) | Axes bindable locally |
| GeForce NOW native Mac | Generic / non-whitelist stick | **Typically ignored** for cloud input |

So X-Plane working on Mac **proves Mac can read the hardware as a joystick**; it does **not** prove GFN will forward that same HID device. NVS still needs remapping (virtual Xbox HID / whitelist device / kb) for cloud.

## Practical takeaway for Mac-native NVS Bridge

1. **Input source:** read the same IOHID device X-Plane uses (`0x4098:0xBEA8`, Joystick usage) — no Windows required to *sample* axes/buttons.
2. **GFN sink:** still must present something GFN accepts (not “raw Orion joystick”).
3. **Do not fight X-Plane:** if both run, prefer shared HID access; exclusive opens will break one client (same class of bug Laminar documented with Chrome).

## Open follow-ups

- Confirm in a live XP12 session that Settings → Joystick lists `WINWING Orion…` (data dir not found in this probe’s stub `.app`).
- Whether winctrl plugin is installed on the user’s real XP12 tree.
- Whether GFN Mac client lists any HID joystick entries at all when Orion is plugged in (expect: no).
