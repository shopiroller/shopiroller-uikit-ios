//
//  CheckOutAddressViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import UIKit
import FittedSheets

class CheckOutAddressViewController: BaseViewController<CheckOutAddressViewModel> {
    
    private struct Constants {
        static var deliveryAddressText: String { return "user_delivery_address".localized }
        
        static var billingAddressText: String { return "user_billing_address".localized }
        
        static var addShippingAddressButton: String { return "e_commerce_address_selection_no_shipping_address_button".localized }
        
        static var addInvoiceAddressButton: String { return "e_commerce_address_selection_no_invoice_address_button".localized }
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
        
        shippingAddressAddButton.setTitle(Constants.addShippingAddressButton)
        shippingAddressAddButton.tintColor = .textSecondary
        shippingAddressAddButton.titleLabel?.font = .medium12
        
        billingAddressAddButton.setTitle(Constants.addInvoiceAddressButton)
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
            SRSessionManager.shared.userBillingAddress = viewModel.getBillingAddress()
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
            SRSessionManager.shared.userDeliveryAddress = viewModel.getShippingAddress()
        }
        
        self.view.layoutIfNeeded()

        delegate?.isEnabledNextButton(enabled: !isShippingAddressEmpty && !isBillingAddressEmpty)
        
    }
    
    @IBAction func addShippingAddressButtonTapped() {
        sheetAddressBottomSheet(addressBottomSheetViewModel: SRAddressBottomSheetViewModel(type: .shipping))
    }
    
    @IBAction func addBillingAddressButtonTapped() {
        sheetAddressBottomSheet(addressBottomSheetViewModel: SRAddressBottomSheetViewModel(type: .billing))
    }
    
    private func sheetAddressBottomSheet(addressBottomSheetViewModel: SRAddressBottomSheetViewModel) {
        let addressBotttomSheetViewController = SRAddressBottomSheetViewController(viewModel: addressBottomSheetViewModel)
        addressBotttomSheetViewController.delegate = self
        self.sheet(addressBotttomSheetViewController)
    }
    
}

extension CheckOutAddressViewController: GeneralAddressDelegate {
    func editButtonTapped(type: GeneralAddressType) {
        switch type {
        case .shipping:
            sheetAddressBottomSheet(addressBottomSheetViewModel: SRAddressBottomSheetViewModel(type: type, isEditing: true, userShippingAddress: viewModel.getShippingAddress()))
        case .billing:
            sheetAddressBottomSheet(addressBottomSheetViewModel: SRAddressBottomSheetViewModel(type: type, isEditing: true, userBillingAddress: viewModel.getBillingAddress()))
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
        listPopUpVC.modalPresentationStyle = .popover
        listPopUpVC.addressDelegate = self
        popUp(listPopUpVC)
    }
}

extension CheckOutAddressViewController : AddressBottomViewDelegate {
    func saveButtonTapped(userShippingAddressModel: UserShippingAddressModel?, userBillingAddressModel: UserBillingAdressModel?, defaultAddressModel: SRDefaultAddressModel?) {
        if let userShippingAddressModel = userShippingAddressModel {
            viewModel.setAdresses(userShippingAddress: userShippingAddressModel)
        }
        if let userBillingAddressModel = userBillingAddressModel {
            viewModel.setAdresses(userBillingAddress: userBillingAddressModel)
        }
        
        if let defaultAddressModel = defaultAddressModel {
            viewModel.setDefaultAddress(defaultAddress: defaultAddressModel)
        } else {
            getDefaultAddress()
        }
        
        DispatchQueue.main.async {
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
        viewModel.setAdresses(userBillingAddress: billingAddress)
        SRSessionManager.shared.userBillingAddress = viewModel.getBillingAddress()
        configureViews()
    }
    
    func getShippingAddress(shippingAddress: UserShippingAddressModel?) {
        viewModel.setAdresses(userShippingAddress: shippingAddress)
        SRSessionManager.shared.userDeliveryAddress = viewModel.getShippingAddress()
        configureViews()
    }
}

extension CheckOutAddressViewController : EmptyViewAddressDelegate {
    
    func addAddressButtonClicked(type: GeneralAddressType?) {
        if let type = type {
            sheetAddressBottomSheet(addressBottomSheetViewModel: SRAddressBottomSheetViewModel(type: type))
        }
    }    
}
