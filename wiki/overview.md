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

## Current status — 2026-09-08

- **D5 approved;** design spec committed on branch `cursor/warthog-spoof-remapper-design`.
- Spec: [2026-09-08-nvs-warthog-spoof-remapper-design.md](../docs/superpowers/specs/2026-09-08-nvs-warthog-spoof-remapper-design.md)
- Plan: [2026-09-08-nvs-warthog-spoof-remapper.md](../docs/superpowers/plans/2026-09-08-nvs-warthog-spoof-remapper.md)
- Diagrams: [overview](diagrams/warthog-spoof-overview.html) · [sequence](diagrams/warthog-spoof-sequence.html)
- MobiFlight deferred (D3). Wiki linted for D5; plan ready.
- **Next:** execute plan Task 1 (package scaffold) → Tasks 2–4 (empty Warthog GFN spike gate).

## Risks

Descriptor match and ToS/brand spoof are experimental; empty-device GFN spike is the gate.
Xbox HID remains fallback only if Warthog spoof fails detection.
