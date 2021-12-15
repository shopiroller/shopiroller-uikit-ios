//
//  ListPopUpViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 9.11.2021.
//

import Foundation
import UIKit

class ListPopUpViewModel: BaseViewModel {
    private var listType: ListType
    private var userShippingAddressList : [UserShippingAddressModel]?
    private var userBillingAddressList : [UserBillingAdressModel]?
    private var addressType: GeneralAddressType?
    private var supportedPaymentMethods: [SupportedPaymentType]?
    private var sortTitles : [String] = ["sort_dialog_most_shipped".localized,"sort_dialog_price_increasing".localized,"sort_dialog_price_decreasing".localized,"sort_dialog_most_recent_added".localized]
    var selectedIndex: Int? = 0
    
    
    init(listType: ListType, userShippingAddressList : [UserShippingAddressModel]? = nil, userBillingAddressList: [UserBillingAdressModel]? = nil,
         addressType: GeneralAddressType? = nil,supportedPaymentMethods: [SupportedPaymentType]? = nil, selectedSortIndex: Int? = 0){
        self.listType = listType
        self.userShippingAddressList = userShippingAddressList
        self.userBillingAddressList = userBillingAddressList
        self.addressType = addressType
        self.supportedPaymentMethods = supportedPaymentMethods
        self.selectedIndex = selectedSortIndex
    }
    
    func getListType() -> ListType {
        return listType
    }
    
    func getAddressType() -> GeneralAddressType {
        return addressType ?? .shipping
    }
    
    func getAddressList(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        switch addressType {
        case .shipping:
            getShippingAddressList(success: success, error: error)
        case .billing:
            getBillingAddressList(success: success, error: error)
        case .none:
            break
        }
    }
 
    
    func getItemCount() -> Int {
        switch listType {
        case .payment:
            return supportedPaymentMethods?.count ?? 0
        case .shoppingCart:
            return 0
        case .address:
            switch addressType {
            case .shipping:
                return userShippingAddressList?.count ?? 0
            case .billing:
                return userBillingAddressList?.count ?? 0
            case .none:
                return 0
            }
        case .sortList:
            return sortTitles.count
        }
    }
    
    func getShippingAddress(position: Int) -> UserShippingAddressModel? {
        return userShippingAddressList?[position]
    }
    
    func getBillingAddress(position: Int) -> UserBillingAdressModel? {
        return userBillingAddressList?[position]
    }
    
    func getSupportedMethods(position: Int) -> SupportedPaymentType? {
        return supportedPaymentMethods?[position]
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
    
    func getSortListModel(position: Int?) -> String {
        return sortTitles[position ?? 0]
    }
    
}

enum ListType {
    case payment
    case shoppingCart
    case address
    case sortList
}
