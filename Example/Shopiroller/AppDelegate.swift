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
    
    private var shopirollerTheme: ShopirollerTheme = ShopirollerTheme()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //Set Theme Colors
        
        shopirollerTheme.navigationTitleTintColor = .white
        shopirollerTheme.navigationBarTintColor = UIColor(named: "navigationTint")
        shopirollerTheme.navigationIconsTintColor = .white
        
        //Set UINavigationBarAppearance
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = shopirollerTheme.navigationBarTintColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: shopirollerTheme.navigationTitleTintColor]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: shopirollerTheme.navigationBarTintColor]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        
        let ecommerce = ShopirollerCredentials(aliasKey: "iosAliasKey", apiKey: "apiKey", baseUrl: "baseUrl")
        let appUser = ShopirollerAppUserCredentials(appKey: "userAppKey", apiKey: "userApiKey", baseUrl: "userBaseUrl")
        
        ShopirollerApp.shared.initiliaze(eCommerceCredentials: ecommerce, appUserCredentials: appUser, baseUrl: "", theme: shopirollerTheme)
        
        ShopirollerApp.shared.setUserId("userId")
        ShopirollerApp.shared.setUserEmail("sample@sample.com")
        let languageCode = Locale.current.languageCode ?? "en"
        ShopirollerApp.shared.setFallbackLanguage(languageCode)
        ShopirollerApp.shared.setHeaderAppLanguage(languageCode)
        ShopirollerApp.shared.setDevelopmentMode(false)
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
    
    func userLoginNeeded(navigationController: UINavigationController?) {
        //Let's say you have a login page and in your flow the user needs to login to complete the flow, if user not logged in you can use this function to redirect the user to the login screen. An example usage is available in SRProductDetailViewController
        /*
         An Example code below how to open Login Page
         let loginPageVC = LoginPageViewController(viewModel: LoginPageViewModel())
         navigationController?.pushViewController(loginPageVC, animated: true)
         */
    }
    
}

