//
//  sdk_config.swift
//  uxtracker-sdk-ios
//
//  Created by Jorge Zaragoza on 31/08/25.
//

import Foundation

// MARK: - SDK Configuration
public struct UXTrackerSetup {
    let flushInterval: TimeInterval
    let batchSize: Int
    
    public init(flushInterval: TimeInterval = 40.0, batchSize: Int = 20) {
        self.flushInterval = flushInterval
        self.batchSize = batchSize
    }
}
