enum WarthogDescriptors {
    static let flightStick: [UInt8] = [
        0x05, 0x01,       // Usage Page (Generic Desktop)
        0x09, 0x04,       // Usage (Joystick)
        0xA1, 0x01,       // Collection (Application)
        0x09, 0x01,       //   Usage (Pointer)
        0xA1, 0x00,       //   Collection (Physical)
        0x09, 0x30,       //     Usage (X)
        0x09, 0x31,       //     Usage (Y)
        0x16, 0x00, 0x80, //     Logical Minimum (-32768)
        0x26, 0xFF, 0x7F, //     Logical Maximum (32767)
        0x75, 0x10,       //     Report Size (16)
        0x95, 0x02,       //     Report Count (2)
        0x81, 0x02,       //     Input (Data, Variable, Absolute)
        0xC0,             //   End Collection
        0x05, 0x09,       //   Usage Page (Button)
        0x19, 0x01,       //   Usage Minimum (Button 1)
        0x29, 0x20,       //   Usage Maximum (Button 32)
        0x15, 0x00,       //   Logical Minimum (0)
        0x25, 0x01,       //   Logical Maximum (1)
        0x75, 0x01,       //   Report Size (1)
        0x95, 0x20,       //   Report Count (32)
        0x81, 0x02,       //   Input (Data, Variable, Absolute)
        0xC0,             // End Collection
    ]
}
