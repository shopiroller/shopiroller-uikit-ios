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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ShopirollerDelegate {
    
    func userLoginNeeded() {
        
    }
    
    
    var window: UIWindow?
    
    
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
        
        let ecommerce = ShopirollerCredentials(aliasKey: "r4N/jWShy0aNEhn2PQYDHDOZGC4=", apiKey: "xXspnfUxPzOGKNu90bFAjlOTnMLpN8veiixvEFXUw9I=", baseUrl: "stg.api.shopiroller.com")
        let appUser = ShopirollerAppUserCredentials(appKey: "+ClZjmILFflQA0nSBI0XLjEaT6Y=", apiKey: "tKcdWgA5O7H2L0UAK4IpDMqDedkMY6VC2AafIs3mvaI=", baseUrl: "mobiroller.api.applyze.com")
        
        ShopirollerApp.shared.initiliaze(eCommerceCredentials: ecommerce, appUserCredentials: appUser, baseUrl: "", theme: theme)
        
        ShopirollerApp.shared.setUserId("61cc73512c630dd8754409d3")
        ShopirollerApp.shared.setUserEmail("gorkem@mobiroller.com")
        ShopirollerApp.shared.delegate = self
        let navigationController = UINavigationController(rootViewController: SRMainPageViewController(viewModel: SRMainPageViewModel()))
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "keyboard-next-action-text".localized
        
        return true
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        SRAppConstants.ShoppingCart.badgeCount = "0"
    }

}
