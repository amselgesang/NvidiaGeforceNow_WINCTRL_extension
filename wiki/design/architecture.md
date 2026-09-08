---
title: Design — System architecture (v1)
status: draft
updated: 2026-09-08
tags: [design, architecture]
---

# System architecture — v1

See [remapper.md](remapper.md) (D5 Warthog spoof).

## Path

```
WinWing stick HID     → Bridge → Virtual Warthog Flight Stick (044F:0402) ┐
WinWing throttle HID  → Bridge → Virtual Warthog Dual Throttle (044F:0404) ┼→ GFN Mac → Cloud MSFS
```

## Diagrams

- [overview](../diagrams/warthog-spoof-overview.html)
- [sequence](../diagrams/warthog-spoof-sequence.html)
