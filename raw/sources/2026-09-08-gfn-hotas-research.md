# Research notes — GeForce NOW flight controls (2026-09-08)

Immutable ingest snapshot. Claims below should be mirrored into wiki entity/constraint
pages; prefer citing this file + original URLs.

## Official / NVIDIA

- NVIDIA Help: "Does GeForce NOW support Flight Controls and HOTAS?"
  - https://nvidia.custhelp.com/app/answers/detail/a_id/5787/
  - States support for **select** devices on latest **Windows** and **macOS** native apps:
    Thrustmaster T.Flight Hotas One, T.Flight Hotas 4*, T.Flight Rudder Pedals,
    Logitech X52 / X52 Pro.
  - Other OS: N/A.
  - Look for flight-controls badge on game details; any game that supports HOTAS should work
    with supported devices.
  - *(Fetched page sometimes returns Oracle technical difficulty; content also summarized
    widely in secondary sources dated ~2026-01.)*

- NVIDIA Blog — GFN Thursday: Flight Controls on GeForce NOW (2026-01-22)
  - https://blogs.nvidia.com/blog/geforce-now-thursday-flight-controls/
  - Initial rollout highlighted Thrustmaster T.Flight HOTAS One; NVIDIA says more peripherals
    planned over time.

## Community / technical analysis

- Fly Away Simulation Q&A — joystick with MSFS 2024 on GFN
  - https://flyawaysimulation.com/ask/answers/joystick-msfs-2024-geforce-now/
  - Claim: GFN does **not** expose a standard DirectInput joystick as raw hardware inside
    the cloud PC; limitation sits between local hardware and GFN, not inside MSFS bindings.
  - Suggests Xbox-style gamepad as dependable; virtual remapping "experimental fallback."

- thomazrb — RC radio as joystick via GFN (MSFS 2024)
  - https://thomazrb.github.io/posts/rc-radio-joystick-geforce-now/
  - Claim: GFN only forwards **XInput** controllers; DirectInput ignored.
  - Workaround: ViGEmBus + XOutput to present Xbox 360 controller; then configure in MSFS.
  - Mac needs Windows VM for virtual controller creation.

## Implications for this project

1. WinCTRL devices are not on the published HOTAS whitelist → not expected to pass natively.
2. Axis/button path may be addressable via **virtual XInput** (or future whitelist expansion).
3. Display/LED/SimConnect path is a separate problem (see MobiFlight research notes).
