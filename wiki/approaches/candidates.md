---
title: Approaches — Candidate architectures
status: draft
updated: 2026-09-08
tags: [approaches, architecture]
---

# Candidate approaches

**Parent strategy:** GFN XInput bridge ([D2](../design/decisions.md)); MobiFlight deferred ([D3](../design/decisions.md)).

| ID | Name | Role in v1 | Feasibility |
|---|---|---|---|
| A1 | Local XInput bridge | **Primary / only build** | partial |
| A2 | Keyboard/mouse injector | Deferred | partial |
| A3 | Whitelist HOTAS HID emulation | Research backlog | unknown |
| A4 | Full MobiFlight on GFN | Rejected | blocked |
| A5 | Hybrid dual-path (local MF) | **Deferred (D3 — no Mac MF)** | viable later |

Details: [hybrid-options.md](hybrid-options.md) (historical options; v1 = Option 1 only).
