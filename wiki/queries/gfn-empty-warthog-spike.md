---
title: Query — GFN empty Warthog dual-device spike
status: draft
updated: 2026-09-08
tags: [query, gfn, msfs, warthog, spike, blocked]
---

# GFN empty Warthog dual-device spike (G3 gate)

## Status: **(BLOCKED)** — provisioning + user run pending

Checklist: [docs/spike/gfn-empty-warthog-checklist.md](../../docs/spike/gfn-empty-warthog-checklist.md).

## Blocker (this machine)

Live virtual HID publication requires an Apple Developer provisioning profile with
`com.apple.developer.hid.virtual.device`. Unsigned / ad-hoc `NVSBridge` fails at
`IOHIDUserDeviceCreate`; AMFI rejects with **-413**. The empty-spoof spike has **not** been
run successfully here.

## Required outcome (when unblocked)

| Device | Cloud MSFS Controls listed? |
|---|---|
| Stick `044F:0402` | **(TODO)** |
| Throttle `044F:0404` | **(TODO)** |

- **Both Y** → G3 passed; proceed to Orion remap (Task 5).
- **Either N** → stop Warthog path; optional one Xbox fallback (G2); no GFN patch.

## Run command (after sign)

```bash
scripts/sign-nvsbridge.sh "Developer ID Application: …"
swift run NVSBridge spike-both
```
