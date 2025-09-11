//
//  event_queue.swift
//  uxtracker-sdk-ios
//
//  Created by Jorge Zaragoza on 30/08/25.
//

import Foundation

final class EventQueue {
    private var events: [Event] = []
    private let queue = DispatchQueue(label: "com.uxtracker.eventqueue")

    func enqueue(_ event: Event) {
        queue.sync {
            events.append(event)
            print("Event queued: \(event.event)")
        }
    }

    func dequeueBatch(max: Int) -> [Event] {
        return queue.sync {
            let batch = Array(events.prefix(max))
            events.removeFirst(min(max, events.count))
            return batch
        }
    }

    func isEmpty() -> Bool {
        return queue.sync { events.isEmpty }
    }
}
