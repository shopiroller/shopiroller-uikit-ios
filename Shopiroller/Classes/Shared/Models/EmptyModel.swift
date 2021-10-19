//
//  EmptyViewModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 23.09.2021.
//

import UIKit

struct EmptyModel {
    
    let image: UIImage
    let title: String
    let description: String
    let button: ButtonModel?

}

struct ButtonModel {
    let title: String
    let color: UIColor?
    let clicked: (() -> Void)
}
