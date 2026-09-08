import XCTest
@testable import NVSBridge

final class DescriptorSmokeTests: XCTestCase {
    func testWarthogStickDescriptorNonEmpty() {
        XCTAssertFalse(WarthogDescriptors.flightStick.isEmpty)
        XCTAssertEqual(DeviceIDs.warthogStick.vid, 0x044F)
        XCTAssertEqual(DeviceIDs.warthogStick.pid, 0x0402)
    }

    func testDeviceCreationFailureExplainsVirtualHIDSigningRequirement() {
        let message = VirtualHIDPublisherError.deviceCreationFailed.errorDescription

        XCTAssertNotNil(message)
        XCTAssertTrue(message?.contains("com.apple.developer.hid.virtual.device") == true)
        XCTAssertTrue(message?.contains("scripts/sign-nvsbridge.sh") == true)
    }
}
