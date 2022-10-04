# Shopiroller

[![Build](https://img.shields.io/github/checks-status/ealtaca/shopiroller_ios/master)](https://cocoapods.org/pods/Shopiroller)
[![Version](https://img.shields.io/cocoapods/v/ShopiRoller)](https://cocoapods.org/pods/Shopiroller)
[![Platform](https://img.shields.io/badge/platform-iOS-green)]()
[![Swift](https://img.shields.io/badge/swift-4.0-green)]()
[![Release](https://img.shields.io/github/v/release/ealtaca/shopiroller_ios)](https://github.com/ealtaca/shopiroller_ios/releases/latest)
[![PR](https://img.shields.io/github/issues-pr-raw/ealtaca/shopiroller_ios)](https://github.com/ealtaca/shopiroller_ios/pulls)
<br>

Social
---

[![Twitter](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/shopiroller)
[![Instagram](https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://www.instagram.com/shopiroller/)




Table of Contents
===
<!--ts-->
   * [Installation](#installation)
   * [Guide Of Implementation](#guide-of-implementation)
   * [Description Of ViewControllers](#description-of-viewcontrollers)

<!--te-->

## Installation

#### - CocoaPods


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

### 1 - Initialize with Credentials
<br/>

Set your credentials through `AppDelegate` as below:

```swift
// AppDelegate.swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        
      ...

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

### 2 - Set App Theme
  <br/>
If you checked ShopirollerApp.shared.initialize method you can see theme parameter in this method helping us to set theme of navigationBarTitleTintColor and Appearance Color  <br/>

Set your theme through AppDelegate as below:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        
    ...

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

    ShopirollerApp.shared.initiliaze(eCommerceCredentials: ecommerce, appUserCredentials: appUser, baseUrl: "", theme: shopirollerTheme)

    return true
}
```
You can specify color whatever you want there are two sample color for <br/>
* navigationBarTitleTintColor .white
* navigationBarTintColor UIColor(named: "navigationTint") <br/>

![Gif](./sample-gif/sample.gif)


### 3 - Add Login Required

 If a non-login user can't complete the flow you can use ShopirollerDeleagte method as below:

```swift
func userLoginNeeded(navigationController: UINavigationController?) {
    //Let's say you have a login page and in your flow the user needs to login to complete the flow, if user not logged in you can use this function to redirect the user to the login screen. An example usage is available in SRProductDetailViewController

    //An Example code below how to open Login Page

    let loginPageViewController = LoginPageViewController(viewModel: LoginPageViewModel())
    navigationController?.pushViewController(loginPageViewController, animated: true)
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

### Description Of ViewControllers
---
<br/>

|Component|Description|
|---|---|
|SRMainPageViewController|A `ViewController` that shows product, sliders, categories.|
|SRShoppingCartViewController|A `ViewController` that shows products added to cart.|
|SROrderListViewController|A `ViewController` that shows whether the created order was successful .|
|AddressListPageViewController|A `ViewController` that MainPage of SRUserAddressViewController.|
