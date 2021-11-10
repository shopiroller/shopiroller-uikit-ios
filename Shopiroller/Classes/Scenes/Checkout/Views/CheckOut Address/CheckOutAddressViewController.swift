//
//  CheckOutAddressViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import UIKit

protocol CheckOutAddressViewControllerDelegate {
    func showToastMessage()
}

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
    
    
    var delegate : CheckOutAddressViewControllerDelegate?
    
    override func setup() {
        super.setup()
        
        shippingAddressAddButton.setTitle(Constants.addAddressButtonText)
        billingAddressAddButton.setTitle(Constants.addAddressButtonText)
        
        defaultBillingAddress.delegate = self
        defaultDeliveryAddress.delegate = self
        
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
    
    @IBAction func addShippingAddressButtonTapped() {
        let vc = AddressBottomSheetViewController(viewModel: AddressBottomSheetViewModel(type: .shipping))
        vc.delegate = self
        self.sheet(vc, completion: nil)
    }
    
    @IBAction func addBillingAddressButtonTapped() {
        let vc = AddressBottomSheetViewController(viewModel: AddressBottomSheetViewModel(type: .billing))
        vc.delegate = self
        self.sheet(vc, completion: nil)
    }

}

extension CheckOutAddressViewController: GeneralAddressDelegate {
    func editButtonTapped(type: GeneralAddressType) {
        switch type {
        case .shipping:
            let vc = AddressBottomSheetViewController(viewModel: AddressBottomSheetViewModel(type: .shipping,isEditing: true,userShippingAddress: viewModel.getShippingAddress()))
            vc.delegate = self
            self.sheet(vc, completion: nil)
        case .billing:
            let vc = AddressBottomSheetViewController(viewModel: AddressBottomSheetViewModel(type: .billing,isEditing: true,userBillingAddress: viewModel.getBillingAddress()))
            vc.delegate = self
            self.sheet(vc, completion: nil)
        }
    }
    

    func selectOtherAdressButtonTapped(type: GeneralAddressType?) {
        let vc = ListPopUpViewController(viewModel: ListPopUpViewModel(listType: .address,addressType: type ?? .shipping ))
        vc.delegate = self
        popUp(vc, completion: nil)
    }
}

extension CheckOutAddressViewController : AddressBottomViewDelegate {
    func saveButtonTapped() {
        DispatchQueue.main.async {
            self.getDefaultAddress()
            self.view.layoutIfNeeded()
        }
        delegate?.showToastMessage()
        dismiss(animated: true, completion: nil)
    }
    
    func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension CheckOutAddressViewController: ListPopUpDelegate {
    func getBillingAddress(billingAddress: UserBillingAdressModel?) {
        defaultBillingAddress.setup(model: GeneralAddressModel(title: billingAddress?.title, address: billingAddress?.addressLine, description: billingAddress?.getDescriptionArea(), type: .billing, isEmpty: false))
        self.view.layoutIfNeeded()
    }
    
    func getShippingAddress(shippingAddress: UserShippingAddressModel?) {
        defaultDeliveryAddress.setup(model: GeneralAddressModel(title: shippingAddress?.title, address: shippingAddress?.addressLine, description: shippingAddress?.getDescriptionArea(), type: .shipping, isEmpty: false))
        self.view.layoutIfNeeded()
    }
    
    
}
