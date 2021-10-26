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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backButton = UIBarButtonItem(customView: createNavigationItem(.backIcon , .goBack))
        
        navigationItem.leftBarButtonItem = backButton
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.makeNavigationBar(.clear)
        
        getCount()
        
    }
    
    override func setup() {
        super.setup()
        getShippingAddresses()
        getBillingAddresses()
    }
    
    private func getShippingAddresses() {
        viewModel.getShippingAddresses(success: {
          
        }) { [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func getBillingAddresses() {
        viewModel.getBillingAddresses(success: {
          
        }) { [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
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
