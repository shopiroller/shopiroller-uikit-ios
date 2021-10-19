//
//  MyOrdersViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 19.10.2021.
//

import UIKit

class MyOrdersViewController: BaseViewController<MyOrdersViewModel>, EmptyViewDelegate {
    
    @IBOutlet private weak var emptyView: EmptyView!
    @IBOutlet private weak var orderTable: UITableView!
    
    init(viewModel: MyOrdersViewModel){
        super.init(viewModel: viewModel, nibName: MyOrdersViewController.nibName, bundle: Bundle(for: MyOrdersViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        emptyView.isHidden = false
        emptyView.setup(model: viewModel.getEmptyModel())
        emptyView.delegate = self
    }
    
    func actionButtonClicked(_ sender: Any) {
        pop(animated: true, completion: nil)
    }

}
