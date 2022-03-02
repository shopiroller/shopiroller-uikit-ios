//
//  ShopirollerApp.swift
//  Shopiroller
//
//  Created by Emre Can Altaca on 21.11.2021.
//

import Foundation
import UIKit

public class ShopirollerApp {
    
    public static var shared = ShopirollerApp()
    
    public var theme: ShopirollerTheme = ShopirollerTheme()
    
    public var delegate: ShopirollerDelegate?
    
    public func initiliaze(eCommerceCredentials: ShopirollerCredentials, appUserCredentials: ShopirollerCredentials, baseUrl: String, theme: ShopirollerTheme) {
        
        print(Bundle(for: ShopirollerApp.self).bundleIdentifier)
        
        self.theme = theme
        SRAppContext.apiKey = eCommerceCredentials.apiKey
        SRAppContext.appKey = eCommerceCredentials.appKey
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
        
    }
    
    public func setUserId(_ userId: String) {
        SRAppContext.userId = userId
    }
    
    public func setUserEmail(_ email: String) {
        SRAppContext.userEmail = email
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
