//
//  ShopirollerApp.swift
//  Shopiroller
//
//  Created by Emre Can Altaca on 21.11.2021.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
import Sentry

public class ShopirollerApp {
    
    public static var shared = ShopirollerApp()
    
    public var theme: ShopirollerTheme = ShopirollerTheme()
    
    public var delegate: ShopirollerDelegate?
    
    private let user = User()
    
    public func initiliaze(eCommerceCredentials: ShopirollerCredentials, appUserCredentials: ShopirollerAppUserCredentials, baseUrl: String, theme: ShopirollerTheme) {
        
        self.theme = theme
        SRAppContext.apiKey = eCommerceCredentials.apiKey
        SRAppContext.aliasKey = eCommerceCredentials.aliasKey
        SRAppContext.baseUrl = eCommerceCredentials.baseUrl
        
        SRAppContext.appUserApiKey = appUserCredentials.apiKey
        SRAppContext.appUserAppKey = appUserCredentials.appKey
        SRAppContext.appUserBaseUrl = appUserCredentials.baseUrl
        
        UIFont.jbs_registerFont(
            withFilenameString: "Poppins-Bold.ttf",
            bundle: .shopiroller
        )
        
        UIFont.jbs_registerFont(
            withFilenameString: "Poppins-SemiBold.ttf",
            bundle: .shopiroller
        )
        
        UIFont.jbs_registerFont(
            withFilenameString: "Poppins-Regular.ttf",
            bundle: .shopiroller
        )
        
        UIFont.jbs_registerFont(
            withFilenameString: "Poppins-Medium.ttf",
            bundle: .shopiroller
        )
        
        
        UIFont.listAllFontsOnSystem()
        
        SRAppContext.fontFamily = .poppins
        
        initializeIQKeyboardManager()
        
        initializeSentryCrashReports()
    }
    
    private func initializeSentryCrashReports() {
        
        SentrySDK.start { options in
            options.dsn = "https://ca29bd2504fa4f60b812d9a343bc0a47@o1202858.ingest.sentry.io/6329022"
            options.enableNetworkTracking = true
            options.enableNetworkBreadcrumbs = true
            options.enableAutoSessionTracking = true
            options.tracesSampleRate = 1.0
        }
    
        setUserInfoToSentry()
        
    }
    
    private func setUserInfoToSentry() {
        
        if SRAppContext.userId != "" {
            user.userId = SRAppContext.userId
        }
        
        if SRAppContext.userEmail != "" {
            user.email = SRAppContext.userEmail
        }
        
        SentrySDK.setUser(user)
    }
    
    private func initializeIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "e_commerce_general_next_step_text".localized
    }
    
    public func setUserId(_ userId: String) {
        SRAppContext.userId = userId
        setUserInfoToSentry()
    }
    
    public func setUserEmail(_ email: String) {
        SRAppContext.userEmail = email
        setUserInfoToSentry()
    }
    
    public func setDevelopmentMode (_ developmentMode: Bool) {
        SRAppContext.developmentMode = developmentMode
    }
    
    public func setFallbackLanguage(_ fallbackLanguage: String) {
        SRAppContext.fallbackLanguage = fallbackLanguage
    }
    
    public func setAppTitle(appTitle: String) {
        SRAppContext.appTitle = appTitle
    }
    
    func isUserLoggedIn() -> Bool {
        return SRAppContext.userId != "" && SRAppContext.userEmail != ""
    }
    
    public func setHeaderAppLanguage(_ appLanguage: String) {
        SRAppContext.appLanguage = appLanguage.lowercased()
    }
}

public struct ShopirollerTheme {
    
    public var navigationBarTintColor: UIColor? = .black
    
    public var navigationIconsTintColor: UIColor? = .white
    
    public var navigationTitleTintColor: UIColor? = .white
    
    public init() {}
    
}


public struct ShopirollerCredentials {
    
    public var aliasKey: String
    
    public var apiKey: String
    
    public var baseUrl: String
    
    public init(aliasKey: String, apiKey: String, baseUrl: String) {
        self.aliasKey = aliasKey
        self.apiKey = apiKey
        self.baseUrl = baseUrl
    }
    
    
}

public struct ShopirollerAppUserCredentials {
    
    public var appKey: String
    
    public var apiKey: String
    
    public var baseUrl: String
    
    public init(appKey: String, apiKey: String, baseUrl: String) {
        self.appKey = appKey
        self.apiKey = apiKey
        self.baseUrl = baseUrl
    }
    
}


public protocol ShopirollerDelegate {
    
    func userLoginNeeded(navigationController: UINavigationController?)
    
}
