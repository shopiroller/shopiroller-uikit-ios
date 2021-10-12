//
//  SRAppContext.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation

public class SRAppContext: NSObject {

    static var userDefaults: UserDefaults {
        let combined = UserDefaults.standard
        combined.addSuite(named: "org.cocoapods.Shopiroller")
        return combined
    }
    
    static var currentEndpoint: SREndpointType = SREndpointType.dev
    
    struct SettingsBundleKeys {
        static let BaseURL = "baseURL"
        static let CustomURL = "custom_url_preference"
        static let CustomPort = "custom_port_preference"
    }
        
    class func getSettings() {
            #if APPSTORE
                print("AppStore")
                return
            #endif
            #if SANDBOX
                self.currentEndpoint = .dev
            #elseif DEVELOPMENT
                self.currentEndpoint = .dev
            #elseif QA
                self.currentEndpoint = .dev
            #else
                self.currentEndpoint = .dev
            #endif
    }
    
}


extension SRAppContext {
    
    static var fontFamily: SRFontFamily {
        get {
            if let family = userDefaults.object(forKey: SRAppConstants.UserDefaults.Key.fontFamily) as? String {
                return SRFontFamily(rawValue: family) ?? .default
            }
            return .default
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: SRAppConstants.UserDefaults.Key.fontFamily)
        }
    }
    
    static var isLoading: Bool {
        get {
            return userDefaults.object(forKey:
                                        SRAppConstants.NetworkDefault.Loading.isLoading) as? Bool ?? false
        }
        
        set {
            userDefaults.setValue(newValue, forKey: SRAppConstants.NetworkDefault.Loading.isLoading)
        }
    }
    
}
