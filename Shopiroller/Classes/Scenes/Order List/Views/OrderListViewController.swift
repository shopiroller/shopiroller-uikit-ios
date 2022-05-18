//
//  MyOrdersViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 19.10.2021.
//

import UIKit

open class OrderListViewController: BaseViewController<OrderListViewModel>, EmptyViewDelegate {
    
    @IBOutlet private weak var emptyView: EmptyView!
    @IBOutlet private weak var orderTable: UITableView!
    
    public init(viewModel: OrderListViewModel) {
        super.init("e_commerce_my_orders_title".localized, viewModel: viewModel, nibName: OrderListViewController.nibName, bundle: Bundle(for: OrderListViewController.self))
    }
    
    public override func setup() {
        super.setup()
        getCount()
        getOrderList()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        if viewModel.isOpenedFromResultPage() == true {
            self.navigationController?.navigationBar.isHidden = false
            updateNavigationBar(rightBarButtonItems: nil, isBackButtonActive: true)
        }
    }
    
    public override func goBack() {
        if viewModel.isOpenedFromResultPage() == true {
            self.popToRoot(animated: true)
        } else {
            pop(animated: true, completion: nil)
        }
    }
    
    private func configure(){
        if(viewModel.isOrderListEmpty()){
            orderTable.isHidden = true
            emptyView.isHidden = false
            emptyView.setup(model: viewModel.getEmptyModel())
            emptyView.delegate = self
        } else {
            orderTable.isHidden = false
            orderTable.register(cellClass: OrderTableViewCell.self)
            orderTable.delegate = self
            orderTable.dataSource = self
            orderTable.reloadData()
            orderTable.backgroundColor = .clear
            orderTable.clipsToBounds = false
        }
    }
    
    private func getOrderList() {
        viewModel.getOrderList(success: {
            self.configure()
        }) { [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func getOrderDetail() {
        let viewController = OrderDetailViewController(viewModel: OrderDetailViewModel(detail: self.viewModel.getOrderDetailModel()))
        self.prompt(viewController, animated: true, completion: nil)
    }
    
    func actionButtonClicked(_ sender: Any) {
        self.createNewRootMainPage()
    }
    
    private func getCount() {
        viewModel.getShoppingCartCount(success: {
            [weak self] in
            guard let self = self else { return }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
}

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModel.orderListCount()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedPosition = indexPath.row
        self.getOrderDetail()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
