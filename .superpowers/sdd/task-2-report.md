# Task 2 Report: Warthog Descriptor Pack + Empty Stick Publisher

**Status:** DONE_WITH_CONCERNS

## Commit

- `b2159a0 feat: publish empty virtual Warthog flight stick`

## TDD Evidence

### RED

Added `DescriptorSmokeTests.testWarthogStickDescriptorNonEmpty` before production code.

Command:

```text
swift test --filter DescriptorSmokeTests
```

Expected failure observed:

```text
DescriptorSmokeTests.swift:6:24: error: cannot find 'WarthogDescriptors' in scope
```

The first sandboxed invocation was blocked while SwiftPM compiled the manifest, so the
same command was rerun outside that sandbox to obtain the required feature-missing RED.

### GREEN

After implementing the descriptor and publisher:

```text
swift test --filter DescriptorSmokeTests
Executed 1 test, with 0 failures (0 unexpected)
```

Full suite:

```text
swift test
Executed 2 tests, with 0 failures (0 unexpected)
```

## Files Changed

- `Sources/NVSBridge/HID/WarthogDescriptors.swift`
  - Added a non-empty Generic Desktop Joystick descriptor with signed 16-bit X/Y axes
    and 32 buttons.
- `Sources/NVSBridge/HID/VirtualHIDPublisher.swift`
  - Added `VirtualHIDPublisher.publishWarthogStick(centered:)`.
  - Creates an `IOHIDUserDevice` with VID `0x044F`, PID `0x0402`, Warthog-like
    manufacturer/product strings, and the stick descriptor.
  - Retains the device and sends an eight-byte centered idle report when requested.
- `Sources/NVSBridge/main.swift`
  - Added the `spike-stick` command, success message, Enter wait, and error reporting.
- `Tests/NVSBridgeTests/DescriptorSmokeTests.swift`
  - Added the exact descriptor/VID/PID smoke assertions from the task brief.

No throttle descriptor, throttle device ID, throttle CLI command, Orion mapping change,
dependency, Package manifest change, or wiki edit was added.

## Manual IORegistry Result

The binary compiled, but this host rejected virtual HID creation:

```text
.build/debug/NVSBridge spike-stick
failed to publish Warthog stick: deviceCreationFailed
```

The installed macOS 26.5 SDK documents that
`com.apple.developer.hid.virtual.device` is required for
`IOHIDUserDeviceCreateWithProperties`. This unsigned SwiftPM CLI does not have that
entitlement, so it exits before printing the success message or waiting for Enter.

The follow-up registry check produced no match:

```text
ioreg -c IOHIDDevice -r | rg -i "0402|Warthog"
# exit 1, no output
```

## Self-Review

- Verified `git diff --check` passed.
- Verified the exact Warthog stick VID/PID and descriptor property keys are used.
- Verified the zeroed initial report is centered for the descriptor's signed X/Y range.
- Verified the publisher retains the created device for the CLI's lifetime.
- Verified all requested automated tests pass.
- Verified Task 3 interfaces remain absent.

## Concerns

- Manual publication is blocked on this machine by the virtual-HID entitlement
  requirement. The implementation is complete and compiled, but a suitably signed and
  entitled executable is needed to validate the live IORegistry appearance.

---

# Important Review Fix: Virtual HID Signing

**Status:** DONE_WITH_CONCERNS

## Fix

- Added `Entitlements/NVSBridge.entitlements` with
  `com.apple.developer.hid.virtual.device = true`.
- Added executable `scripts/sign-nvsbridge.sh`, which signs the SwiftPM binary with a
  supplied signing identity, verifies the signature, and prints the embedded entitlements.
- Made `deviceCreationFailed` explain the required entitlement and exact signing script.
- Added a regression test for that actionable error. Its RED result was:

```text
swift test --filter DescriptorSmokeTests
DescriptorSmokeTests.swift:12:69: error: value of type 'VirtualHIDPublisherError'
has no member 'errorDescription'
```

## Required Tests

```text
swift test --filter DescriptorSmokeTests
Executed 2 tests, with 0 failures (0 unexpected)

swift test
Executed 3 tests, with 0 failures (0 unexpected)
```

## Signing and Publication Evidence

Command:

```text
swift build &&
scripts/sign-nvsbridge.sh 'Developer ID Application: Tamas Marton (Z4JDQGR29E)'
```

Exact relevant output:

```text
Build complete! (0.14s)
.build/debug/NVSBridge: replacing existing signature
.build/debug/NVSBridge: valid on disk
.build/debug/NVSBridge: satisfies its Designated Requirement
[Dict]
    [Key] com.apple.developer.hid.virtual.device
    [Value]
        [Bool] true
```

Signed publication command and result:

```text
.build/debug/NVSBridge spike-stick </dev/null
exit_status=137
```

The process was killed by macOS before Swift `main` could print an error. Unified-log
evidence for that exact launch:

```text
taskgated-helper: Disallowing NVSBridge because no eligible provisioning profiles found
amfid: NVSBridge not valid: Error Domain=AppleMobileFileIntegrityError Code=-413
"No matching profile found"
kernel: Code has restricted entitlements, but the validation of its code signature failed.
```

The required registry command produced no device:

```text
ioreg -c IOHIDDevice -r | rg -i '0402|Warthog'
exit_status=1
```

The improved unsigned/ad-hoc failure path was also exercised:

```text
failed to publish Warthog stick: IOHIDUserDevice creation was rejected. NVSBridge must
be signed with the com.apple.developer.hid.virtual.device entitlement. Run
scripts/sign-nvsbridge.sh after swift build, then launch
.build/debug/NVSBridge spike-stick.
exit_status=1
```

## Concern

The available Developer ID identity can embed and cryptographically verify the restricted
entitlement, but this host has no eligible provisioning profile authorizing it. AMFI
therefore terminates the executable at load time, and IORegistry never shows 0402/Warthog.
