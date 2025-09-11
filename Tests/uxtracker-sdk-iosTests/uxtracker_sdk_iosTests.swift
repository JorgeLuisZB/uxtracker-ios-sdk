import Testing
@testable import uxtracker_sdk_ios

@available(iOS 16.0, *)
@MainActor
@Test func example() async throws {
        
    UXTracker.shared.reset()
    // 1. Initialize the SDK
    let uxTrackerSetup = UXTrackerSetup(flushInterval: 5, batchSize: 10)
    UXTracker.shared.initialize(apiKey: "local-test-key", uxTrackerSetup: uxTrackerSetup)

    // 2. Track an event
    for i in 0..<2 {
        UXTracker.shared.track(eventName: "test_event_local_api_\(i)", userProperties: ["version": "1.0"])
//      try await Task.sleep(for: .milliseconds(750))
    }
        
    // 3. Flush the queue automatically after 25 seconds
    // UXTracker.shared.flush()
    try await Task.sleep(for: .seconds(10))
    // 4. User Identified
    UXTracker.shared.identify(userId: "ce93d891-119a-49c7-a83d-197d68c81105")
    
    try await Task.sleep(for: .seconds(1))
    
    for i in 2..<24 {
        UXTracker.shared.track(eventName: "test_event_local_api_\(i)", userProperties: ["version": "1.0"])
//      try await Task.sleep(for: .milliseconds(750))
    }
    
    // 4. Wait for a short duration to allow the request to complete
    try await Task.sleep(for: .seconds(300))
}
