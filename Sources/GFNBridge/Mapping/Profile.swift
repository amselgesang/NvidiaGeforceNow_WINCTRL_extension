struct AxisMap {
    let sourceAxis: Int
    let targetAxis: Int
}

struct Profile {
    let stickXAxis: Int
    let stickYAxis: Int

    static func stickIdentity() -> Profile {
        Profile(stickXAxis: 0, stickYAxis: 1)
    }
}

struct HIDSample {
    let axes: [Int: Double]
    let buttons: [Int]
    let hat: Int?
}

struct WarthogStickReport {
    let x: Double
    let y: Double
}
