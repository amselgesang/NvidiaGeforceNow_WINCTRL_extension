import XCTest
@testable import NVSBridge

final class DescriptorSmokeTests: XCTestCase {
    func testWarthogStickDescriptorNonEmpty() {
        XCTAssertFalse(WarthogDescriptors.flightStick.isEmpty)
        XCTAssertEqual(DeviceIDs.warthogStick.vid, 0x044F)
        XCTAssertEqual(DeviceIDs.warthogStick.pid, 0x0402)
    }
}
