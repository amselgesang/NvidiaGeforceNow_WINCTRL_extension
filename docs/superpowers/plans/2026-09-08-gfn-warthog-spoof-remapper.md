# GFN Warthog Spoof Remapper Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ship a macOS GFN Bridge that reads WinWing stick/throttle HID and publishes virtual Thrustmaster Warthog Flight Stick (`044F:0402`) and Dual Throttle (`044F:0404`) for GeForce NOW.

**Architecture:** Swift package CLI — HID readers → JSON profile mapper → dual `IOHIDUserDevice` publishers. Fail-fast empty-spoof spike before Orion mapping.

**Tech Stack:** Swift 5.9+, SwiftPM, IOKit (`IOHIDManager` / `IOHIDUserDevice`), XCTest, macOS 13+

## Global Constraints

- Platform: macOS 13+ (Apple Silicon expected); stock GFN native app
- Sinks: exactly two virtual devices — `0x044F:0x0402` and `0x044F:0x0404` (not TARGET Combined)
- Source stick: Orion `0x4098:0xBEA8` (probed); throttle PID confirmed on attach
- No MobiFlight / SimConnect / GFN client patches
- On empty-spoof GFN failure: one Xbox-HID fallback attempt max, then stop
- Design spec: `docs/superpowers/specs/2026-09-08-gfn-warthog-spoof-remapper-design.md`

## File structure

```
Package.swift
Sources/GFNBridge/
  main.swift                 # CLI entry
  HID/
    DeviceIDs.swift          # VID/PID constants
    HIDReader.swift          # open/read physical devices
    VirtualHIDPublisher.swift
    WarthogDescriptors.swift # report descriptor bytes
  Mapping/
    Profile.swift            # Codable JSON profiles
    Mapper.swift             # axis/button transform
  Status/
    BridgeStatus.swift
Resources/profiles/
  orion-stick-to-warthog.json
  winwing-throttle-to-warthog.json
Tests/GFNBridgeTests/
  MapperTests.swift
  ProfileTests.swift
  DescriptorSmokeTests.swift
docs/spike/
  gfn-empty-warthog-checklist.md
```

---

### Task 1: Swift package scaffold + mapper tests

**Files:**
- Create: `Package.swift`
- Create: `Sources/GFNBridge/Mapping/Profile.swift`
- Create: `Sources/GFNBridge/Mapping/Mapper.swift`
- Create: `Sources/GFNBridge/HID/DeviceIDs.swift`
- Create: `Tests/GFNBridgeTests/MapperTests.swift`
- Create: `Sources/GFNBridge/main.swift`

**Interfaces:**
- Produces: `struct AxisMap`, `struct Profile`, `func mapSample(_:HIDSample, profile:) -> WarthogReport`

- [ ] **Step 1: Write failing mapper test**

```swift
import XCTest
@testable import GFNBridge

final class MapperTests: XCTestCase {
    func testOrionXYMapsToWarthogStickXY() {
        let profile = Profile.stickIdentity()
        let sample = HIDSample(axes: [0: 0.5, 1: -0.25], buttons: [], hat: nil)
        let report = Mapper.mapStick(sample, profile: profile)
        XCTAssertEqual(report.x, 0.5, accuracy: 0.001)
        XCTAssertEqual(report.y, -0.25, accuracy: 0.001)
    }
}
```

- [ ] **Step 2: Run test — expect fail**

Run: `swift test --filter MapperTests.testOrionXYMapsToWarthogStickXY`
Expected: FAIL (module/types missing)

- [ ] **Step 3: Minimal Package.swift + types + mapper**

```swift
// swift-tools-version: 5.9
import PackageDescription
let package = Package(
    name: "GFNBridge",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(name: "GFNBridge", path: "Sources/GFNBridge"),
        .testTarget(name: "GFNBridgeTests", dependencies: ["GFNBridge"], path: "Tests/GFNBridgeTests"),
    ]
)
```

