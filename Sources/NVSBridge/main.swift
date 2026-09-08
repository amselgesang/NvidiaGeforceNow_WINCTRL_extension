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
default:
    print("Usage: NVSBridge spike-stick")
}
