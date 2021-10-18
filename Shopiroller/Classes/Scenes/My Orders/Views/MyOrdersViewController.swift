//
//  MyOrdersViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 18.10.2021.
//

import Foundation

class MyOrdersViewController: BaseViewController<MyOrdersViewModel> {
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet private weak var startShopping: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: MyOrdersViewModel) {
        super.init(viewModel: viewModel, nibName: MyOrdersViewController.nibName, bundle: Bundle(for: MyOrdersViewController.self))
    }
    
    @IBAction func startShoppingClicked(_ sender: Any) {
    }
}
