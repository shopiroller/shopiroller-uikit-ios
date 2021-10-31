//
//  UIViewExtension.swift
//  shopiroller
//
//  Created by Görkem Gür on 23.09.2021.
//

import UIKit

extension UIView {
    
    func makeToast(text: String?){
        makeToast(text, duration: 3.0, position: .bottom)
    }
    
    func makeToast(_ error: ErrorViewModel){
        makeToast(error.message, duration: 3.0, position: .bottom)
    }
    
    func makeCardView() {
        layer.cornerRadius = 8
        backgroundColor = .white
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 12
        layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        layer.shadowOpacity = 0.4
        clipsToBounds = false
        
    }
    
    func add(_ subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        subview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        subview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    func makeAnimation() {
        self.transform = CGAffineTransform.init(scaleX: 0.3, y: 0.3)

        UIView.animate(withDuration: 0.1, animations: { () -> Void in

            self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        })
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 3.0, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
    
}
