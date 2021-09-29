//
//  NibLoadable.swift
//  shopiroller
//
//  Created by Görkem Gür on 22.09.2021.
//

import UIKit

protocol NibLoadable {
    static var nibName: String { get }
}

extension NibLoadable where Self: UIViewController {
    
    static var nibName: String {
        return String(describing: Self.self)
    }
    
}

extension NibLoadable where Self: UIView {
    
    static var nibName: String {
        return String(describing: Self.self)
    }
    
    static var nib: UINib {
        let bundle = Bundle(for: Self.self)
        return UINib(nibName: Self.nibName, bundle: bundle)
    }
    
    func setupFromNib() {
        guard let view = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("Error loading \(self) from nib") }
        view.backgroundColor = .clear
        add(view)
    }
    
}
