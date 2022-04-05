//
//  EmptyModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 21.10.2021.
//

import Foundation

struct EmptyModel {
    
    let image: UIImage
    let title: String
    let description: String?
    let button: ButtonModel?
    
}

struct ButtonModel {
    let title: String
    let color: UIColor?
} 
