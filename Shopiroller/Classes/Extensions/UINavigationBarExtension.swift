//
//  UINavigationBarExtension.swift
//  Shopiroller
//
//  Created by Görkem Gür on 18.10.2021.
//

import Foundation
import UIKit


extension UINavigationBar {

    func makeNavigationBar(_ backgroundColor: UIColor) {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        self.backgroundColor = backgroundColor
    }
}
extension UINavigationItem {
    
}

