# Local Mac observation — Winwing Orion on this machine (2026-09-08)

Immutable probe notes from the user's Mac while researching X-Plane joystick path.

## USB / HID identity

| Field | Value |
|---|---|
| Product string | `WINWING Orion Joystick Base 2 + JGRIP-F16` |
| Manufacturer | `Winwing` |
| idVendor | `16536` = `0x4098` |
| idProduct | `48808` = `0xBEA8` |
| Transport | USB |
| DeviceUsagePairs | UsagePage `1` (Generic Desktop), Usage `4` (**Joystick**) |
| PrimaryUsage | `4` (Joystick) |

Matches winctrl-xplane-plugin udev alias `winctrl-orion-joystick-base-2` (`ATTRS{idProduct}=="bea8"`).

## Report shape (IOHID)

- **Report ID 1:** standard joystick controls
  - Buttons: UsagePage `9` (Button), many button usages
  - Hat: UsagePage `1`, Usage `57` (Hat switch)
  - Axes: Usage `48` (X), `49` (Y), plus `51`–`54` (Rx/Ry/Rz/Slider-class)
- **Report ID 2:** UsagePage `255` (vendor-defined) — extra protocol channel used by WinWing tooling / plugins

## Apps observed

- `X-Plane 12.app` present under Desktop/Applications, but the inspected Desktop bundle Resources folder is a stub (no `plugins` / `joystick configs`). Full XP12 data directory not located in this probe.
- Device is live in IOKit regardless.

## Implication

macOS already classifies this stick as a **standard HID Joystick**. Local sims that enumerate IOKit/SDL joysticks (X-Plane) can bind axes in Settings → Joystick without Windows drivers. GeForce NOW still ignores generic joysticks unless remapped to an accepted class.
