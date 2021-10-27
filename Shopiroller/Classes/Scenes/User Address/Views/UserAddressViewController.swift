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
    
    private var pageVC: AddressListPageViewController?
    
    init(viewModel: UserAddressViewModel){
        super.init(viewModel: viewModel, nibName: UserAddressViewController.nibName, bundle: Bundle(for: UserAddressViewController.self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pageVC = AddressListPageViewController(addressDelegate: self)
        addChildViewController(pageVC)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(pageVC.view)
        
        NSLayoutConstraint.activate([
            pageVC.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0.0),
            pageVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0.0),
            pageVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0.0),
            pageVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0.0),
        ])
        
        pageVC.didMove(toParentViewController: self)
        
        self.pageVC = pageVC
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backButton = UIBarButtonItem(customView: createNavigationItem(.backIcon , .goBack))
        
        navigationItem.leftBarButtonItem = backButton
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.makeNavigationBar(.clear)
        
        getCount()
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            pageVC?.goToPreviousPage()
        }else{
            pageVC?.goToNextPage()
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

extension UserAddressViewController: AddressListPageDelegate {
    func pageViewController(currentIndex: Int) {
        segmentedControl.selectedSegmentIndex = currentIndex
    }
}
