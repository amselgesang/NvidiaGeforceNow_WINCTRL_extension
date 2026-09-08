enum Mapper {
    static func mapStick(_ sample: HIDSample, profile: Profile) -> WarthogStickReport {
        let x = sample.axes[profile.stickXAxis] ?? 0.0
        let y = sample.axes[profile.stickYAxis] ?? 0.0
        return WarthogStickReport(x: x, y: y)
    }

    static func mapSample(_ sample: HIDSample, profile: Profile) -> WarthogStickReport {
        mapStick(sample, profile: profile)
    }
}
