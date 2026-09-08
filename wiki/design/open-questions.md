---
title: Design — Open questions
status: draft
updated: 2026-09-08
tags: [design, questions]
---

# Open questions

## Q1 — v1 success criteria (blocking)

What does "success" mean for v1?

- **A.** Flight axes + buttons only into GFN (no live CDU/LED sync)
- **B.** Full MobiFlight parity on GFN (inputs + displays/LEDs) — likely blocked; needs non-GFN or future API
- **C.** Hybrid: best-effort GFN inputs now + keep local MSFS + MobiFlight for full panels

**Status:** **decided → C (Hybrid).** See [D1](decisions.md).

## Q5 — Bridge host OS

- **D.** Mac-native only — remap HID Joystick → virtual Xbox HID ([D4](decisions.md))

**Status:** **decided → D** (user: remap standard HID joystick to GFN-accepted class).

## Q2 — Target sims / clients

MSFS 2020, MSFS 2024, DCS, X-Plane, others? Which GFN client OS (Windows native app assumed)?

**Status:** open.

## Q3 — Hardware inventory

Which exact WinCTRL devices must work in v1 (stick/throttle only vs FCU/MCDU/AGP/…)?

**Status:** open.

## Q4 — Acceptable compromises

Is virtual Xbox mapping OK if MSFS bindings must be rebuilt? Is keyboard injection OK for
panel buttons?

**Status:** open.
