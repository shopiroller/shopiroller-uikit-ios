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
        
        getOrderList()
    }
    
    private func configure(){
        if(viewModel.isOrderListEmpty()){
            emptyView.isHidden = false
            emptyView.setup(model: viewModel.getEmptyModel())
            emptyView.delegate = self
        }else{
            
        }
    }
    
    private func getOrderList() {
        viewModel.getOrderList(success: { [weak self] in
            guard let self = self else { return }
            self.configure()
        }) { [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    func actionButtonClicked(_ sender: Any) {
        pop(animated: true, completion: nil)
    }
    
}
