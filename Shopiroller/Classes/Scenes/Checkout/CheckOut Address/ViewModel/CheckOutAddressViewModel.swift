//
//  CheckOutAddressViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import Foundation


class CheckOutAddressViewModel: SRBaseViewModel {
    
    private var defaultAdressList: SRDefaultAddressModel?
    
    private var shippingAddressModel: UserShippingAddressModel?
    
    private var billingAddressModel: UserBillingAdressModel?
    
    private var userShippingAddressList : [UserShippingAddressModel]?
    
    private var userBillingAddressList : [UserBillingAdressModel]?
    
    func getDefaultAddress(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getDefaultAddress(userId: SRAppContext.userId).response() {
            (result) in
            switch result {
            case .success(let response):
                self.defaultAdressList = response.data
                self.setDefaultAddresses()
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
        return GeneralAddressModel(title: shippingAddressModel?.title, address: shippingAddressModel?.addressLine, description: shippingAddressModel?.getDescriptionArea(), type: .shipping, isEmpty: isShippingAddressEmpty())
    }
    
    func getBillingAddressModel() -> GeneralAddressModel {
        return GeneralAddressModel(title: billingAddressModel?.title, address: billingAddressModel?.addressLine, description: billingAddressModel?.getDescriptionArea(), type: .billing, isEmpty: isBillingAddressEmpty())
    }
    
    
    func getShippingEmptyModel() -> EmptyModel {
        return EmptyModel(image: .emptyShippingAddresses, title: "e_commerce_address_selection_no_shipping_address_title".localized,description: "e_commerce_address_selection_no_shipping_address_description".localized, button: ButtonModel(title: "e_commerce_address_selection_no_shipping_address_button".localized, color: .textPrimary))
    }
    
    func getBillingEmptyModel() -> EmptyModel {
        return EmptyModel(image: .emptyBillingAddresses, title: "e_commerce_address_selection_no_invoice_address_title".localized,description: "e_commerce_address_selection_no_invoice_address_description".localized, button: ButtonModel(title: "e_commerce_address_selection_no_invoice_address_button".localized, color: .textPrimary))
    }
    
    private func setDefaultAddresses() {
        if shippingAddressModel == nil {
            shippingAddressModel = defaultAdressList?.shippingAddress
        }
        
        if billingAddressModel == nil {
            billingAddressModel = defaultAdressList?.billingAddress
        }
        
    }
    
    func getShippingAddress() -> UserShippingAddressModel? {
        return shippingAddressModel
    }
    
    func getBillingAddress() -> UserBillingAdressModel? {
        return billingAddressModel
    }
    
    func isShippingAddressEmpty() -> Bool {
        return defaultAdressList?.shippingAddress == nil
    }
    
    func isBillingAddressEmpty() -> Bool {
        return defaultAdressList?.billingAddress == nil
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
    
    func setDefaultAddress(defaultAddress: SRDefaultAddressModel) {
        defaultAdressList = defaultAddress
        billingAddressModel = defaultAddress.billingAddress
        shippingAddressModel = defaultAddress.shippingAddress
    }
    
    func setAdresses(userShippingAddress: UserShippingAddressModel? = nil , userBillingAddress: UserBillingAdressModel? = nil) {
        if let userBillingAddress = userBillingAddress {
            billingAddressModel = userBillingAddress
        } else if let userShippingAddress = userShippingAddress {
            shippingAddressModel = userShippingAddress
        }
    }
}
