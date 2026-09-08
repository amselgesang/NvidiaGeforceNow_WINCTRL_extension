import Foundation
import IOKit.hid
import Darwin.Mach

enum VirtualHIDPublisherError: Error {
    case deviceCreationFailed
    case initialReportFailed(IOReturn)
}

final class VirtualHIDPublisher {
    private var devices: [IOHIDUserDevice] = []

    func publishWarthogStick(centered: Bool) throws {
        let identifier = DeviceIDs.warthogStick
        let properties: [String: Any] = [
            kIOHIDVendorIDKey: NSNumber(value: identifier.vid),
            kIOHIDProductIDKey: NSNumber(value: identifier.pid),
            kIOHIDReportDescriptorKey: Data(WarthogDescriptors.flightStick),
            kIOHIDManufacturerKey: "Thrustmaster",
            kIOHIDProductKey: "HOTAS Warthog Flight Stick",
        ]

        guard let device = IOHIDUserDeviceCreateWithProperties(
            kCFAllocatorDefault,
            properties as CFDictionary,
            0
        ) else {
            throw VirtualHIDPublisherError.deviceCreationFailed
        }

        devices.append(device)

        if centered {
            let idleReport = [UInt8](repeating: 0, count: 8)
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
