//
//  UISearchBarExtension.swift
//  Shopiroller
//
//  Created by Görkem Gür on 9.03.2022.
//

import Foundation


extension UISearchBar {
    
    func setSearchBar(placeholder: String?) {
        self.placeholder = placeholder
        self.backgroundImage = UIImage()
        self.searchTextField.backgroundColor = .white
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
    }
    
}
