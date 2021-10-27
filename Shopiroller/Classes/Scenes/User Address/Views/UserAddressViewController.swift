//
//  UserAddressViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 27.10.2021.
//

import UIKit

class UserAddressViewController: BaseViewController<UserAddressViewModel> {
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var containerView: UIView!
    
    init(viewModel: UserAddressViewModel){
        super.init(viewModel: viewModel, nibName: UserAddressViewController.nibName, bundle: Bundle(for: UserAddressViewController.self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backButton = UIBarButtonItem(customView: createNavigationItem(.backIcon , .goBack))
        
        navigationItem.leftBarButtonItem = backButton
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.makeNavigationBar(.clear)
        
        getCount()
        
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
