//
//  AddressListViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 25.10.2021.
//

import UIKit

class AddressListViewController: BaseViewController<AddressListViewModel> {
    
    @IBOutlet private weak var addressSegmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!

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
        configure()
    }
    
    private func configure() {
        
        let thePageVC = AddressListPageViewController()
        addChildViewController(thePageVC)
        thePageVC.view.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(thePageVC.view)
        
        
        NSLayoutConstraint.activate([
            thePageVC.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0.0),
            thePageVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0.0),
            thePageVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0.0),
            thePageVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0.0),
        ])
        
        thePageVC.didMove(toParentViewController: self)
        
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

extension AddressListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.reuseIdentifier, for: indexPath) as! AddressTableViewCell
        
        guard let model = viewModel.getShippingAddress(position: indexPath.row) else { return cell}
        cell.setup(model: model)
        
        return cell
    }
}
