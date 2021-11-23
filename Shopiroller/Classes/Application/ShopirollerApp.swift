//
//  ShopirollerApp.swift
//  Shopiroller
//
//  Created by Emre Can Altaca on 21.11.2021.
//

import Foundation

public class ShopirollerApp {
    
    public static var shared = ShopirollerApp()
    
    public func initiliaze(appKey: String, apiKey: String, baseUrl: String) {
        
        print(Bundle(for: ShopirollerApp.self).bundleIdentifier)
        
        
        UIFont.jbs_registerFont(
            withFilenameString: "Fonts/Poppins-Bold.ttf",
            bundle: .shopiroller
        )
        
        UIFont.jbs_registerFont(
            withFilenameString: "Fonts/Poppins-SemiBold.ttf",
            bundle: .shopiroller
        )

        UIFont.jbs_registerFont(
            withFilenameString: "Fonts/Poppins-Regular.ttf",
            bundle: .shopiroller
        )
        
        UIFont.jbs_registerFont(
            withFilenameString: "Fonts/Poppins-Medium.ttf",
            bundle: .shopiroller
        )


        UIFont.listAllFontsOnSystem()
        
        SRAppContext.fontFamily = .poppins
        
    }
}
