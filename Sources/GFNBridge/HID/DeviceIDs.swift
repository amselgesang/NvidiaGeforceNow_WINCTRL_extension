struct DeviceID {
    let vid: UInt16
    let pid: UInt16
}

enum DeviceIDs {
    static let warthogStick = DeviceID(vid: 0x044F, pid: 0x0402)
    static let warthogThrottle = DeviceID(vid: 0x044F, pid: 0x0404)
    static let orionStick = DeviceID(vid: 0x4098, pid: 0xBEA8)
}
