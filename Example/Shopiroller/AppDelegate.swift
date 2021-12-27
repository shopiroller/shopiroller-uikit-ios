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
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        ShopirollerApp.shared.initiliaze(appKey: "", apiKey: "", baseUrl: "", color: .black)
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
