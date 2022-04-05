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
