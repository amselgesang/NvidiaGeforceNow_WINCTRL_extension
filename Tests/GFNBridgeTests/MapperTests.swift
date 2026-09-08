import XCTest
@testable import NVSBridge

final class MapperTests: XCTestCase {
    func testOrionXYMapsToWarthogStickXY() {
        let profile = Profile.stickIdentity()
        let sample = HIDSample(axes: [0: 0.5, 1: -0.25], buttons: [], hat: nil)
        let report = Mapper.mapStick(sample, profile: profile)
        XCTAssertEqual(report.x, 0.5, accuracy: 0.001)
        XCTAssertEqual(report.y, -0.25, accuracy: 0.001)
    }
}
