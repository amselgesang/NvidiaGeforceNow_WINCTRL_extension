---
title: Concept — Input vs output split
status: draft
updated: 2026-09-08
tags: [concept, architecture]
---

# Input vs output split

WinCTRL + MobiFlight problems on NVS are **two systems**, not one.

| Direction | Examples | Needs |
|---|---|---|
| **Input (hardware → sim)** | Buttons, encoders, axes, switches | Something GFN will forward (whitelist device, XInput, kb/mouse) |
| **Output (sim → hardware)** | CDU screens, 7-seg, LEDs, backlight | Live sim state (SimConnect / WASM / LVars) + local HID writer |

A bridge that only solves inputs can still be valuable. Calling it "MobiFlight on GFN"
without outputs is **misleading** — document it as **input bridging**.

Related: [feasibility gates](../constraints/feasibility-gates.md).
