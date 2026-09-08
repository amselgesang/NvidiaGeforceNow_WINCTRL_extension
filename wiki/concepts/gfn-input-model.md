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
  → Local OS HID / XInput stack
    → GeForce NOW client (whitelist / supported class filter)
      → Encoded input over stream
        → Cloud game process (sees a supported pad / HOTAS / kb/mouse)
```

Anything that never looks like a **supported class** to the GFN client never arrives in
the cloud game — changing MSFS bindings cannot fix that.

## Supported classes (practical)

- Keyboard / mouse (client-dependent)
- Standard gamepads (XInput)
- Whitelisted flight HOTAS (Thrustmaster / Logitech models in NVIDIA docs)
- Experimental: virtual XInput devices created locally (ViGEm + mapper tools)

## Not a supported class (practical today)

- Arbitrary DirectInput joysticks / many cockpit HID panels as-is
- Custom vendor display protocols (those stay local unless a local host drives them)

See [GeForce NOW](../entities/geforce-now.md).
