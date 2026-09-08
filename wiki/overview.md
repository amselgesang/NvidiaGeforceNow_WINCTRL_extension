---
title: Project Overview
status: draft
updated: 2026-09-08
tags: [meta, overview]
---

# NVS Extension — Overview

## One-liner

Remap WinWing **joystick** and **throttle quadrant** HID into **spoofed Thrustmaster
Warthog Flight Stick** (`044F:0402`) and **Dual Throttle** (`044F:0404`) so GeForce NOW’s
HOTAS whitelist forwards them into cloud MSFS.

## Current status

- **D5 approved;** formal spec at [`docs/superpowers/specs/2026-09-08-nvs-warthog-spoof-remapper-design.md`](../docs/superpowers/specs/2026-09-08-nvs-warthog-spoof-remapper-design.md).
- Awaiting spec review before implementation plan.

## Risks

Descriptor match and ToS/brand spoof are experimental; empty-device GFN spike is the gate.
