//
//  ShopirollerApp.swift
//  Shopiroller
//
//  Created by Emre Can Altaca on 21.11.2021.
//

import Foundation
import UIKit

public class ShopirollerApp {
    
    public static var shared = ShopirollerApp()
    
    public var navigationBarColor: UIColor? = .black
    
    public func initiliaze(appKey: String, apiKey: String, baseUrl: String, color: UIColor) {
        
        print(Bundle(for: ShopirollerApp.self).bundleIdentifier)
        
        self.navigationBarColor = color
        
        UIFont.jbs_registerFont(
            withFilenameString: "Poppins-Bold.ttf",
            bundle: .shopiroller
        )
        
        UIFont.jbs_registerFont(
            withFilenameString: "Poppins-SemiBold.ttf",
            bundle: .shopiroller
        )

        UIFont.jbs_registerFont(
            withFilenameString: "Poppins-Regular.ttf",
            bundle: .shopiroller
        )
        
        UIFont.jbs_registerFont(
            withFilenameString: "Poppins-Medium.ttf",
            bundle: .shopiroller
        )


        UIFont.listAllFontsOnSystem()
        
        SRAppContext.fontFamily = .poppins
        
    }
}
