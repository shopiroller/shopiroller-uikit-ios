//
//  AddressListViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 27.10.2021.
//

import UIKit

class AddressListViewController: BaseViewController<AddressListViewModel> {

    @IBOutlet private weak var addressTable: UITableView!
    @IBOutlet private weak var emptyView: EmptyView!
    
    init(viewModel: AddressListViewModel){
        super.init(viewModel: viewModel, nibName: AddressListViewController.nibName, bundle: Bundle(for: AddressListViewController.self))
    }
    
    override func setup() {
        super.setup()
        getAddressList()
    }
    
    private func configure() {
        if(viewModel.isListEmpty()){
            addressTable.isHidden = true
            emptyView.isHidden = false
            emptyView.setup(model: viewModel.getEmptyModel())
        }else{
            addressTable.isHidden = false
            emptyView.isHidden = true
            addressTable.register(cellClass: AddressTableViewCell.self)
            addressTable.delegate = self
            addressTable.dataSource = self
            addressTable.reloadData()
        }
    }
    
    private func getAddressList() {
        viewModel.getAddressList(success: {
            self.configure()
        }) { [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
}

extension AddressListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getListSize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.reuseIdentifier, for: indexPath) as! AddressTableViewCell
        
        switch viewModel.state {
        case .shipping:
            guard let model = viewModel.getShippingAddress(position: indexPath.row) else { return cell}
            cell.setup(model: model)
        case .billing:
            guard let model = viewModel.getBillingAddress(position: indexPath.row) else { return cell}
            cell.setup(model: model)
        }
        
        return cell
    }
}
