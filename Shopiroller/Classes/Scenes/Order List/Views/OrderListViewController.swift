//
//  MyOrdersViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 19.10.2021.
//

import UIKit

class OrderListViewController: BaseViewController<OrderListViewModel>, EmptyViewDelegate {
    
    @IBOutlet private weak var emptyView: EmptyView!
    @IBOutlet private weak var orderTable: UITableView!
    
    init(viewModel: OrderListViewModel){
        super.init(viewModel: viewModel, nibName: OrderListViewController.nibName, bundle: Bundle(for: OrderListViewController.self))
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
            orderTable.isHidden = false
            orderTable.register(cellClass: OrderTableViewCell.self)
            orderTable.delegate = self
            orderTable.dataSource = self
            orderTable.backgroundColor = .clear
            orderTable.clipsToBounds = false
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

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.orderListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.reuseIdentifier, for: indexPath) as! OrderTableViewCell
        
        if indexPath.row == 0 {
            cell.layer.cornerRadius = 20
            cell.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            cell.layer.cornerRadius = 0
        }
        
        guard let order = viewModel.getOrder(position: indexPath.row) else { return cell}
        cell.setup(model: order)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.prompt(OrderDetailViewController(viewModel: OrderDetailViewModel()), animated: true, completion: nil)
    }
}
