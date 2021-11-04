//
//  CheckOutAddressViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import UIKit

class CheckOutAddressViewController: BaseViewController<CheckOutAddressViewModel> {
    
    private struct Constants {
        static var deliveryAddressText: String { return "delivery-address-title".localized }
        
        static var billingAddressText: String { return "billing-address-title".localized }
        
        static var addAddressButtonText: String { return "add-address-button-text".localized }
    }
    
    @IBOutlet private weak var shippingAddressAddButton: UIButton!
    @IBOutlet private weak var shippingAddressViewLabel: UILabel!
    @IBOutlet private weak var billingAddressViewTitle: UILabel!
    @IBOutlet private weak var billingAddressAddButton: UIButton!
    @IBOutlet private weak var shippingAddressEmptyView: EmptyView!
    @IBOutlet private weak var billingAddressEmptyView: EmptyView!
    @IBOutlet private weak var defaultDeliveryAddress: GeneralAddressView!
    @IBOutlet private weak var defaultBillingAddress: GeneralAddressView!
    
    
    override func setup() {
        super.setup()
        
        shippingAddressAddButton.setTitle(Constants.addAddressButtonText)
        billingAddressAddButton.setTitle(Constants.addAddressButtonText)
        
        shippingAddressViewLabel.text = Constants.deliveryAddressText
        shippingAddressViewLabel.textColor = .textPrimary
        shippingAddressViewLabel.font = UIFont.boldSystemFont(ofSize: 14)
        billingAddressViewTitle.text = Constants.billingAddressText
        billingAddressViewTitle.textColor = .textPrimary
        billingAddressViewTitle.font = UIFont.boldSystemFont(ofSize: 14)
        
        shippingAddressAddButton.tintColor = .black
        shippingAddressAddButton.tintColor = .textSecondary
        shippingAddressAddButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        billingAddressAddButton.tintColor = .black
        billingAddressAddButton.tintColor = .textSecondary
        billingAddressAddButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        
        
        getDefaultAddress()
    }
    
    init(viewModel: CheckOutAddressViewModel){
        super.init(viewModel: viewModel, nibName: CheckOutAddressViewController.nibName, bundle: Bundle(for: CheckOutAddressViewController.self))
    }
    
    private func getDefaultAddress() {
        viewModel.getDefaultAddress(success: {
            self.configureViews()
        }) { [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    
    private func configureViews() {
        if viewModel.isBillingAddressEmpty() {
            billingAddressEmptyView.isHidden = false
            billingAddressAddButton.isHidden = true
            billingAddressEmptyView.setup(model: viewModel.getBillingEmptyModel())
        } else {
            billingAddressAddButton.isHidden = false
            defaultBillingAddress.setup(model: viewModel.getBillingAddressModel())
        }
        
        if viewModel.isShippingAddressEmpty() {
            shippingAddressEmptyView.isHidden = false
            shippingAddressAddButton.isHidden = true
            shippingAddressEmptyView.setup(model: viewModel.getShippingEmptyModel())
        } else {
            shippingAddressAddButton.isHidden = false
            defaultDeliveryAddress.setup(model: viewModel.getDeliveryAddressModel())
        }
    }

}

extension CheckOutAddressViewController: GeneralAddressDelegate {
    func addAddressButtonTapped(type: GeneralAddressType?) {
        //TODO Add Address
    }
    
    func selectOtherAdressButtonTapped(type: GeneralAddressType?) {
        //TODO Select Other Adress
    }
    
    func editButtonTapped() {
        //TODO Edit Address
    }
    
    
}
