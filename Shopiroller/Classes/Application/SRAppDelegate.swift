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
        
        UIFont.jbs_registerFont(
            withFilenameString: "Poppings-Bold.ttf",
            bundle: .shopiroller
        )

        UIFont.jbs_registerFont(
            withFilenameString: "Poppings-Medium.ttf",
            bundle: .shopiroller
        )

        UIFont.jbs_registerFont(
            withFilenameString: "Poppings-Regular.ttf",
            bundle: .shopiroller
        )
        
        UIFont.jbs_registerFont(
            withFilenameString: "Poppings-SemiBold.ttf",
            bundle: .shopiroller
        )


        UIFont.listAllFontsOnSystem()
        SRAppContext.fontFamily = .poppins
        
        let navigationController = UINavigationController(rootViewController: SRMainPageViewController(viewModel: SRMainPageViewModel()))

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        SRAppContext.shoppingCartCount = "0"
    }
    
}
