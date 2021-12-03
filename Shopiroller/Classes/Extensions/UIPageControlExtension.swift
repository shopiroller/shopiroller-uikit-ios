//
//  UIPageControlExtension.swift
//  Shopiroller
//
//  Created by Görkem Gür on 18.10.2021.
//

import Foundation

extension UIPageControl {
    
    func customizePageControl(_ pageControlContainer: UIView!) -> UIPageControl {
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        self.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.4)
        pageControlContainer.backgroundColor = .sliderBackground
        pageControlContainer.clipsToBounds = false
        pageControlContainer.layer.cornerRadius = self.frame.height / 2
        if #available(iOS 14.0, *) {
            self.backgroundStyle = .minimal
            self.allowsContinuousInteraction = false
        }
        return self
    }
    
}