Implement `Profile`, `HIDSample`, `WarthogStickReport`, `Mapper.mapStick` with identity mapping.

- [ ] **Step 4: Run test — expect pass**

Run: `swift test --filter MapperTests`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add Package.swift Sources Tests
git commit -m "feat: scaffold GFNBridge package with stick mapper tests"
```

---

### Task 2: Warthog descriptor pack + empty stick publisher

**Files:**
- Create: `Sources/GFNBridge/HID/WarthogDescriptors.swift`
- Create: `Sources/GFNBridge/HID/VirtualHIDPublisher.swift`
- Create: `Sources/GFNBridge/HID/DeviceIDs.swift` (if not already)
- Create: `Tests/GFNBridgeTests/DescriptorSmokeTests.swift`
- Modify: `Sources/GFNBridge/main.swift` — `gfn-bridge spike-stick`

**Interfaces:**
- Produces: `VirtualHIDPublisher.publishWarthogStick(centered: Bool) throws`
- Consumes: descriptor bytes for joystick collection with VID/PID `0x044F`/`0x0402`

- [ ] **Step 1: Write descriptor smoke test**

```swift
func testWarthogStickDescriptorNonEmpty() {
    XCTAssertFalse(WarthogDescriptors.flightStick.isEmpty)
    XCTAssertEqual(DeviceIDs.warthogStick.vid, 0x044F)
    XCTAssertEqual(DeviceIDs.warthogStick.pid, 0x0402)
}
```

- [ ] **Step 2: Run — expect fail**

Run: `swift test --filter DescriptorSmokeTests`
Expected: FAIL

- [ ] **Step 3: Add descriptor constants + publisher stub**

Embed a minimal Generic Desktop Joystick HID report descriptor; set product/vendor strings to Warthog-like names. Implement `IOHIDUserDevice` create properties:
- `kIOHIDVendorIDKey` = `0x044F`
- `kIOHIDProductIDKey` = `0x0402`
- `kIOHIDReportDescriptorKey` = descriptor data

CLI: `swift run GFNBridge spike-stick` creates device, prints “published 044F:0402”, waits on Enter.

- [ ] **Step 4: Manual macOS check**

Run spike; confirm device appears via `ioreg -c IOHIDDevice -r | rg -i "0402|Warthog"`.
Expected: match on virtual stick.

- [ ] **Step 5: Commit**

```bash
git commit -am "feat: publish empty virtual Warthog flight stick"
```

---

### Task 3: Empty Warthog dual throttle publisher

**Files:**
- Modify: `WarthogDescriptors.swift` — throttle descriptor
- Modify: `VirtualHIDPublisher.swift` — `publishWarthogThrottle`
- Modify: `main.swift` — `spike-throttle` and `spike-both`

- [ ] **Step 1: Test PID constant `0x0404`**

```swift
func testWarthogThrottleIDs() {
    XCTAssertEqual(DeviceIDs.warthogThrottle.pid, 0x0404)
}
```

- [ ] **Step 2: Implement throttle publisher + `spike-both`**

- [ ] **Step 3: Manual ioreg check for `0404`**

- [ ] **Step 4: Commit**

```bash
git commit -am "feat: publish empty virtual Warthog dual throttle"
```

---

### Task 4: GFN empty-spoof checklist (gate)

**Files:**
- Create: `docs/spike/gfn-empty-warthog-checklist.md`
- Modify: `wiki/log.md` (append spike result when run)

- [ ] **Step 1: Write checklist**

Contents must include:
1. Start `gfn-bridge spike-both`
2. Confirm both devices in macOS
3. Launch stock GFN Mac → MSFS → Controls
4. Record: stick listed Y/N; throttle listed Y/N
5. If either N → STOP Warthog path; optional one Xbox fallback; no GFN patch

- [ ] **Step 2: User/agent executes checklist; file result in `wiki/queries/` if fail**

- [ ] **Step 3: Commit checklist**

```bash
git add docs/spike wiki/log.md
git commit -m "docs: add GFN empty Warthog spike checklist"
```

**Stop condition:** Do not start Task 5 until both devices list in cloud MSFS Controls.

---

### Task 5: Orion HID reader

**Files:**
- Create: `Sources/GFNBridge/HID/HIDReader.swift`
- Create: `Tests/GFNBridgeTests/HIDReaderParsingTests.swift` (parse fixture bytes)
- Create: `Tests/Fixtures/orion-report-id1.bin` (captured or synthetic)

**Interfaces:**
- Produces: `HIDReader.open(vid:pid:) throws -> AsyncStream<HIDSample>`

- [ ] **Step 1: Write parser test from fixture matching probed layout** (X usage 48, Y usage 49, buttons page 9)

- [ ] **Step 2: Implement reader with `IOHIDManager`; filter `0x4098:0xBEA8`

- [ ] **Step 3: CLI `gfn-bridge read-orion` prints axes at 10 Hz**

- [ ] **Step 4: Commit**

```bash
git commit -am "feat: read Orion HID joystick samples"
```

---

### Task 6: Stick profile JSON + live map to virtual 0402

**Files:**
- Create: `Resources/profiles/orion-stick-to-warthog.json`
- Modify: `Mapper.swift`, `main.swift` — `gfn-bridge run --stick-only`

- [ ] **Step 1: Profile load test**

```swift
func testLoadOrionStickProfile() throws {
    let p = try Profile.load(named: "orion-stick-to-warthog")
    XCTAssertEqual(p.sink, "044F:0402")
}
```

- [ ] **Step 2: Wire reader → mapper → `VirtualHIDPublisher.updateStick`**

- [ ] **Step 3: Manual: GFN MSFS bind pitch/roll on Warthog stick**

- [ ] **Step 4: Commit**

```bash
git commit -am "feat: map Orion stick to virtual Warthog 0402"
```

---

### Task 7: Throttle reader + profile → virtual 0404

**Files:**
- Create: `Resources/profiles/winwing-throttle-to-warthog.json`
- Modify: `HIDReader` to accept throttle PID (probe/`--throttle-pid`)
- Modify: `main.swift` — full `run`

- [ ] **Step 1: Probe helper prints attached `0x4098` devices**

- [ ] **Step 2: Mapper + publisher for throttle axes**

- [ ] **Step 3: Manual GFN bind when hardware present; else document skip**

- [ ] **Step 4: Commit**

```bash
git commit -am "feat: map WinWing throttle to virtual Warthog 0404"
```

---

### Task 8: Status CLI + wiki bookkeeping

**Files:**
- Create: `Sources/GFNBridge/Status/BridgeStatus.swift`
- Modify: `wiki/overview.md`, `wiki/log.md`
- Modify: `README.md` — run instructions

- [ ] **Step 1: Status prints source OK / sink OK / last sample ages**

- [ ] **Step 2: README: spike-both, run, coexistence with X-Plane**

- [ ] **Step 3: Append `wiki/log.md` impl entry; mark success criteria**

- [ ] **Step 4: Commit**

```bash
git commit -am "docs: bridge status CLI and runbook"
```

---

## Self-review

1. **Spec coverage:** Spike (Tasks 2–4), stick map (5–6), throttle (7), status (8) cover success criteria; Xbox fallback only documented in Task 4 stop path.
2. **No placeholders:** Commands and types named; descriptor content filled in Task 2 from real bytes during impl.
3. **Type consistency:** `HIDSample`, `Profile`, `Mapper`, `VirtualHIDPublisher` shared across tasks.

## Execution handoff

Plan complete at `docs/superpowers/plans/2026-09-08-gfn-warthog-spoof-remapper.md`.

**1. Subagent-Driven (recommended)** — fresh subagent per task  
**2. Inline Execution** — executing-plans in this session  

Which approach?
