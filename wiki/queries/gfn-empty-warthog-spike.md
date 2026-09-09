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
`com.apple.developer.hid.virtual.device`. Unsigned / ad-hoc `GFNBridge` fails at
`IOHIDUserDeviceCreate`; AMFI rejects with **-413**. The empty-spoof spike has **not** been
run successfully here.

`codesign` with `Entitlements/GFNBridge.entitlements` is **not** enough by itself. A
Developer ID stamp of that entitlement already verified on disk; AMFI still killed the
process because no provisioning profile **authorizes** the restricted entitlement.

## What signing vs provisioning actually do

| Piece | Role |
|---|---|
| `Entitlements/GFNBridge.entitlements` | Asks for HID Virtual Device (`com.apple.developer.hid.virtual.device`) |
| `scripts/sign-gfnbridge.sh` | Stamps that entitlement onto `.build/debug/GFNBridge` |
| **Provisioning profile** | Apple’s permission slip: this Team + this App ID + this Mac may use that entitlement |

Without the profile, launch dies before `main` (`taskgated-helper`: no eligible profiles;
AMFI **-413**).

## What you need to do (Apple, then local)

**1. Paid Apple Developer Program** (already implied by the existing Developer ID cert).

**2. Request the entitlement from Apple** — it is not a free checkbox for most accounts.

- Form: [System Extension / DriverKit entitlement request](https://developer.apple.com/contact/request/system-extension/)
- Choose **Virtual HID** (this is the CoreHID / `com.apple.developer.hid.virtual.device` key, not a DriverKit dext).
- Wait for email approval **(UNVERIFIED)** how long; often days.

**3. After Apple grants it**, in [Certificates, Identifiers & Profiles](https://developer.apple.com/account/resources/identifiers/list):

1. Create a **Mac** App ID (explicit bundle ID, e.g. `com.yourteam.gfnbridge`) — not a wildcard.
2. Enable **HID Virtual Device** on that App ID (the checkbox only appears after grant).
3. Create a **Mac Development** provisioning profile for that App ID, including **this Mac**.
4. Download the `.provisionprofile`.

Use an **Apple Development** identity for local spike runs, not Developer ID, unless Apple
explicitly granted the entitlement for Developer ID distribution (restricted entitlements
usually do not).

**4. Embed the profile** (bare SwiftPM binaries do not). Wrap the signed `GFNBridge` in a
tiny `.app`:

```text
GFNBridge.app/Contents/MacOS/GFNBridge          # copy of .build/debug/GFNBridge
GFNBridge.app/Contents/Info.plist               # CFBundleIdentifier = that App ID
GFNBridge.app/Contents/embedded.provisionprofile
```

Then sign the **app** with the Development identity + `Entitlements/GFNBridge.entitlements`.
Run `GFNBridge.app/Contents/MacOS/GFNBridge spike-both` (or `open` the app with args).

Do **not** use `swift run` after signing — it rebuilds an unsigned binary.

**5. Success looks like:** process stays up; stdout `published 044F:0402` / `044F:0404`;
`ioreg` shows both; then stock GFN → MSFS Controls (checklist).

If Apple refuses the request, G3 stays **(BLOCKED)**; next plan path is one Xbox HID
fallback (G2), then stop.

## Required outcome (when unblocked)

| Device | Cloud MSFS Controls listed? |
|---|---|
| Stick `044F:0402` | **(TODO)** |
| Throttle `044F:0404` | **(TODO)** |

- **Both Y** → G3 passed; proceed to Orion remap (Task 5).
- **Either N** → stop Warthog path; optional one Xbox fallback (G2), then stop; no GFN patch.

**Platform:** macOS 13+ (Apple Silicon expected).

## Run command (build → sign → run signed binary)

Do **not** use `swift run` after signing — it rebuilds and drops the entitlement signature.

```bash
swift build
scripts/sign-gfnbridge.sh "Developer ID Application: …"
.build/debug/GFNBridge spike-both
```
