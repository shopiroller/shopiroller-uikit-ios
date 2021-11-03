//
//  ShoppingCartPopUpViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 3.11.2021.
//

import UIKit
import Kingfisher

class ShoppingCartPopUpViewController: BaseViewController<ShoppingCartPopUpViewModel> {

    init(viewModel: ShoppingCartPopUpViewModel){
        super.init(viewModel: viewModel, nibName: ShoppingCartPopUpViewController.nibName, bundle: Bundle(for: ShoppingCartPopUpViewController.self))
    }

    override func setup() {
        super.setup()
        
        
    }

}
