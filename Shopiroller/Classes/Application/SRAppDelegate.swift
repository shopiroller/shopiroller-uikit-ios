//
//  SRAppDelegate.swift
//  shopiroller
//
//  Created by Görkem Gür on 16.09.2021.
//

import Foundation
import  UIKit


@main
class SRAppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        let navigationController = UINavigationController(rootViewController: SRMainPageViewController(coder: NSCoder())!)
        navigationController.setNavigationBarHidden(true, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
}
