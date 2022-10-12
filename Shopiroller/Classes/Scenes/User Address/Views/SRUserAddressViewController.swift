//
//  UserAddressViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 27.10.2021.
//

import UIKit
import MaterialComponents.MaterialButtons

private struct Constants {
    static var shippingTitle: String { return "user_address_delivery_address_title".localized }
    static var billingTitle: String { return "user_address_invoice_address_title".localized }
}

open class SRUserAddressViewController: BaseViewController<SRUserAddressViewModel> {
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var addButton: MDCFloatingButton!
    
    
    private var pageVC: AddressListPageViewController?
    
    public init(viewModel: SRUserAddressViewModel){
        super.init("user_my_address_title".localized, viewModel: viewModel, nibName: SRUserAddressViewController.nibName, bundle: Bundle(for: SRUserAddressViewController.self))
    }
    
    public override func setupNavigationBar() {
//        super.setupNavigationBar()
//        updateNavigationBar(rightBarButtonItems: nil, isBackButtonActive: true)
    }
    
    public override func setup() {
        super.setup()
        getCount()
        segmentedControl.setTitle(Constants.shippingTitle, forSegmentAt: 0)
        segmentedControl.setTitle(Constants.billingTitle, forSegmentAt: 1)
        let pageVC = AddressListPageViewController(addressDelegate: self)
        addChildViewController(pageVC)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.medium14], for: .normal)
        
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
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            pageVC?.goToPreviousPage()
        }else{
            pageVC?.goToNextPage()
        }
    }
    
    @IBAction func addButtonTapped() {
        let addressBottomSheetViewController = SRAddressBottomSheetViewController(viewModel: SRAddressBottomSheetViewModel(type: segmentedControl.selectedSegmentIndex == 0 ? .shipping : .billing, isEditing: false))
        addressBottomSheetViewController.delegate = self
        self.sheet(addressBottomSheetViewController)
    }
    
    private func getCount() {
        viewModel.getShoppingCartCount(success: { [weak self] in
            guard let self = self else { return }
        }) { [weak self] _ in
            guard let self = self else { return }
        }
    }
}

extension SRUserAddressViewController: AddressListPageDelegate {
    func pageViewController(currentIndex: Int) {
        segmentedControl.selectedSegmentIndex = currentIndex
    }
}

extension SRUserAddressViewController: AddressBottomViewDelegate {
    func saveButtonTapped(userShippingAddressModel: UserShippingAddressModel?, userBillingAddressModel: UserBillingAdressModel?, defaultAddressModel: SRDefaultAddressModel?) {
        self.view.makeToast(String(format: "user_my_address_saved_toast_message".localized))
        NotificationCenter.default.post(name: Notification.Name(SRAppConstants.UserDefaults.Notifications.userAddressListObserve), object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}
