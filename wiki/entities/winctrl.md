---
title: Entity — WinCTRL / WinWing hardware
status: draft
updated: 2026-09-08
tags: [entity, winctrl, hardware]
---

# WinCTRL / WinWing hardware

Physical cockpit panels and flight controls (FCU, EFIS, MCDU/PFP, AGP, throttles, etc.)
sold under WinCTRL / WinWing branding. USB HID vendor ID commonly `0x4098`.

## Two faces of the same device

1. **Inputs** — buttons, encoders, switches, sometimes axes. Visible to Windows as HID /
   game-controller style devices. MobiFlight documents many of these under "WinCtrl devices".
2. **Outputs** — LCD/7-segment displays, LEDs, backlighting. Require a host app that writes
   HID output reports (MobiFlight, SIMAPP PRO, or open-source HID drivers).

## Conflicts / tips

- Vendor **SIMAPP PRO** can hold the device and block MobiFlight detection.
- Hot-plug after MobiFlight start may require MF restart.

## Sources

- [raw MF/WinCTRL notes](../../raw/sources/2026-09-08-mobiflight-winctrl-research.md)
- Related: [MobiFlight](mobiflight.md), [input vs output split](../concepts/input-vs-output-split.md)
