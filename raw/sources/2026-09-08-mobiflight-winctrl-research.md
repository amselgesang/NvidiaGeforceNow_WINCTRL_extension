# Research notes — MobiFlight & WinCTRL (2026-09-08)

Immutable ingest snapshot.

## WinCTRL / WinWing hardware

- MobiFlight docs — WinCtrl devices
  - https://docs.mobiflight.com/game-controllers/winctrl/
  - Supported panels include AGP, ECAM, EFIS, FCU, MCDU, NWS, PAP 3, PFP variants, RMP,
    TCAS, Airbus throttle/sidestick, etc.
  - Inputs behave like game-controller inputs; CDU displays need extra MF config.
  - Conflict tip: SIMAPP PRO running can prevent detection; devices plugged after MF launch
    may not auto-detect.
  - Not "boards" in Modules tab — appear under Peripherals.

- Open-source HID work (WinWing / WINCTRL, VID often `0x4098`)
  - https://github.com/rswilem/winctrl-xplane-plugin
  - https://github.com/klemensurban/nocscienceat.WinWingAgp
  - https://emvisio.com/en/addon/tools/winctrl.html
  - Pattern: USB HID read buttons/encoders; write LCD/LED reports. Axes sometimes left to
    native joystick config. SIMAPP PRO is the vendor Windows stack; third parties talk HID
    directly.

## MobiFlight architecture

- Connector purpose: map microcontroller modules + game controllers ↔ sim events/vars.
  - Wiki: https://github-wiki-see.page/m/MobiFlight/MobiFlight-Connector/wiki/MobiFlight-Connector-How-does-it-work
  - MSFS path uses **MobiFlight WASM module** + SimConnect (not only FSUIPC).

- WASM module
  - https://github.com/MobiFlight/MobiFlight-WASM-Module
  - https://docs.mobiflight.com/guides/wasm-module/
  - Must live in the sim **Community** folder on the machine running MSFS.
  - Shared ClientData areas: Command / LVars / Response channels.

- Remote MobiFlight (sim on another PC)
  - https://github-wiki-see.page/m/MobiFlight/MobiFlight-Connector/wiki/Connecting-Mobiflight-to-MSFS2020-from-a-remote-PC
  - Requires: WASM on **sim PC**, SimConnect IPv4 allowed, `SimConnect.cfg` on MF PC,
    and a fake `flightsimulator.exe` process trick for detection.
  - **Does not** apply to GeForce NOW: you do not control the cloud Community folder or
    SimConnect listener exposure.

## Implications for this project

1. **Input half** of WinCTRL (buttons as HID) is conceptually remappable locally.
2. **Output half** (displays/LEDs) requires a host that owns SimConnect ↔ hardware.
3. Full MobiFlight on GFN is **blocked** unless NVIDIA/MS expose a supported remote
   SimConnect or Community injection path (none known as of this ingest).
