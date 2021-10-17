//
//  UIPageControlExtension.swift
//  Shopiroller
//
//  Created by Görkem Gür on 18.10.2021.
//

import Foundation

extension UIPageControl {
    
    func customizePageControl(_ pageControl: UIPageControl! , pageControlContainer: UIView!) {
        pageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.4)
        pageControlContainer.backgroundColor = .sliderBackground
        pageControlContainer.clipsToBounds = true
        pageControlContainer.layer.cornerRadius = pageControl.frame.height / 2
        if #available(iOS 14.0, *) {
            pageControl.backgroundStyle = .minimal
            pageControl.allowsContinuousInteraction = false
        }
    }
    
}
