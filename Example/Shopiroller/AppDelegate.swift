//
//  AppDelegate.swift
//  Shopiroller
//
//  Created by ealtaca on 09/29/2021.
//  Copyright (c) 2021 ealtaca. All rights reserved.
//
import UIKit
import Shopiroller
import IQKeyboardManagerSwift
import Braintree

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ShopirollerDelegate {
    
    func userLoginNeeded(navigationController: UINavigationController?) {
        
    }
    
    var window: UIWindow?
    
    
    private let connectingUrl : ConnectableUrls = .stage
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .red
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                       
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        var theme = ShopirollerTheme()
        theme.navigationTitleTintColor = .white
        theme.navigationBarTintColor = .red
        theme.navigationIconsTintColor = .white
        
        
        let ecommerce = ShopirollerCredentials(aliasKey: informations(type: connectingUrl).aliasKey, apiKey: informations(type: connectingUrl).shopirollerApiKey, baseUrl: informations(type: connectingUrl).shopirollerBaseUrl)
        let appUser = ShopirollerAppUserCredentials(appKey: "+ClZjmILFflQA0nSBI0XLjEaT6Y=", apiKey: informations(type: connectingUrl).appUserApiKey, baseUrl: informations(type: connectingUrl).appUserBaseUrl)
        
        
        ShopirollerApp.shared.initiliaze(eCommerceCredentials: ecommerce, appUserCredentials: appUser, baseUrl: "", theme: theme)
        
        ShopirollerApp.shared.setUserId("61cc73512c630dd8754409d3")
        ShopirollerApp.shared.setUserEmail("gorkem@mobiroller.com")
        ShopirollerApp.shared.setFallbackLanguage("tr")
        ShopirollerApp.shared.setHeaderAppLanguage("tr")
        ShopirollerApp.shared.setDevelopmentMode(false)
        ShopirollerApp.shared.delegate = self
        
        let navigationController = UINavigationController(rootViewController: SRMainPageViewController(viewModel: SRMainPageViewModel()))
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        BTAppContextSwitcher.setReturnURLScheme("com.shopiroller.demo.payments")
                
        return true
    }
    
    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme?.localizedCaseInsensitiveCompare("com.shopiroller.demo.payments") == .orderedSame {
            return BTAppContextSwitcher.handleOpenURL(url)
        }
        return false
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        SRAppConstants.ShoppingCart.badgeCount = "0"
    }
    
    private func informations(type: ConnectableUrls) -> (shopirollerBaseUrl: String , appUserBaseUrl: String , shopirollerApiKey: String, appUserApiKey: String, aliasKey: String) {
        switch type {
        case .prod:
            return("api.shopiroller.com","mobiroller.api.applyze.com","xXspnfUxPzOGKNu90bFAjlOTnMLpN8veiixvEFXUw9I=","tKcdWgA5O7H2L0UAK4IpDMqDedkMY6VC2AafIs3mvaI=","r4N/jWShy0aNEhn2PQYDHDOZGC4=")
        case .stage:
            return("stg.api.shopiroller.com","api.stg.applyze.com","xXspnfUxPzOGKNu90bFAjlOTnMLpN8veiixvEFXUw9I=","tKcdWgA5O7H2L0UAK4IpDMqDedkMY6VC2AafIs3mvaI=","r4N/jWShy0aNEhn2PQYDHDOZGC4=")
        case .dev:
            return("dev.ecommerce.applyze.com","dev.applyze.com","ARz1Er9DHR0juxtDLHcywIGWVe86m7UzkLhpUeRMVtY=","/QcOg8MuI4TZNT/eAIpLbicVqpGxkxz1YeqAilOOj4s=","ETSiz+R2jbsYnrBJO9Kz+Ils3UY=")
        }
    }

    enum ConnectableUrls {
        case prod
        case stage
        case dev
        
    }
}

