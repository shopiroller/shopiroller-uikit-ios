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
        
        var theme = ShopirollerTheme()
        theme.navigationTitleTintColor = .green
        theme.navigationBarTintColor = .red
        theme.navigationIconsTintColor = .blue
        
        var ecommerce = ShopirollerCredentials(appKey: "9SSNWXWo7pzR1X4xnh0HYlSpMhc=", apiKey: "xXspnfUxPzOGKNu90bFAjlOTnMLpN8veiixvEFXUw9I=", baseUrl: "api.shopiroller.com")
        var appUser = ShopirollerCredentials(appKey: "9SSNWXWo7pzR1X4xnh0HYlSpMhc=", apiKey: "xXspnfUxPzOGKNu90bFAjlOTnMLpN8veiixvEFXUw9I=", baseUrl: "mobiroller.api.applyze.com")
        
        ShopirollerApp.shared.initiliaze(eCommerceCredentials: ecommerce, appUserCredentials: appUser, baseUrl: "", theme: theme)
        
        ShopirollerApp.shared.setUserId("61c4168a2c630dd87543d153")
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
