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
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var shippingAddressAddButton: UIButton!
    @IBOutlet private weak var shippingAddressViewLabel: UILabel!
    @IBOutlet private weak var billingAddressViewTitle: UILabel!
    @IBOutlet private weak var billingAddressAddButton: UIButton!
    @IBOutlet private weak var shippingAddressEmptyView: EmptyView!
    @IBOutlet private weak var billingAddressEmptyView: EmptyView!
    @IBOutlet private weak var defaultDeliveryAddress: GeneralAddressView!
    @IBOutlet private weak var defaultBillingAddress: GeneralAddressView!
    
    var delegate : CheckOutProgressPageDelegate?
    
    init(viewModel: CheckOutAddressViewModel){
        super.init(viewModel: viewModel, nibName: CheckOutAddressViewController.nibName, bundle: Bundle(for: CheckOutAddressViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        defaultBillingAddress.delegate = self
        defaultDeliveryAddress.delegate = self
        
        shippingAddressViewLabel.text = Constants.deliveryAddressText
        shippingAddressViewLabel.textColor = .textPrimary
        shippingAddressViewLabel.font = .semiBold14
        
        billingAddressViewTitle.text = Constants.billingAddressText
        billingAddressViewTitle.textColor = .textPrimary
        billingAddressViewTitle.font = .semiBold14
        
        shippingAddressAddButton.setTitle(Constants.addAddressButtonText)
        shippingAddressAddButton.tintColor = .textSecondary
        shippingAddressAddButton.titleLabel?.font = .medium12
        
        billingAddressAddButton.setTitle(Constants.addAddressButtonText)
        billingAddressAddButton.tintColor = .textSecondary
        billingAddressAddButton.titleLabel?.font = .medium12
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.isHidingNextButton(hide: false)
        getDefaultAddress()
        getAddressList()
    }
    
    private func getDefaultAddress() {
        viewModel.getDefaultAddress(success: {
            self.configureViews()
            self.containerView.isHidden = false
        }) { [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func getAddressList() {
        viewModel.getAddressList(success: {
            self.configureViews()
        }) { [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func configureViews() {
                
        let isBillingAddressEmpty = viewModel.isBillingAddressEmpty()
        
        billingAddressEmptyView.isHidden = !isBillingAddressEmpty
        billingAddressAddButton.isHidden = isBillingAddressEmpty
        defaultBillingAddress.isHidden = isBillingAddressEmpty
        
        if isBillingAddressEmpty {
            billingAddressEmptyView.setup(model: viewModel.getBillingEmptyModel())
            billingAddressEmptyView.addressDelegate = self
        } else {
            defaultBillingAddress.setup(model: viewModel.getBillingAddressModel())
            SRSessionManager.shared.userBillingAddress = viewModel.selectedBillingAddress
        }
        
        let isShippingAddressEmpty = viewModel.isShippingAddressEmpty()
        
        shippingAddressEmptyView.isHidden = !isShippingAddressEmpty
        shippingAddressAddButton.isHidden = isShippingAddressEmpty
        defaultDeliveryAddress.isHidden = isShippingAddressEmpty
        
        if isShippingAddressEmpty {
            shippingAddressEmptyView.setup(model: viewModel.getShippingEmptyModel())
            shippingAddressEmptyView.addressDelegate = self
        } else {
            defaultDeliveryAddress.setup(model: viewModel.getDeliveryAddressModel())
            SRSessionManager.shared.userDeliveryAddress = viewModel.selectedShippingAddress
        }
        
        self.view.layoutIfNeeded()

        delegate?.isEnabledNextButton(enabled: !isShippingAddressEmpty && !isBillingAddressEmpty)
        
    }
    
    @IBAction func addShippingAddressButtonTapped() {
        sheetAddressBottomSheet(addressBottomSheetViewModel: AddressBottomSheetViewModel(type: .shipping))
    }
    
    @IBAction func addBillingAddressButtonTapped() {
        sheetAddressBottomSheet(addressBottomSheetViewModel: AddressBottomSheetViewModel(type: .billing))
    }
    
    private func sheetAddressBottomSheet(addressBottomSheetViewModel: AddressBottomSheetViewModel) {
        let addressBotttomSheetViewController = AddressBottomSheetViewController(viewModel: addressBottomSheetViewModel)
        addressBotttomSheetViewController.delegate = self
        self.sheet(addressBotttomSheetViewController, completion: nil)
    }
    
}

extension CheckOutAddressViewController: GeneralAddressDelegate {
    func editButtonTapped(type: GeneralAddressType) {
        switch type {
        case .shipping:
            sheetAddressBottomSheet(addressBottomSheetViewModel: AddressBottomSheetViewModel(type: type, isEditing: true, userShippingAddress: viewModel.getShippingAddress()))
        case .billing:
            sheetAddressBottomSheet(addressBottomSheetViewModel: AddressBottomSheetViewModel(type: type, isEditing: true, userBillingAddress: viewModel.getBillingAddress()))
        }
    }
    
    
    func selectOtherAdressButtonTapped(type: GeneralAddressType?) {
        var listPopUpViewModel : ListPopUpViewModel = ListPopUpViewModel(listType: .address)
        switch type {
        case .billing:
            listPopUpViewModel = ListPopUpViewModel(listType: .address, userBillingAddressList: viewModel.getUserBillingAddressList(), addressType: type)
        case .shipping:
            listPopUpViewModel = ListPopUpViewModel(listType: .address, userShippingAddressList: viewModel.getUserShippingAddressList(), addressType: type)
        case .none:
            break
        }
        let listPopUpVC = ListPopUpViewController(viewModel: listPopUpViewModel)
        listPopUpVC.addressDelegate = self
        popUp(listPopUpVC, completion: nil)
    }
}

extension CheckOutAddressViewController : AddressBottomViewDelegate {
    func saveButtonTapped() {
        DispatchQueue.main.async {
            self.viewModel.selectedBillingAddress = nil
            self.viewModel.selectedShippingAddress = nil
            self.getDefaultAddress()
            self.getAddressList()
        }
        delegate?.showSuccessfullToastMessage()
        dismiss(animated: true, completion: nil)
    }
    
    func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension CheckOutAddressViewController: ListPopUpAddressDelegate {
    
    func getBillingAddress(billingAddress: UserBillingAdressModel?) {
        defaultBillingAddress.setup(model: GeneralAddressModel(title: billingAddress?.title, address: billingAddress?.addressLine, description: billingAddress?.getDescriptionArea(), type: .billing, isEmpty: false))
        viewModel.selectedBillingAddress = billingAddress
        SRSessionManager.shared.userBillingAddress = viewModel.selectedBillingAddress
        self.view.layoutIfNeeded()
    }
    
    func getShippingAddress(shippingAddress: UserShippingAddressModel?) {
        defaultDeliveryAddress.setup(model: GeneralAddressModel(title: shippingAddress?.title, address: shippingAddress?.addressLine, description: shippingAddress?.getDescriptionArea(), type: .shipping, isEmpty: false))
        viewModel.selectedShippingAddress = shippingAddress
        SRSessionManager.shared.userDeliveryAddress = viewModel.selectedShippingAddress
        self.view.layoutIfNeeded()
    }
}

extension CheckOutAddressViewController : EmptyViewAddressDelegate {
    
    func addAddressButtonClicked(type: GeneralAddressType?) {
        if let type = type {
            sheetAddressBottomSheet(addressBottomSheetViewModel: AddressBottomSheetViewModel(type: type))
        }
    }    
}
