import Foundation
import IOKit.hid
import Darwin.Mach

enum VirtualHIDPublisherError: LocalizedError {
    case deviceCreationFailed
    case initialReportFailed(IOReturn)

    var errorDescription: String? {
        switch self {
        case .deviceCreationFailed:
            return """
            IOHIDUserDevice creation was rejected. NVSBridge requires the \
            com.apple.developer.hid.virtual.device entitlement plus an eligible Apple \
            Developer provisioning profile with the HID Virtual Device capability. \
            Ad-hoc or local signing alone is not sufficient; publication remains blocked \
            until that profile is available. After swift build, run \
            scripts/sign-nvsbridge.sh with a Developer ID identity, then launch \
            .build/debug/NVSBridge spike-stick.
            """
        case let .initialReportFailed(result):
            return "The initial centered HID report failed with IOReturn \(result)."
        }
    }
}

final class VirtualHIDPublisher {
    private var devices: [IOHIDUserDevice] = []

    func publishWarthogStick(centered: Bool) throws {
        try publish(
            identifier: DeviceIDs.warthogStick,
            descriptor: WarthogDescriptors.flightStick,
            product: "HOTAS Warthog Flight Stick",
            idleReportSize: centered ? 8 : nil
        )
    }

    func publishWarthogThrottle(centered: Bool) throws {
        try publish(
            identifier: DeviceIDs.warthogThrottle,
            descriptor: WarthogDescriptors.dualThrottle,
            product: "HOTAS Warthog Dual Throttle",
            idleReportSize: centered ? 4 : nil
        )
    }

    private func publish(
        identifier: DeviceID,
        descriptor: [UInt8],
        product: String,
        idleReportSize: Int?
    ) throws {
        let properties: [String: Any] = [
            kIOHIDVendorIDKey: NSNumber(value: identifier.vid),
            kIOHIDProductIDKey: NSNumber(value: identifier.pid),
            kIOHIDReportDescriptorKey: Data(descriptor),
            kIOHIDManufacturerKey: "Thrustmaster",
            kIOHIDProductKey: product,
        ]

        guard let device = IOHIDUserDeviceCreateWithProperties(
            kCFAllocatorDefault,
            properties as CFDictionary,
            0
        ) else {
            throw VirtualHIDPublisherError.deviceCreationFailed
        }

        devices.append(device)

        if let idleReportSize {
            let idleReport = [UInt8](repeating: 0, count: idleReportSize)
            let result = idleReport.withUnsafeBytes { bytes in
                IOHIDUserDeviceHandleReportWithTimeStamp(
                    device,
                    mach_absolute_time(),
                    bytes.baseAddress!.assumingMemoryBound(to: UInt8.self),
                    bytes.count
                )
            }
            guard result == kIOReturnSuccess else {
                devices.removeLast()
                throw VirtualHIDPublisherError.initialReportFailed(result)
            }
        }
    }
}
