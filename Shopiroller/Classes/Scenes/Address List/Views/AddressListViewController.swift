//
//  AddressListViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 25.10.2021.
//

import UIKit

class AddressListViewController: BaseViewController<AddressListViewModel> {
    
    @IBOutlet private weak var addressSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var addressTableView: UITableView!
    @IBOutlet private weak var addressEmptyView: EmptyView!

    init(viewModel: AddressListViewModel){
        super.init(viewModel: viewModel, nibName: AddressListViewController.nibName, bundle: Bundle(for: AddressListViewController.self))
    }
    
    override func setup() {
        super.setup()
    }

}
