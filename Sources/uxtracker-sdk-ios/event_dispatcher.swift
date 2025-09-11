//
//  event_dispatcher.swift
//  uxtracker-sdk-ios
//
//  Created by Jorge Zaragoza on 30/08/25.
//

import Foundation

final class EventDispatcher {
    private let uxTrackerSetup: UXTrackerSetup
    
    private let session: URLSession

    private var flushTimer: DispatchSourceTimer?
    
    init(uxTrackerSetup: UXTrackerSetup = UXTrackerSetup(), session: URLSession = .shared) {
        self.uxTrackerSetup = uxTrackerSetup
        self.session = session
    }
    
    public func startAutoFlush(eventQueue: EventQueue) {
        stopAutoFlush()
        
        let queue = DispatchQueue(label: "eventdispatcher.flush.timer")
        flushTimer = DispatchSource.makeTimerSource(queue: queue)
        flushTimer?.schedule(deadline: .now() + self.uxTrackerSetup.flushInterval, repeating: self.uxTrackerSetup.flushInterval)
        flushTimer?.setEventHandler { [weak self] in
            self?.flush(eventQueue: eventQueue)
        }
        flushTimer?.resume()
    }
    
    public func stopAutoFlush() {
        flushTimer?.cancel()
        flushTimer = nil
    }
    
    public func flush(eventQueue: EventQueue) {
        let eventBatch = eventQueue.dequeueBatch(max: self.uxTrackerSetup.batchSize)

        guard !eventBatch.isEmpty else { return }
        
        let path = "/events/track/batch"
        guard let url = URL(string: path, relativeTo: Constants.URL_BASE) else {
            print("Error: Invalid URL for path \(path)")
            return
        }
        
        do {
            let payload = try JSONEncoder().encode(eventBatch)
            self.send(payload: payload, to: url)
        } catch {
            print("Encoding error for batch: \(error)")
        }
    }
    
    private func send(payload: Data, to url: URL) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = payload
        print("Sending data with \(payload)")
        session.dataTask(with: request) { _, response, error in
            if let error = error {
                print("Failed to send data: \(error.localizedDescription)")
            } else {
                print("Successfully sent data to \(url), response: \(String(describing: response))")
            }
        }.resume()
    }
}
