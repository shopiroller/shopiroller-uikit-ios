//
//  UINavigationBarExtension.swift
//  Shopiroller
//
//  Created by Görkem Gür on 18.10.2021.
//

import Foundation
import UIKit


extension UINavigationBar {
    
    func initializeNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        standardAppearance = appearance;
        scrollEdgeAppearance = standardAppearance
    }
}

