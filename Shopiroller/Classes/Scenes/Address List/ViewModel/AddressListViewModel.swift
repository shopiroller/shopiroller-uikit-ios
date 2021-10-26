//
//  AddressListViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 25.10.2021.
//

import Foundation
import UIKit

class AddressListViewModel: BaseViewModel {
    
    var shippingAddresses: [UserShippingAddressModel]?
    var billingAddresses: [UserBillingAdressModel]?
    
    func getShippingAddresses(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getShippingAddresses(userId: SRAppConstants.Query.Values.userId).response() {
            (result) in
            switch result{
            case .success(let response):
                self.shippingAddresses = response.data
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
    
    func getBillingAddresses(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getBillingAddresses(userId: SRAppConstants.Query.Values.userId).response() {
            (result) in
            switch result{
            case .success(let response):
                self.billingAddresses = response.data
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
    
    func getShoppingCartCount(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRGlobalRequestManager.getShoppingCartCount(success: success, error: error)
    }
    
    func isListEmpty() -> Bool {
        return true
        return shippingAddresses?.isEmpty ?? true
    }
    
    func getShippingAddress(position: Int) -> UserShippingAddressModel? {
        //TODO: DELETE THİS LİNE
        let fakeAddress = UserShippingAddressModel()
        var contactModel = AddressContactModel()
        contactModel.email = "test@test.com"
        contactModel.phoneNumber = "05392476787"
        contactModel.nameSurname = "John Doe"
        fakeAddress.title = "fake Title"
        fakeAddress.city = "Antalya"
        fakeAddress.state = "Türkiye"
        fakeAddress.country = "Türkiye"
        fakeAddress.description = "Adres"
        fakeAddress.id = "id"
        fakeAddress.zipCode = "07700"
        fakeAddress.contact = contactModel
      
        return fakeAddress
        
        return shippingAddresses?[position]
    }
    
    func getBillingAddress(position: Int) -> UserBillingAdressModel? {
        return billingAddresses?[position]
    }
    
    func getEmptyModel() -> EmptyModel {
        return EmptyModel(image: .emptyShippingAddresses, title: "address_list_empty_shipping_title".localized, description: "address_list_empty_shipping_description".localized, button: nil)
    }
}
