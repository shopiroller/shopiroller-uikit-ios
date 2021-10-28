//
//  SRAppDelegate.swift
//  shopiroller
//
//  Created by Görkem Gür on 16.09.2021.
//

import Foundation
import  UIKit


@UIApplicationMain
open class SRAppDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        UIFont.listAllFontsOnSystem()
        SRAppContext.fontFamily = .poppins
        
        let navigationController = UINavigationController(rootViewController: SRMainPageViewController(viewModel: SRMainPageViewModel()))
        navigationController.setNavigationBarHidden(true, animated: true)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
}
