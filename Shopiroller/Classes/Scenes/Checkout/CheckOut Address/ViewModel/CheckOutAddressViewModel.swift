//
//  CheckOutAddressViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import Foundation


class CheckOutAddressViewModel: BaseViewModel {
    
    private var defaultAdressList: SRDefaultAddressModel?
    
    private var _selectedShippingAddress: UserShippingAddressModel?
    
    private var _selectedBillingAddress: UserBillingAdressModel?
    
    private var userShippingAddressList : [UserShippingAddressModel]?
    
    private var userBillingAddressList : [UserBillingAdressModel]?
    
    func getDefaultAddress(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getDefaultAddress(userId: SRAppContext.userId).response() {
            (result) in
            switch result {
            case .success(let response):
                self.defaultAdressList = response.data
                self.getShippingAddress()
                self.getBillingAddress()
                DispatchQueue.main.async {
                    success?()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    func getDeliveryAddressModel() -> GeneralAddressModel {
        return GeneralAddressModel(title: _selectedShippingAddress?.title, address: _selectedShippingAddress?.addressLine, description: _selectedShippingAddress?.getDescriptionArea(), type: .shipping, isEmpty: isShippingAddressEmpty())
    }
    
    func getBillingAddressModel() -> GeneralAddressModel {
        return GeneralAddressModel(title: _selectedBillingAddress?.title, address: _selectedBillingAddress?.addressLine, description: _selectedBillingAddress?.getDescriptionArea(), type: .billing, isEmpty: isBillingAddressEmpty())
    }
    
    
    func getShippingEmptyModel() -> EmptyModel {
        return EmptyModel(image: .emptyShippingAddresses, title: "address_list_empty_shipping_title".localized,description: nil, button: ButtonModel(title: "add-address-button-text".localized, color: .textPrimary))
    }
    
    func getBillingEmptyModel() -> EmptyModel {
        return EmptyModel(image: .emptyBillingAddresses, title: "address_list_empty_billing_title".localized,description: nil, button: ButtonModel(title: "add-address-button-text".localized, color: .textPrimary))
    }
    
    func getShippingAddress() -> UserShippingAddressModel? {
        if _selectedShippingAddress == nil {
            _selectedShippingAddress = defaultAdressList?.shippingAddress
        }
        return _selectedShippingAddress
    }
    
    func getBillingAddress() -> UserBillingAdressModel? {
        if _selectedBillingAddress == nil {
            _selectedBillingAddress = defaultAdressList?.billingAddress
        }
        return _selectedBillingAddress
    }
    
    func isShippingAddressEmpty() -> Bool {
        return defaultAdressList?.shippingAddress == nil
    }
    
    func isBillingAddressEmpty() -> Bool {
        return defaultAdressList?.billingAddress == nil
    }
    
    var selectedShippingAddress: UserShippingAddressModel? {
        set {
            _selectedShippingAddress = newValue
        }
        get {
            return _selectedShippingAddress
        }
    }
    
    var selectedBillingAddress: UserBillingAdressModel? {
        set {
            _selectedBillingAddress = newValue
        } get {
            return _selectedBillingAddress
        }
    }
    
    func getAddressList(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        getShippingAddressList(success: success, error: error)
        getBillingAddressList(success: success, error: error)
        
    }
    
    private func getShippingAddressList(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getShippingAddresses(userId: SRAppContext.userId).response() {
            (result) in
            switch result{
            case .success(let response):
                self.userShippingAddressList = response.data
                DispatchQueue.main.async {
                    success?()
                }
            case.failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    private func getBillingAddressList(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getBillingAddresses(userId: SRAppContext.userId).response() {
            (result) in
            switch result{
            case .success(let response):
                self.userBillingAddressList = response.data
                DispatchQueue.main.async {
                    success?()
                }
            case.failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    func getUserBillingAddressList() -> [UserBillingAdressModel]? {
        return userBillingAddressList
    }
    
    func getUserShippingAddressList() -> [UserShippingAddressModel]? {
        return userShippingAddressList
    }
}
