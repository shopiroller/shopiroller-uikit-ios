//
//  CheckOutAddressViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import Foundation


class CheckOutAddressViewModel: BaseViewModel {
    
    private var defaultAdressList: SRDefaultAddressModel?
    
    private var userBillingAddress: UserBillingAdressModel?
     
    private var userShippingAddress: UserShippingAddressModel?
    
    func getDefaultAddress(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getDefaultAddress(userId: SRAppConstants.Query.Values.userId).response() {
            (result) in
            switch result {
            case .success(let response):
                self.defaultAdressList = response.data
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
        return GeneralAddressModel(title: defaultAdressList?.shippingAddress?.title, address: defaultAdressList?.shippingAddress?.addressLine, description: defaultAdressList?.shippingAddress?.getDescriptionArea(), type: .shipping, isEmpty: isShippingAddressEmpty())
    }
    
    func getBillingAddressModel() -> GeneralAddressModel {
        return GeneralAddressModel(title: defaultAdressList?.billingAddress?.title, address: defaultAdressList?.billingAddress?.addressLine, description: defaultAdressList?.billingAddress?.getDescriptionArea(), type: .billing, isEmpty: isBillingAddressEmpty())
    }
    
    
    func getShippingEmptyModel() -> EmptyModel {
        return EmptyModel(image: .emptyShippingAddresses, title: "address_list_empty_shipping_title".localized,description: nil, button: nil)
    }
    
    func getBillingEmptyModel() -> EmptyModel {
        return EmptyModel(image: .emptyBillingAddresses, title: "address_list_empty_billing_title".localized,description: nil, button: nil)
    }
    
    func getShippingAddress() -> UserShippingAddressModel? {
        userShippingAddress = defaultAdressList?.shippingAddress
        return userShippingAddress
    }
    
    func getBillingAddress() -> UserBillingAdressModel? {
        userBillingAddress = defaultAdressList?.billingAddress
        return userBillingAddress
    }
    
    func isShippingAddressEmpty() -> Bool {
        return defaultAdressList?.shippingAddress == nil
    }
    
    func isBillingAddressEmpty() -> Bool {
        return defaultAdressList?.billingAddress == nil
    }
    
    func setBillingAddress(billingAddress: UserBillingAdressModel?) {
        userBillingAddress = billingAddress
    }
    
    func setShippingAddress(shippingAddress: UserShippingAddressModel?) {
        userShippingAddress = shippingAddress
    }
    
}
