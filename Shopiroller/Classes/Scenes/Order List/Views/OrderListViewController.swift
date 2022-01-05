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
    
    init(viewModel: OrderListViewModel){
        super.init("order-list-page-title".localized, viewModel: viewModel, nibName: OrderListViewController.nibName, bundle: Bundle(for: OrderListViewController.self))
    }
    
    public override func setup() {
        super.setup()
        getCount()
        getOrderList()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.isOpenedFromResultPage() == true {
            goBack()
        }
    }
    
    public override func goBack() {
        let mainPageVC = SRMainPageViewController(viewModel: SRMainPageViewModel())
        self.prompt(mainPageVC, animated: true, completion: nil)
    }
    
    private func configure(){
        if(viewModel.isOrderListEmpty()){
            orderTable.isHidden = true
            emptyView.isHidden = false
            emptyView.setup(model: viewModel.getEmptyModel())
            emptyView.delegate = self
        }else{
            orderTable.isHidden = false
            orderTable.register(cellClass: OrderTableViewCell.self)
            orderTable.delegate = self
            orderTable.dataSource = self
            orderTable.reloadData()
            orderTable.backgroundColor = .clear
            orderTable.clipsToBounds = false
        }
    }
    
    public override func setupNavigationBar() {
        super.setupNavigationBar()
        updateNavigationBar(rightBarButtonItems: nil, isBackButtonActive: true)
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
       popToRoot(animated: true, completion: nil)
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
