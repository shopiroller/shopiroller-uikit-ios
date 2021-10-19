//
//  MyOrdersViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 19.10.2021.
//

import UIKit

class MyOrdersViewController: BaseViewController<MyOrdersViewModel> {

    override func setup() {
        super.setup()
        
        
    }
    
    init(viewModel: MyOrdersViewModel){
        super.init(viewModel: viewModel, nibName: MyOrdersViewController.nibName, bundle: Bundle(for: MyOrdersViewController.self))
    }

}
