import Foundation
import UIKit

@available(iOS 16, *)
@MainActor
public class UXTracker {
    public static let shared = UXTracker()
    
    private var eventQueue: EventQueue = EventQueue()
    private var eventDispatcher: EventDispatcher = EventDispatcher()
    private var identiesController: IdentitiesController = IdentitiesController()
    private(set) var distinctId: String?
    private let sessionId: String
    
    private init() {
        self.sessionId = UXTracker.generateSessionId()
    }
    
    public func initialize(apiKey: String, uxTrackerSetup: UXTrackerSetup? = UXTrackerSetup()) {
        self.eventDispatcher = EventDispatcher(uxTrackerSetup: uxTrackerSetup!)
        
        let defaults = UserDefaults.standard
        if let savedId = defaults.string(forKey: "distinctid") {
            self.distinctId = savedId
        } else {
            let newId = UUID().uuidString
            self.distinctId = newId
            defaults.set(newId, forKey: "distinctid")
        }
    }
    
    public func track(eventName: String, userProperties: [String: Any] = [:]) {
        let defaultProperties = DefaultProperties.collect(sessionId: self.sessionId, distinctId: self.distinctId!)
            
        let event = Event(
            type: .event,
            event: eventName,
            defaultProperties: defaultProperties,
            userProperties: userProperties
        )
        
        eventDispatcher.startAutoFlush(eventQueue: eventQueue)
            
        eventQueue.enqueue(event)
    }
    
    public func identify(userId: String) {
        let anonymousId = self.distinctId ?? ""
        self.distinctId = userId
        
        UserDefaults.standard.set(userId, forKey: "distinctid")
        
        let defaultProperties = DefaultProperties.collect(sessionId: self.sessionId, distinctId: self.distinctId!)
        var userProperties : [String: Any] = [:]
        
        userProperties["userid"] = userId
        userProperties["anonymousdistinctid"] = !anonymousId.isEmpty && anonymousId != userId ? anonymousId : nil
        
        let event = Event(
            type: .identify,
            event: "Identify",
            defaultProperties: defaultProperties,
            userProperties: userProperties
        )
        
        eventDispatcher.flush(eventQueue: eventQueue) { [weak self] in
            Task { @MainActor in
                guard let self = self else { return }
                
                self.identiesController.identifyUser(event: event)
                self.eventQueue.enqueue(event)
            }
        }
    }
    
    public func flush(completion: (@Sendable() -> Void)? = nil) {
        eventDispatcher.flush(eventQueue: eventQueue, completion: completion)
    }
    
    public func reset() {
        let newId = UUID().uuidString
        self.distinctId = newId
        UserDefaults.standard.set(newId, forKey: "distinctid")
    }
    
    private static func generateSessionId() -> String {
        let timestamp = Int(Date().timeIntervalSince1970 * 1000)
        let rand = Int.random(in: 0..<Int(UInt32.max))
        return "\(timestamp)-\(rand)"
    }
}
