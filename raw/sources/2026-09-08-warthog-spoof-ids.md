# Research notes — Thrustmaster Warthog identities for GFN spoof (2026-09-08)

Immutable snapshot for sink-class targeting.

## USB IDs (usb.ids / DeviceHunt)

| Device | VID | PID |
|---|---|---|
| HOTAS Warthog Joystick (Flight Stick) | `0x044F` | `0x0402` |
| HOTAS Warthog Throttle (Dual Throttles) | `0x044F` | `0x0404` |

Vendor: ThrustMaster, Inc. (`0x044F`).

## GFN / Thrustmaster docs

- NVIDIA lists **Thrustmaster Warthog HOTAS** on Windows and macOS native GFN HOTAS support.
- Thrustmaster KB 1880: Warthog **Flight Stick**, **Dual Throttles**, and TPR each connect as **separate USB** devices to PC/Mac for GFN — no TARGET combine required for basic streaming support.

## Spoof implications

- Present **two** virtual HID devices matching `044F:0402` and `044F:0404`, not a single “Combined” TARGET device.
- Report-descriptor fidelity is **(UNVERIFIED)** — GFN may match on VID/PID only or require Warthog-like HID collections/axes. Spike must prove stock GFN Mac lists both virtual devices before full mapping.
- Brand/ToS risk: spoofing another vendor’s USB identity may conflict with NVIDIA/Thrustmaster terms; document as user-accepted experimental approach.
