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
        
        
        let ecommerce = ShopirollerCredentials(appKey: "hH44D508wztkyBoQ3HiPqjMN/O4=", apiKey: "ARz1Er9DHR0juxtDLHcywIGWVe86m7UzkLhpUeRMVtY=", baseUrl: "dev.applyze.com/ecommerce")
        let appUser = ShopirollerCredentials(appKey: "NHIYz8fu8Nb+98KFd1AFwVHdHGo=", apiKey: "/QcOg8MuI4TZNT/eAIpLbicVqpGxkxz1YeqAilOOj4s=", baseUrl: "dev.applyze.com")
        
        ShopirollerApp.shared.initiliaze(eCommerceCredentials: ecommerce, appUserCredentials: appUser, baseUrl: "", theme: theme)
        
        ShopirollerApp.shared.setUserId("61fa81937946ca5e0531a2f3")
        ShopirollerApp.shared.setUserEmail("gorkerem2@hotmail.com")
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
