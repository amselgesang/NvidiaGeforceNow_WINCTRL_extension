---
title: Design — Open questions
status: draft
updated: 2026-09-08
tags: [design, questions]
---

# Open questions

## Q1 — v1 success criteria

**Status:** decided → hybrid then amended; final v1 = GFN Warthog-spoof inputs only ([D3](decisions.md)/[D5](decisions.md)).

## Q5 — Bridge host OS

- **D.** Mac-native Warthog HID spoof ([D5](decisions.md))

**Status:** **decided → D**.

## Q2 — Target sims / clients

Primary: MSFS on GeForce NOW via macOS native client. Others?

**Status:** open (default MSFS for spike).

## Q3 — Hardware inventory

- Stick: Orion Base 2 + JGRIP-F16 `4098:BEA8` (probed)
- Throttle: WinWing quadrant — confirm PID on attach (often Orion Throttle Base II `4098:BD64`)

**Status:** stick confirmed; throttle PID pending plug-in.

## Q4 — Acceptable compromises

Warthog spoof accepted (D5). If GFN rejects spoof, is Xbox HID fallback OK?

**Status:** open (spec allows one fallback try).
