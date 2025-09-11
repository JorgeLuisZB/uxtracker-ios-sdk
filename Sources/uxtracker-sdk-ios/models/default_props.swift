//
//  default_props.swift
//  uxtracker-sdk-ios
//
//  Created by Jorge Zaragoza on 30/08/25.
//

import Foundation

@available(iOS 16, *)
struct DefaultProperties {
    @MainActor static func collect(sessionId: String, distinctId: String) -> [String: Any] {
        let device = DeviceInfo.current
        let bundle = Bundle.main
        let locale = Locale.current
        
        let operatingSystem = device.systemName
        let osVersion = device.systemVersion
        let model = device.model
        
        let appName = bundle.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Unknown"
        let appVersion = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
        let appBuild = bundle.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unknown"
        
        let countryCode = Locale.current.regionCode ?? "unknown"
        let country = Locale.current.localizedString(forRegionCode: countryCode) ?? "unknown"
        
        return [
            "distinctid": distinctId,
            "sessionid": sessionId,
            "apiendpoint": Constants.URL_BASE?.absoluteString ?? "unknown",
            "operatingsystem": operatingSystem,
            "osversion": osVersion,
            "devicemodel": model,
            "appname": appName,
            "appversion": appVersion,
            "appbuildnumber": appBuild,
            "platform": "iOS",
            "country": country,
            "apitimestamp": ISO8601DateFormatter().string(from: Date())
        ]
    }
}
