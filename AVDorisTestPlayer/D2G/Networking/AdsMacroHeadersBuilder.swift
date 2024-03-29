//
//  AdsMacroHeadersBuilder.swift
//  AVDorisTestPlayer
//
//  Created by Haibo Li on 1/26/24.
//  Copyright © 2024 Endeavor Streaming. All rights reserved.
//

import Foundation
import AdSupport
import DeviceKit

struct AdsMacroHeadersBuilder {
    static let `default` = AdsMacroHeadersBuilder()

    //Terms and Conditions Framework String. This is an encoded string used in GDPR compliant territories. (OneTrusSDK)
    let tcf: String
    //US Privacy. This is the String containing information regarding the consent for CCPA in US territory. (OneTrustSDK)
    let usp: String

    init(tcf: String = "", usp: String = "") {
        self.tcf = tcf
        self.usp = usp
    }

    var appName: String { return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "" }
    var appVersion: String { return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "" }
    var screenHeight: String { return "\(UIScreen.main.bounds.size.height)" }
    var screenWidth: String { return "\(UIScreen.main.bounds.size.width)" }
    // AD_CONFIGURATION_OPERATING_SYSTEMS { iOS: 13 ...... }
    var deviceOS: String { return "13" }
    var deviceOSVersion: String { return UIDevice.current.systemVersion }
    // AD_CONFIGURATION_DEVICE_TYPES = { tv Phone: 4, Tablet: 5 }
    var deviceType: String { return UIDevice.current.userInterfaceIdiom == .phone ? "4" : "5" }
    var bundleId: String { return Bundle.main.bundleIdentifier ?? "" }
    var deviceManufacturer: String { return "Apple" }
    var deviceModel: String { return "\(Device.current)" }
    
    ///for iOS 14+ use AppTrackingTransparency to obtain personalized ads tracking status
    ///https://developer.apple.com/documentation/apptrackingtransparency
    ///Make sure  `NSUserTrackingUsageDescription` is present in Info.plist
    /**
     import AppTrackingTransparency

     ATTrackingManager.requestTrackingAuthorization { status in
         let isLat = status == .authorized ? true : false
     }
    */
    var isLat: Bool { return ASIdentifierManager.shared().isAdvertisingTrackingEnabled }
    //for iOS 14+ use AppTrackingTransparency
    var idfa: String { return isLat ? ASIdentifierManager.shared().advertisingIdentifier.uuidString : "" }
    var deviceLanguage: String {
        let languageCode = Locale.current.languageCode ?? "en"
        let regionCode = Locale.current.regionCode ?? "US"
        return "\(languageCode)_\(regionCode)"
    }
    
    var headers: [String: String] {
        return [
            "CM-APP-NAME": appName,
            "CM-APP-VERSION": appVersion,
            "CM-DVC-H": screenHeight,
            "CM-DVC-W": screenWidth,
            "CM-DVC-LANG": deviceLanguage,
            "CM-DVC-OS": deviceOS,
            "CM-DVC-OSV": deviceOSVersion,
            "CM-DVC-TYPE": deviceType,
            "CM-APP-BUNDLE": bundleId,
            "CM-DVC-MAKE": deviceManufacturer,
            "CM-DVC-MODEL": deviceModel,
            "CM-APP-STOREID": bundleId,
            "CM-CST-TCF": tcf,
            "CM-CST-USP": usp,
            "CM-CST-LAT": isLat ? "1" : "0",
            "CM-CST-IFA": idfa
        ]
    }
}
