//
//  UITextFieldExtension.swift
//  Shopiroller
//
//  Created by Görkem Gür on 8.11.2021.
//

import Foundation
import UIKit


extension UITextField {
    
    func setBottomBorderOnlyWith(color: CGColor) {
        self.borderStyle = .line
        let border = CALayer()
        let width = CGFloat(0.5)
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
    }
    
    func setErrowView(baseColor: CGColor, errorMessage: String){
        let color = CABasicAnimation(keyPath: "borderColor")
        color.fromValue = UIColor.black.cgColor
        color.toValue = UIColor.red.cgColor
        color.duration = 3
        color.repeatCount = 1
        layer.borderWidth = 1
        layer.borderColor = UIColor.red.cgColor
        self.layer.add(color, forKey: "borderColor")
        let messageVw = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.maxY + 3, width: self.frame.width, height: self.frame.height / 2))
        messageVw.backgroundColor = UIColor.clear
        let errorLbl = UILabel(frame: CGRect(x: 0, y: 2, width: messageVw.frame.size.width, height: messageVw.frame.size.height))
        errorLbl.backgroundColor = .clear
        errorLbl.numberOfLines = 2
        errorLbl.text = errorMessage
        errorLbl.textColor = .red
        errorLbl.textAlignment = .left
        errorLbl.font = UIFont.systemFont(ofSize: 9)
        messageVw.addSubview(errorLbl)
        self.addSubview(messageVw)
    }
    
    func removeSubViews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    var rightViewImage: UIImage? {
        set {
            let button = UIButton(type: .custom)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
            button.frame = CGRect(x: 0.0, y: 0.0, width: 80, height: bounds.size.height)
            button.setImage(newValue)
            self.rightView = button
            self.rightViewMode = .always
            
            translatesAutoresizingMaskIntoConstraints = false
            rightView?.widthAnchor.constraint(equalToConstant: 50).isActive = true
        }
        get {
            return (rightView as? UIImageView)?.image
        }
    }
    
    typealias ToolbarItem = (title: String, target: Any, selector: Selector)

    func addToolbar(leading: [ToolbarItem] = [], trailing: [ToolbarItem] = []) {
        let toolbar = UIToolbar()

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let leadingItems = leading.map { item in
            return UIBarButtonItem(title: item.title, style: .plain, target: item.target, action: item.selector)
        }

        let trailingItems = trailing.map { item in
            return UIBarButtonItem(title: item.title, style: .plain, target: item.target, action: item.selector)
        }

        var toolbarItems: [UIBarButtonItem] = leadingItems
        toolbarItems.append(flexibleSpace)
        toolbarItems.append(contentsOf: trailingItems)

        toolbar.setItems(toolbarItems, animated: false)
        toolbar.sizeToFit()

         self.inputAccessoryView = toolbar
    }

    func addNextAction(target: Any, selector: Selector) {
        let nextButton = UITextField.ToolbarItem(title: "keyboard-next-action-text" .localized, target: target, selector: selector)
        self.addToolbar(trailing: [nextButton])
    }
    
    func addCustomTextAction(title: String, target: Any, selector: Selector) {
        let customButton = UITextField.ToolbarItem(title: title.capitalized, target: target, selector: selector)
        self.addToolbar(trailing: [customButton])
    }
    
}
