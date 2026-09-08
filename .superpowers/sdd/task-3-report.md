# Task 3 Report: Empty Warthog Dual Throttle Publisher

**Status:** DONE_WITH_CONCERNS

## Commit

- `feat: publish empty virtual Warthog dual throttle`

## TDD Evidence

Added `DescriptorSmokeTests.testWarthogThrottleIDs` first with the exact assertion from
the brief.

RED:

```text
swift test --filter DescriptorSmokeTests/testWarthogThrottleIDs
DescriptorSmokeTests.swift:12:34: error: type 'DeviceIDs' has no member 'warthogThrottle'
```

The first sandboxed invocation was blocked while SwiftPM compiled the manifest, so the
same test was rerun outside that sandbox to observe the expected missing-interface failure.

GREEN:

```text
swift test --filter DescriptorSmokeTests/testWarthogThrottleIDs
Executed 1 test, with 0 failures (0 unexpected)
```

## Implementation

- Added `DeviceIDs.warthogThrottle` as `0x044F:0x0404`.
- Added a non-empty dual-throttle HID descriptor with two unsigned 16-bit axes.
- Added `VirtualHIDPublisher.publishWarthogThrottle(centered:)`, retaining the virtual
  device and sending a four-byte zeroed idle report when requested.
- Added `spike-throttle` and `spike-both`; the latter publishes stick then throttle,
  prints both IDs, and waits for Enter.
- Preserved the existing actionable provisioning-profile failure path.
- Did not implement Orion HID reading, JSON profiles, or wiki changes.

## Required Tests

```text
swift test
Executed 4 tests, with 0 failures (0 unexpected)
```

`git diff --check` also passed.

## Manual IORegistry Result

Live publication was attempted:

```text
.build/debug/NVSBridge spike-throttle </dev/null
failed to publish Warthog throttle: IOHIDUserDevice creation was rejected...
exit_status=1
```

The failure explains that an eligible Apple Developer provisioning profile with the HID
Virtual Device capability is required. The follow-up registry search found no device:

```text
ioreg -r -c IOHIDDevice -l | rg -i '"VendorID" = 1103|"ProductID" = 1028|Warthog Dual|044F|0404'
exit_status=1
```

## Self-Review

- Confirmed the requested VID/PID, descriptor, product string, publisher API, command
  names, publication order, printed IDs, and Enter wait.
- Confirmed the existing stick interface and behavior remain intact.
- Confirmed Task 2's pre-existing report modification and `.build/` are excluded from
  this task's commit.

## Concern

The code compiles and all unit tests pass, but live `0404` publication remains blocked
on this host by the known Apple HID Virtual Device provisioning requirement.
