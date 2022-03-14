//
//  ShopirollerApp.swift
//  Shopiroller
//
//  Created by Emre Can Altaca on 21.11.2021.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

public class ShopirollerApp {
    
    public static var shared = ShopirollerApp()
    
    public var theme: ShopirollerTheme = ShopirollerTheme()
    
    public var delegate: ShopirollerDelegate?
    
    public func initiliaze(eCommerceCredentials: ShopirollerCredentials, appUserCredentials: ShopirollerAppUserCredentials, baseUrl: String, theme: ShopirollerTheme) {
                
        SRAppContext.appLanguage = Locale.current.languageCode ?? "tr"
        
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
    }
    
    private func initializeIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "keyboard-next-action-text".localized
    }
    
    public func setUserId(_ userId: String) {
        SRAppContext.userId = userId
    }
    
    public func setUserEmail(_ email: String) {
        SRAppContext.userEmail = email
    }
    
    public func setSdkSettings (_ isSdk: Bool) {
        SRAppContext.isSdk = isSdk
    }
    
    public func setFallbackLanguage(_ fallbackLanguage: String) {
        SRAppContext.fallbackLanguage = fallbackLanguage
    }

    func isUserLoggedIn() -> Bool {
        return SRAppContext.userId != "" && SRAppContext.userEmail != ""
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
    
    func userLoginNeeded()
        
}
