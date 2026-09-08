import Foundation

switch CommandLine.arguments.dropFirst().first {
case "spike-stick":
    do {
        let publisher = VirtualHIDPublisher()
        try publisher.publishWarthogStick(centered: true)
        print("published 044F:0402")
        _ = readLine()
    } catch {
        FileHandle.standardError.write(
            Data("failed to publish Warthog stick: \(error.localizedDescription)\n".utf8)
        )
        exit(EXIT_FAILURE)
    }
case "spike-throttle":
    do {
        let publisher = VirtualHIDPublisher()
        try publisher.publishWarthogThrottle(centered: true)
        print("published 044F:0404")
        _ = readLine()
    } catch {
        FileHandle.standardError.write(
            Data("failed to publish Warthog throttle: \(error.localizedDescription)\n".utf8)
        )
        exit(EXIT_FAILURE)
    }
case "spike-both":
    do {
        let publisher = VirtualHIDPublisher()
        try publisher.publishWarthogStick(centered: true)
        try publisher.publishWarthogThrottle(centered: true)
        print("published 044F:0402")
        print("published 044F:0404")
        _ = readLine()
    } catch {
        FileHandle.standardError.write(
            Data("failed to publish Warthog devices: \(error.localizedDescription)\n".utf8)
        )
        exit(EXIT_FAILURE)
    }
default:
    print("Usage: NVSBridge spike-stick|spike-throttle|spike-both")
}
