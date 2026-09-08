---
title: Concept — GFN input model
status: draft
updated: 2026-09-08
tags: [concept, gfn, input]
---

# GFN input model

## Mental model

```
Local USB device
  → Local OS HID / GameController stack (macOS; Windows blogs say “XInput”)
    → GeForce NOW client (whitelist / supported class filter)
      → Encoded input over stream
        → Cloud game process (sees a supported pad / HOTAS / kb/mouse)
```

Anything that never looks like a **supported class** to the GFN client never arrives in
the cloud game — changing MSFS bindings cannot fix that.

## Supported classes (practical)

- Keyboard / mouse (client-dependent)
- Standard gamepads / Xbox-compatible HID (often forwarded)
- Whitelisted flight HOTAS (Thrustmaster Warthog stick+throttle, T.Flight, Logitech X52/X56, …)
- Experimental: virtual devices matching a whitelist or gamepad identity

## Not a supported class (practical today)

- Arbitrary DirectInput / generic HID joysticks (e.g. raw WinWing Orion) as-is
- Custom vendor display protocols

See [GeForce NOW](../entities/geforce-now.md). v1 remaps Orion → Warthog whitelist IDs ([D5](../design/decisions.md)).
