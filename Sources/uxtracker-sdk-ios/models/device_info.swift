//
//  DeviceInfo.swift
//  uxtracker-sdk-ios
//
//  Created by Jorge Zaragoza on 30/08/25.
//


import UIKit

struct DeviceInfo {
    let model: String
    let systemName: String
    let systemVersion: String
    let identifierForVendor: String?

    @MainActor static var current: DeviceInfo {
        let device = UIDevice.current
        return DeviceInfo(
            model: device.model,
            systemName: device.systemName,
            systemVersion: device.systemVersion,
            identifierForVendor: device.identifierForVendor?.uuidString
        )
    }

    func toDictionary() -> [String: Any] {
        return [
            "model": model,
            "os": systemName,
            "osVersion": systemVersion,
            "idfv": identifierForVendor ?? ""
        ]
    }
}
