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
    
    func removeSubViews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    func rightViewImage(image: UIImage, type: SRTextFieldType) {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 80, height: bounds.size.height)
        button.setImage(image)
        self.rightView = button
        self.tintColor = .textPrimary
        self.rightViewMode = .always
        translatesAutoresizingMaskIntoConstraints = false
        if (type == .withPadding) {
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
            rightView?.widthAnchor.constraint(equalToConstant: 50).isActive = true
            rightView?.heightAnchor.constraint(equalToConstant: image.size.height).isActive = true
        } else {
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            rightView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
            rightView?.heightAnchor.constraint(equalToConstant: 7).isActive = true
        }
    }
    
    typealias ToolbarItem = (title: String, target: Any, selector: Selector)

    func addToolbar(leading: [ToolbarItem] = [], trailing: [ToolbarItem] = []) {
        let toolbar = UIToolbar()
        var trailingButton = UIBarButtonItem()
        var leadingButton = UIBarButtonItem()

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let leadingItems = leading.map { item -> UIBarButtonItem in
            leadingButton = UIBarButtonItem(title: item.title, style: .plain, target: item.target, action: item.selector)
            leadingButton.tintColor = .blue
            return leadingButton
        }

        let trailingItems = trailing.map { item -> UIBarButtonItem in
            trailingButton = UIBarButtonItem(title: item.title, style: .plain, target: item.target, action: item.selector)
            trailingButton.tintColor = .blue
            return trailingButton
        }

        var toolbarItems: [UIBarButtonItem] = leadingItems
        toolbarItems.append(flexibleSpace)
        toolbarItems.append(contentsOf: trailingItems)

        toolbar.setItems(toolbarItems, animated: false)
        toolbar.sizeToFit()

         self.inputAccessoryView = toolbar
    }

    func addNextAction(target: Any, selector: Selector) {
        let nextButton = UITextField.ToolbarItem(title: "e_commerce_general_next_step_text" .localized, target: target, selector: selector)
        self.addToolbar(trailing: [nextButton])
    }
    
    func addCustomTextAction(title: String, target: Any, selector: Selector) {
        let customButton = UITextField.ToolbarItem(title: title.capitalized, target: target, selector: selector)
        self.addToolbar(trailing: [customButton])
    }
    
}
