//
//  ListPopUpViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 9.11.2021.
//

import Foundation
import UIKit

class SRListPopUpViewModel: SRBaseViewModel {
    private var listType: ListType
    private var userShippingAddressList : [UserShippingAddressModel]?
    private var userBillingAddressList : [UserBillingAdressModel]?
    private var addressType: GeneralAddressType?
    private var supportedPaymentMethods: [SupportedPaymentType]?
    private var sortTitles : [String] = ["e_commerce_category_product_list_order_dialog_most_shipped".localized,"e_commerce_category_product_list_order_dialog_price_increasing".localized,"e_commerce_category_product_list_order_dialog_price_decreasing".localized,"e_commerce_category_product_list_order_dialog_most_recent_added".localized]
    var sortOptionsSelectedIndex: Int? = 0
    
    
    init(listType: ListType, userShippingAddressList : [UserShippingAddressModel]? = nil, userBillingAddressList: [UserBillingAdressModel]? = nil,
         addressType: GeneralAddressType? = nil,supportedPaymentMethods: [SupportedPaymentType]? = nil, selectedSortIndex: Int? = 0) {
        self.listType = listType
        self.userShippingAddressList = userShippingAddressList
        self.userBillingAddressList = userBillingAddressList
        self.addressType = addressType
        self.supportedPaymentMethods = supportedPaymentMethods
        self.sortOptionsSelectedIndex = selectedSortIndex
    }
    
    func getListType() -> ListType {
        return listType
    }
    
    func getAddressType() -> GeneralAddressType {
        return addressType ?? .shipping
    }
    
    func getItemCount() -> Int {
        switch listType {
        case .payment:
            return supportedPaymentMethods?.count ?? 0
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
    
    func getItemHeight() -> Float {
        switch listType {
        case .payment:
            return 65
        case .address:
            return 105
        case .sortList:
            return 65
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
    
    func getSortListModel(position: Int?) -> String {
        return sortTitles[position ?? 0]
    }
    
}

enum ListType {
    case payment
    case address
    case sortList
}
