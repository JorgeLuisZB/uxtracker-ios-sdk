//
//  events.swift
//  uxtracker-sdk-ios
//
//  Created by Jorge Zaragoza on 30/08/25.
//

import Foundation

enum EventType: String, Codable {
    case event
    case identify
}

struct Event: Codable {
    let type: EventType
    let event: String
    let defaultProperties: [String: AnyCodable]
    let userProperties: [String: AnyCodable]
    
    private enum CodingKeys: String, CodingKey {
        case type
        case event
        case defaultProperties = "defaultproperties"
        case userProperties = "userproperties"
    }
    
    init(type: EventType, event: String, defaultProperties: [String: Any] = [:], userProperties: [String: Any] = [:]) {
        self.type = type
        self.event = event
        self.defaultProperties = defaultProperties.mapValues { AnyCodable($0) }
        self.userProperties = userProperties.mapValues { AnyCodable($0) }
    }
}
