//
//  AddressListViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 25.10.2021.
//

import UIKit

class AddressListViewController: BaseViewController<AddressListViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    init(viewModel: AddressListViewModel){
        super.init(viewModel: viewModel, nibName: AddressListViewController.nibName, bundle: Bundle(for: AddressListViewController.self))
    }

}
