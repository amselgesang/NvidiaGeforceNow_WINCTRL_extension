---
title: Query — Can NVS Bridge work without Windows?
status: draft
updated: 2026-09-08
tags: [query, macos, gfn, feasibility]
---

# Can it work without a Windows machine?

**Short answer:** Yes, *possibly* — but **not** via the locked ViGEm/XInput design (D2).
That path needs Windows (PC or VM). A **Mac-native** path is a different architecture
and is only **partially evidenced**.

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

**Implication for NVS:** A Mac bridge would be:

`WinCTRL HID → NVS Bridge (macOS) → virtual Xbox-compatible HID → native GFN`

…and success depends on GFN actually forwarding that virtual device. **Not proven** with
WinCTRL yet. Treat as research spike, not committed design.

### 3) Patch / fork GFN client — **discouraged**

May fix forwarding; violates spirit of ToS; brittle across GFN updates. Out of scope
unless user explicitly accepts risk.

### 4) Buy whitelisted HOTAS — **works, not a WinCTRL bridge**

Official Mac GFN supports select Thrustmaster/Logitech devices. Does not help WinCTRL.

## Recommendation

| Goal | Path |
|---|---|
| Highest chance, soonest | Windows PC **or** Windows VM (keep D2) |
| No Windows at all | Pivot spike to **Mac virtual HID** (Option 2) + fail-fast GFN visibility test; keep keyboard layer as fallback |
| Honest expectation | Full analog WinCTRL→GFN on Mac-only is **unknown** until the empty virtual pad appears inside cloud MSFS |

- Related: [WinCTRL entity](../entities/winctrl.md), [Mac without Windows](mac-without-windows.md), [X-Plane HID path](xplane-mac-winctrl-hid.md)