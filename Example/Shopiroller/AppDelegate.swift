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
        
        
        let ecommerce = ShopirollerCredentials(aliasKey: "jR2dd6uwpbKTu1kVLIVM84pd7yw=", apiKey: "xXspnfUxPzOGKNu90bFAjlOTnMLpN8veiixvEFXUw9I=", baseUrl: "api.shopiroller.com")
        let appUser = ShopirollerAppUserCredentials(appKey: "LLOgsgUoR/Bm5TqLR6+oJaCaNrs=", apiKey: "tKcdWgA5O7H2L0UAK4lpDMqDedkMY6VC2Aafls3mval=", baseUrl: "mobiroller.api.applyze.com")
        
        ShopirollerApp.shared.initiliaze(eCommerceCredentials: ecommerce, appUserCredentials: appUser, baseUrl: "", theme: getShopirollerTheme(navigationTitleColor: .white, navigationBartintColor: .red)) //We should initialize SDK here with our ApiKey and AppKey
        
        ShopirollerApp.shared.setUserId("62221ee8944dc204e5a4262f") //You need to change this variable with your User Id
        ShopirollerApp.shared.setUserEmail("sample@sample.com") //You need to change this variable with your User Email
        let languageCode = Locale.current.languageCode ?? "en"
        ShopirollerApp.shared.setFallbackLanguage(languageCode)
        ShopirollerApp.shared.setHeaderAppLanguage(languageCode)
        ShopirollerApp.shared.setDevelopmentMode(false) //With this function you can access user's address or user's orders
        ShopirollerApp.shared.delegate = self
        
        createMainPage()
        
        BTAppContextSwitcher.setReturnURLScheme("com.shopiroller.demo.payments")
        
        return true
    }
    
    private func getShopirollerTheme(navigationTitleColor: UIColor,navigationBartintColor: UIColor) -> ShopirollerTheme {
        
        shopirollerTheme.navigationTitleTintColor = navigationTitleColor
        shopirollerTheme.navigationBarTintColor = navigationBartintColor
        shopirollerTheme.navigationIconsTintColor = navigationTitleColor
        setNavigationBarAppearance()
        return shopirollerTheme
    }
    
    private func setNavigationBarAppearance() {
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = shopirollerTheme.navigationBarTintColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: shopirollerTheme.navigationTitleTintColor]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: shopirollerTheme.navigationBarTintColor]
                       
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
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

