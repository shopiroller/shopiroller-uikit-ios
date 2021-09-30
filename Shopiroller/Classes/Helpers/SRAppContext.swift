//
//  SRAppContext.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation

class SRAppContext: NSObject {
    
    static var userDefaults: UserDefaults {
        let combined = UserDefaults.standard
        combined.addSuite(named: "com.shopiroller.ecommerce")
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
    
//    static func resetUserDefaults() {
//        AppContext.otpToken = nil
//        AppContext.accessToken = nil
//        AppContext.userNumber = nil
//        AppContext.isUserLogin = false
//        AppContext.customerNumber = nil
//        AppContext.customerFullName = nil
//        AppContext.customerFirstName = nil
//        AppContext.customerLastName = nil
//        AppContext.customerProfileImageUrl = nil
//        AppContext.email = nil
//    }
    

//extension AppContext {
//
//    static var otpToken: String? {
//        get {
//            return userDefaults.object(forKey: AppConstants.UserDefaults.Key.otpToken) as? String
//        }
//        set {
//            userDefaults.set(newValue, forKey: AppConstants.UserDefaults.Key.otpToken)
//        }
//    }
//
//    static var pushToken: String? {
//
//        get {
//            return userDefaults.object(forKey: AppConstants.UserDefaults.Key.pushToken) as? String
//        }
//
//        set {
//            userDefaults.setValue(newValue, forKey: AppConstants.UserDefaults.Key.pushToken)
//        }
//    }
//
//
//    static var accessToken: String? {
//        get {
//            return userDefaults.object(forKey: AppConstants.UserDefaults.Key.accessToken) as? String
//        }
//        set {
//            userDefaults.set(newValue, forKey: AppConstants.UserDefaults.Key.accessToken)
//        }
//    }
//
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

//    static var userNumber: String? {
//        get {
//            return userDefaults.object(forKey: AppConstants.UserDefaults.Key.userNumber) as? String
//        }
//
//        set {
//            userDefaults.setValue(newValue, forKey: AppConstants.UserDefaults.Key.userNumber)
//        }
//    }
//
//    static var isUserLogin: Bool {
//        get {
//            return userDefaults.object(forKey: AppConstants.UserDefaults.Key.isUserLogin) as? Bool ?? false
//        }
//
//        set {
//            userDefaults.setValue(newValue, forKey: AppConstants.UserDefaults.Key.isUserLogin)
//        }
//    }
//
//    static var customerNumber: String? {
//        get {
//            return userDefaults.object(forKey: AppConstants.UserDefaults.Key.customerNo) as? String
//        }
//
//        set {
//            userDefaults.setValue(newValue, forKey: AppConstants.UserDefaults.Key.customerNo)
//        }
//    }
//
//
//    static var customerProfileImageUrl: String? {
//        get {
//            return userDefaults.object(forKey: AppConstants.UserDefaults.Key.customerProfileImageUrl) as? String
//        }
//
//        set {
//            userDefaults.setValue(newValue, forKey: AppConstants.UserDefaults.Key.customerProfileImageUrl)
//        }
//    }
//
//    static var customerFullName: String? {
//        get {
//            return userDefaults.object(forKey: AppConstants.UserDefaults.Key.customerFullName) as? String
//        }
//
//        set {
//            userDefaults.setValue(newValue, forKey: AppConstants.UserDefaults.Key.customerFullName)
//        }
//    }
//
//    static var email: String? {
//        get {
//            return userDefaults.object(forKey: AppConstants.UserDefaults.Key.email) as? String
//        }
//
//        set {
//            userDefaults.setValue(newValue, forKey: AppConstants.UserDefaults.Key.email)
//        }
//    }
//
//    static var customerFirstName: String? {
//        get {
//            return userDefaults.object(forKey: AppConstants.UserDefaults.Key.customerFirstName) as? String
//        }
//
//        set {
//            userDefaults.setValue(newValue, forKey: AppConstants.UserDefaults.Key.customerFirstName)
//        }
//    }
//
//    static var customerLastName: String? {
//        get {
//            return userDefaults.object(forKey: AppConstants.UserDefaults.Key.customerLastName) as? String
//        }
//
//        set {
//            userDefaults.setValue(newValue, forKey: AppConstants.UserDefaults.Key.customerLastName)
//        }
//    }
}

