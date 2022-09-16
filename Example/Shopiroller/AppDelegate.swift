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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .red //NavigationBar Background Color
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                       
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        var theme = ShopirollerTheme()
        theme.navigationTitleTintColor = .white
        theme.navigationBarTintColor = .red
        theme.navigationIconsTintColor = .white
        
        let ecommerce = ShopirollerCredentials(aliasKey: "jR2dd6uwpbKTu1kVLIVM84pd7yw=", apiKey: "xXspnfUxPzOGKNu90bFAjlOTnMLpN8veiixvEFXUw9I=", baseUrl: "api.shopiroller.com")
        let appUser = ShopirollerAppUserCredentials(appKey: "LLOgsgUoR/Bm5TqLR6+oJaCaNrs=", apiKey: "tKcdWgA5O7H2L0UAK4lpDMqDedkMY6VC2Aafls3mval=", baseUrl: "mobiroller.api.applyze.com")
        
        ShopirollerApp.shared.initiliaze(eCommerceCredentials: ecommerce, appUserCredentials: appUser, baseUrl: "", theme: theme) //We should initialize SDK here with our ApiKey and AppKey 
        
        ShopirollerApp.shared.setUserId("62221ee8944dc204e5a4262f") //You need to change this variable with your User Id
        ShopirollerApp.shared.setUserEmail("User E-mail") //You need to change this variable with your User Email
        let languageCode = Locale.current.languageCode ?? "tr"
        ShopirollerApp.shared.setFallbackLanguage(languageCode)
        ShopirollerApp.shared.setHeaderAppLanguage(languageCode)
        ShopirollerApp.shared.setDevelopmentMode(false) //With this function you can access user's address or user's orders
        ShopirollerApp.shared.delegate = self
        
        createMainPage()
        
        BTAppContextSwitcher.setReturnURLScheme("com.shopiroller.demo.payments")
        
        return true
    }
    
    private func createMainPage() {
        let navigationController = UINavigationController(rootViewController: SRMainPageViewController(viewModel: SRMainPageViewModel()))
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
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

    enum ConnectableUrls {
        case prod
        case stage
        case dev
    }
    
}

