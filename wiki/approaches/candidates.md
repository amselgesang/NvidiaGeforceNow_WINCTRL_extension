---
title: Approaches — Candidate architectures
status: draft
updated: 2026-09-08
tags: [approaches, architecture]
---

# Candidate approaches

**v1 locked:** Warthog stick + dual throttle spoof ([D5](../design/decisions.md)). MobiFlight deferred ([D3](../design/decisions.md)).

| ID | Name | Role in v1 | Feasibility |
|---|---|---|---|
| A6 | Dual Warthog HID spoof (`044F:0402` + `044F:0404`) | **Primary build** | unknown → spike |
| A1 | Local XInput / Xbox HID bridge | Fallback if A6 fails GFN detection | partial |
| A2 | Keyboard/mouse injector | Deferred | partial |
| A3 | Other whitelist HOTAS spoof | Covered by A6 (Warthog) | unknown |
| A4 | Full MobiFlight on GFN | Rejected | blocked |
| A5 | Hybrid dual-path (local MF) | Deferred (D3) | viable later |

Historical trade-off notes: [hybrid-options.md](hybrid-options.md) (pre-D5; XInput-first — superseded).
