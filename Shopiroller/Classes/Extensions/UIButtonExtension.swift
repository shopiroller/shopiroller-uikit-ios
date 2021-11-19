//
//  UIButtonExtension.swift
//  shopiroller
//
//  Created by Görkem Gür on 23.09.2021.
//

import UIKit

extension UIControl.State {
    
    static var allCases: [UIControl.State] = [.normal, .highlighted, .disabled, .selected, . focused, .application, . reserved]
    
}

extension UIButton {
    
    // default is nil. title is assumed to be single line
    
    func setTitle(_ title: String? = nil) {
        UIControl.State.allCases.forEach { setTitle(title, for: $0) }
    }
    
    func setTitleColor(_ color: UIColor?) {
        UIControl.State.allCases.forEach { setTitleColor(color, for: $0) }
    }
    
    // default is nil. should be same size if different for different states
    
    func setImage(_ image: UIImage?) {
        UIControl.State.allCases.forEach { setImage(image, for: $0) }
    }
    
    // default is nil
    func setBackgroundImage(_ image: UIImage?) {
        UIControl.State.allCases.forEach { setBackgroundImage(image, for: $0) }
    }
    
    func createNavBarButton(image: UIImage?) -> UIButton {
        let button = UIButton(type: .custom)
        button.tintColor = .black
        button.setImage(image)
        button.translatesAutoresizingMaskIntoConstraints = true
        button.layer.masksToBounds = false
        button.contentEdgeInsets.left = 7
        button.frame.size = CGSize(width: 10, height: 10)
        return button
    }
    
    func createBadge() {
        let badgeSize: CGFloat = 17
        let badgeCount = UILabel(frame: CGRect(x: 0, y: 0, width: badgeSize, height: badgeSize))
        badgeCount.translatesAutoresizingMaskIntoConstraints = false
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = UIFont.boldSystemFont(ofSize: 12)
        badgeCount.backgroundColor = UIColor(red: 221/255, green: 55/255, blue: 95/255, alpha: 1)
        badgeCount.text = "\(SRAppContext.shoppingCartCount)"
        self.addSubview(badgeCount)
            NSLayoutConstraint.activate([
                badgeCount.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14),
                badgeCount.topAnchor.constraint(equalTo: self.topAnchor, constant: -7),
                badgeCount.widthAnchor.constraint(equalToConstant: badgeSize),
                badgeCount.heightAnchor.constraint(equalToConstant: badgeSize)
            ])
        self.layoutIfNeeded()
    }

}

extension UIBarButtonItem {
    func createUIBarButtonItem(_ button: UIButton?) -> UIBarButtonItem {
        let uiBarButton : UIBarButtonItem = UIBarButtonItem()
        uiBarButton.customView = button
        return uiBarButton
    }
    
}
