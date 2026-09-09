import XCTest
@testable import GFNBridge

final class DescriptorSmokeTests: XCTestCase {
    func testWarthogStickDescriptorNonEmpty() {
        XCTAssertFalse(WarthogDescriptors.flightStick.isEmpty)
        XCTAssertEqual(DeviceIDs.warthogStick.vid, 0x044F)
        XCTAssertEqual(DeviceIDs.warthogStick.pid, 0x0402)
    }

    func testWarthogThrottleIDs() {
        XCTAssertEqual(DeviceIDs.warthogThrottle.pid, 0x0404)
    }

    func testDeviceCreationFailureExplainsVirtualHIDSigningRequirement() {
        let message = VirtualHIDPublisherError.deviceCreationFailed.errorDescription

        XCTAssertNotNil(message)
        XCTAssertTrue(message?.contains("com.apple.developer.hid.virtual.device") == true)
        XCTAssertTrue(message?.contains("provisioning profile") == true)
        XCTAssertTrue(message?.contains("scripts/sign-gfnbridge.sh") == true)
    }
}
