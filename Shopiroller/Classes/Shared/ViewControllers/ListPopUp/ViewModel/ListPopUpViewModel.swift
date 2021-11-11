//
//  ListPopUpViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 9.11.2021.
//

import Foundation

class ListPopUpViewModel: BaseViewModel {
    private var listType: ListType
    private var userShippingAddressList : [UserShippingAddressModel]?
    private var userBillingAddressList : [UserBillingAdressModel]?
    private var addressType: GeneralAddressType
    
    init(listType: ListType, userShippingAddressList : [UserShippingAddressModel]? = nil, userBillingAddressList: [UserBillingAdressModel]? = nil,
         addressType: GeneralAddressType){
        self.listType = listType
        self.userShippingAddressList = userShippingAddressList
        self.userBillingAddressList = userBillingAddressList
        self.addressType = addressType
    }
    
    func getListType() -> ListType {
        return listType
    }
    
    func getAddressType() -> GeneralAddressType {
        return addressType
    }
    
    func getAddressList(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        switch addressType {
        case .shipping:
            getShippingAddressList(success: success, error: error)
        case .billing:
            getBillingAddressList(success: success, error: error)
        }
    }
    
    func getItemCount() -> Int {
        switch listType {
        case .payment:
            return 0
        case .shoppingCart:
            return 0
        case .address:
            switch addressType {
            case .shipping:
                return userShippingAddressList?.count ?? 0
            case .billing:
                return userBillingAddressList?.count ?? 0
        }
        }
    }
    
    func getShippingAddress(position: Int) -> UserShippingAddressModel? {
        return userShippingAddressList?[position]
    }
    
    func getBillingAddress(position: Int) -> UserBillingAdressModel? {
        return userBillingAddressList?[position]
    }
    
    private func getShippingAddressList(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getShippingAddresses(userId: SRAppConstants.Query.Values.userId).response() {
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
        SRNetworkManagerRequests.getBillingAddresses(userId: SRAppConstants.Query.Values.userId).response() {
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
    
}

enum ListType {
    case payment
    case shoppingCart
    case address
}
