//
//  UINavigationBarExtension.swift
//  Shopiroller
//
//  Created by Görkem Gür on 18.10.2021.
//

import Foundation
import UIKit


extension UINavigationBar {
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        var updatedFrame = self.bounds
        updatedFrame.size.height += self.frame.minY
        gradientLayer.frame = updatedFrame
        gradientLayer.colors = [UIColor.navigationBackGroundEndColor.cgColor,
                                UIColor.navigationBackGroundMidColor.cgColor,
                                UIColor.navigationBackGroundStartColor.cgColor] 
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        guard let render = UIGraphicsGetCurrentContext() else { return }
        gradientLayer.render(in: render)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setBackgroundImage(image, for: UIBarMetrics.default)
    }
    
}

