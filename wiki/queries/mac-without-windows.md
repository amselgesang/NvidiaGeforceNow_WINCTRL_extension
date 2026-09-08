---
title: Query — Can NVS Bridge work without Windows?
status: draft
updated: 2026-09-08
tags: [query, macos, gfn, feasibility]
---

# Can it work without a Windows machine?

**Short answer (historical):** Mac-only is possible without Windows, but not via ViGEm.
**Current v1:** Mac-native **Warthog HID spoof** ([D5](../design/decisions.md)) — see [remapper](../design/remapper.md).

Xbox / gamepad virtual HID remains a **fallback** if Warthog spoof fails GFN detection.

## What does *not* work on Mac alone

| Approach | Why |
|---|---|
| ViGEmBus + virtual Xbox pad | Windows driver only |
| Classic “XInput” wording from Windows blogs | macOS has no XInput; GFN uses HID / GameController |

Community guides that remap arbitrary sticks for GFN on Mac almost always put you in a
**Windows VM** for ViGEm ([thomazrb RC→GFN write-up](../../raw/sources/2026-09-08-gfn-hotas-research.md)
mentions this explicitly).

## Mac-native options (no Windows OS)

### 1) Keyboard / mouse injection — **viable, limited**

GFN already forwards keyboard/mouse on macOS. Map WinCTRL buttons → keys; axes →
key spam or mouse — poor for smooth flight axes. Lowest risk spike; not a real HOTAS.

### 2) Virtual HID gamepad on macOS — **plausible, unverified for our stack**

macOS *can* create virtual HID devices (e.g. `IOHIDUserDevice`, DriverKit apps such as
OpenJoystickDriver with Xbox 360 / Xbox One HID compatibility modes). Separate community
work shows Steam’s virtual Xbox HID (`045e:028e`) *can* reach streamed games on Apple
Silicon **if** GFN’s HID backend is used; stock GFN sometimes prefers
`GameController.framework` and then **fails** to forward usable pad input (see
`gfn-steam-controller-fix` — patches GFN, ToS/account risk).

**Implication for NVS (current D5):**

`WinCTRL HID → NVS Bridge (macOS) → virtual Warthog 0402+0404 → native GFN`

Xbox-compatible HID is **fallback only** if Warthog spoof fails detection. Empty
Warthog devices must appear in cloud MSFS Controls before Orion mapping.

### 3) Patch / fork GFN client — **discouraged**

May fix forwarding; violates spirit of ToS; brittle across GFN updates. Out of scope
unless user explicitly accepts risk.

### 4) Buy whitelisted HOTAS — **works, not a WinCTRL bridge**

Official Mac GFN supports select Thrustmaster/Logitech devices. Does not help WinCTRL.

## Recommendation (post-D5)

| Goal | Path |
|---|---|
| v1 (locked) | Mac-native dual Warthog spoof — [plan](../../docs/superpowers/plans/2026-09-08-nvs-warthog-spoof-remapper.md) |
| If GFN rejects Warthog IDs | One Xbox HID fallback attempt, then stop |
| Honest expectation | Unknown until empty `0402`+`0404` appear in cloud MSFS Controls |

- Related: [WinCTRL](../entities/winctrl.md), [remapper](../design/remapper.md), [X-Plane HID](xplane-mac-winctrl-hid.md)