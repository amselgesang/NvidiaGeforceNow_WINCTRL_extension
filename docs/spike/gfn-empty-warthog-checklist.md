# GFN empty Warthog spoof checklist (gate G3)

Fail-fast gate before Orion HID remapping (Task 5+). GFN Bridge publishes two **empty**
virtual Thrustmaster Warthog devices — stick `044F:0402` and dual throttle `044F:0404` —
with centered axes and no WinCTRL input attached.

**Stop condition:** Do not start Task 5 until **both** devices appear in stock GeForce NOW
→ cloud MSFS **Controls**. If either is missing, stop the Warthog path.

**Platform:** macOS 13+ (Apple Silicon expected).

---

## Prerequisite — sign with HID Virtual Device entitlement

Virtual HID publication requires an **eligible Apple Developer provisioning profile** that
includes the **HID Virtual Device** capability (`com.apple.developer.hid.virtual.device`).

On this machine, unsigned or ad-hoc builds fail: `IOHIDUserDeviceCreate` is rejected and AMFI
returns **-413** (“No matching profile found”). Ad-hoc signing alone is not sufficient.

1. Build: `swift build`
2. Sign with a codesigning identity that has the entitlement embedded:

   ```bash
   scripts/sign-gfnbridge.sh "Developer ID Application: Your Name (TEAMID)"
   ```

   Default binary path: `.build/debug/GFNBridge`. Pass a third argument to override.

3. Confirm the signed binary runs without the provisioning-profile error before continuing.

---

## Checklist

1. **Start spike:** run the **signed** binary directly — do **not** use `swift run` after
   signing (it rebuilds and drops the entitlement signature):

   ```bash
   .build/debug/GFNBridge spike-both
   ```

   Expect stdout: `published 044F:0402` and `published 044F:0404`. Process waits for Enter;
   leave it running through steps 2–4.

2. **Confirm both devices in macOS:** while the spike is running, verify both virtual devices
   enumerate locally (System Settings → Game Controllers, or IOKit / IORegistry). Look for
   Thrustmaster Warthog stick (`044F:0402`) and Warthog Dual Throttle (`044F:0404`).

3. **Launch stock GFN Mac → MSFS → Controls:** use the **stock** GeForce NOW Mac client (no
   patches). Stream MSFS and open **Settings → Controls** (or equivalent device list).

4. **Record results:**

   | Device | Listed in cloud MSFS Controls? |
   |---|---|
   | Warthog stick (`044F:0402`) | Y / N |
   | Warthog dual throttle (`044F:0404`) | Y / N |

5. **Decision:**

   - **Both Y** → G3 gate passed; proceed to Task 5 (Orion HID reader + remap).
   - **Either N** → **STOP** Warthog path. Optionally run **one** Xbox-class virtual pad
     fallback spike (G2), then stop; do **not** patch or modify GFN. File outcome under
     `wiki/queries/gfn-empty-warthog-spike.md`.

---

## Notes

- This checklist tests **empty spoof only** — no WinCTRL hardware, no axis remapping.
- GFN flight-control support is a **device whitelist** on the native client; generic
  DirectInput passthrough does not apply.
- See [feasibility gates](../../wiki/constraints/feasibility-gates.md) (G3 primary, G2 fallback).
