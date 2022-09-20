# Shopiroller

[![CI Status](https://img.shields.io/travis/ealtaca/Shopiroller.svg?style=flat)](https://travis-ci.org/ealtaca/Shopiroller)
[![Version](https://img.shields.io/cocoapods/v/Shopiroller.svg?style=flat)](https://cocoapods.org/pods/Shopiroller)
[![License](https://img.shields.io/cocoapods/l/Shopiroller.svg?style=flat)](https://cocoapods.org/pods/Shopiroller)
[![Platform](https://img.shields.io/cocoapods/p/Shopiroller.svg?style=flat)](https://cocoapods.org/pods/Shopiroller)

Table of Contents[](README.md)
===================
<!--ts-->
   * [Installation](#installation)
   * [Guide Of Implementation](#guide-of-implementation)
   * [Guide Of Implementation](#guide-of-implementation)

<!--te-->

## Installation

#### - CocoaPods

<br/>

1. Add `Shopiroller` into your `Podfile` in Xcode as below:

```bash
platform :ios, '13.0'
use_frameworks!

target YOUR_PROJECT_TARGET do
    pod 'Shopiroller'
end
```
2. Install Shopiroller via `CocoaPods`
```bash
$ pod install
```

3. Update Shopiroller via CocoaPods
```bash
$ pod update
```

## Guide Of Implementation
<br/>

<br/>

### 1 - Initialize with Credentials
 <br/>

Set your credentials through `AppDelegate` as below:

```swift
// AppDelegate.swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let ecommerce = ShopirollerCredentials(aliasKey: "iosAliasKey", apiKey: "apiKey", baseUrl: "baseUrl") /* You need to change string variables iosAliasKey, apiKey and baseUrl with your credentials */
        let appUser = ShopirollerAppUserCredentials(appKey: "userAppKey", apiKey: "userApiKey", baseUrl: "userBaseUrl") /* These credentials for users these variables need to be changed like below code with your credentials */
        
        ShopirollerApp.shared.initiliaze(eCommerceCredentials: ecommerce, appUserCredentials: appUser, baseUrl: "", theme: getShopirollerTheme(navigationTitleColor: .white, navigationBartintColor: .red))
        
        ShopirollerApp.shared.setUserId("userId") //You need to change this variable with your User Id
        ShopirollerApp.shared.setUserEmail("sample@sample.com") //You need to change this variable with your User Email
        
        return true
    }
```
> **Note**
> In the above, you should specify  **ShopirollerCredentials apiKey, aliasKey and baseUrl**  with your Credentials.<br/>

> **Note**
> In the above, you should specify **ShopirollerAppUserCredentials** as same as **ShopirollerCredentials**.
 
<br/>

<br/>

  ### 2 - Set App Theme
  <br/>
If you checked ShopirollerApp.shared.initialize method you can see theme parameter in this method helping us to set theme of navigationBarTitleTintColor and Appearance Color  <br/>

Set your theme through AppDelegate as below:

```swift

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)

        //Set Theme Colors

        shopirollerTheme.navigationTitleTintColor = .white
        shopirollerTheme.navigationBarTintColor = .red
        shopirollerTheme.navigationIconsTintColor = .white
        
        //Set UINavigationBarAppearance

        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = shopirollerTheme.navigationBarTintColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: shopirollerTheme.navigationTitleTintColor]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: shopirollerTheme.navigationBarTintColor]
                       
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance

           ShopirollerApp.shared.initiliaze(eCommerceCredentials: ecommerce, appUserCredentials: appUser, baseUrl: "", theme: shopirollerTheme)

        return true
    }

```
You can specify color whatever you want there are two sample color for <br/>
* navigationBarTitleTintColor .white
* navigationBarTintColor .red <br/>

![mergedImage](https://user-images.githubusercontent.com/86607113/191032268-d7396d19-74e7-4468-9460-1e54826fc85b.png)

<br/>
<br/>

<br/>

  ### 3 - Add Login Required
  <br/>

 If a non-login user can't complete the flow you can use ShopirollerDeleagte method as below:

```swift

    func userLoginNeeded(navigationController: UINavigationController?) {
        //Let's say you have a login page and in your flow the user needs to login to complete the flow, if user not logged in you can use this function to redirect the user to the login screen. An example usage is available in SRProductDetailViewController
        
        //An Example code below how to open Login Page
        
        let loginPageVC = LoginPageViewController(viewModel: LoginPageViewModel())
        navigationController?.pushViewController(loginPageVC, animated: true)
    }
    
```
<br/>To Trigger userLoginNeeded method sample code is below:<br/>

```swift
//Sample Usage Of userLoginNeeded

    private func checkUserLoggedIn() {
        if ShopirollerApp.shared.isUserLoggedIn() {
            // Continue your flow
        } else {
            ShopirollerApp.shared.delegate?.userLoginNeeded(navigationController: self.navigationController) //This code will trigger userLoginNeeded method in Appdelegate and redirect user to login page.
        }
    }
```

<br/>

|Component|Description|
|---|---|
|SBUGroupChannelListViewController|A `ViewController` that manages a group channel list.|
|SBUGroupChannelViewController|A `ViewController` that manages a 1-on-n group chat channel.|
|SBUOpenChannelViewController|A `ViewController` that manages a open chat channel.|
|SBUCreateChannelViewController|A `ViewController` that creates a channel.|
|SBUInviteUserViewController|A `ViewController` that invites a user to a channel.|
|SBURegisterOperatorViewController|A `ViewController` that registers as operator in a channel.|
|SBUUserListViewController|A `ViewController` that shows a list of members or participants in a channel.|
|SBUGroupChannelSettingsViewController|A `ViewController` that configures a group channel.|
|SBUOpenChannelSettingsViewController|A `ViewController` that configures a open channel.|
|SBUModerationsViewController|A `ViewController` that moderates a channel.|
|SBUMessageSearchViewController|A `ViewController` that searches messages in a channel.|
|SBUTheme|A singleton that manages themes.|
|SBUColorSet|A singleton that manages color sets.|
|SBUFontSet|A singleton that manages font sets.|
|SendbirdUI|A class that contains static functions required when using Sendbird UIKit.|
|SBUGlobalSet|A class that contains static attributes required when using Sendbird UIKit.|

## Author

ealtaca, ealtaca@gmail.com

## License

Shopiroller is available under the MIT license. See the LICENSE file for more info.
