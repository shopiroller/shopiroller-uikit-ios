//
//  AddressListViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 25.10.2021.
//

import Foundation
import UIKit

class AddressListViewModel: SRBaseViewModel {
    
    let state: AddressStateEnum
    private var shippingAddressList: [UserShippingAddressModel]?
    private var billingAddressList: [UserBillingAdressModel]?
    var selectedIndexPathRow: Int?
    
    init(state: AddressStateEnum){
        self.state = state
    }
    
    func getAddressList(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        switch state {
        case .shipping:
            getShippingAddressList(success: success, error: error)
        case .billing:
            getBillingAddressList(success: success, error: error)
        }
    }
    
    private func getShippingAddressList(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getShippingAddresses(userId: SRAppContext.userId).response() {
            (result) in
            switch result{
            case .success(let response):
                self.shippingAddressList = response.data
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
                self.billingAddressList = response.data
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
    
    func deleteAddress(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        switch state {
        case .shipping:
            deleteShippingAddress(success: success, error: error)
        case .billing:
            deleteBillingAddress(success: success, error: error)
        }
    }
    
    private func deleteShippingAddress(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        guard let index = selectedIndexPathRow, let addressId = shippingAddressList?[index].id else { return }
        
        SRNetworkManagerRequests.deleteShippingAddress(userId: SRAppContext.userId, addressId: addressId).response() {
            (result) in
            switch result{
            case .success(_):
                self.shippingAddressList?.remove(at: index)
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
    
    private func deleteBillingAddress(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        guard let index = selectedIndexPathRow, let addressId = billingAddressList?[index].id else { return }
        
        SRNetworkManagerRequests.deleteBillingAddress(userId: SRAppContext.userId, addressId: addressId).response() {
            (result) in
            switch result{
            case .success(_):
                self.billingAddressList?.remove(at: index)
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
    
    func isListEmpty() -> Bool {
        switch state {
        case .shipping:
            return shippingAddressList?.isEmpty ?? true
        case .billing:
            return billingAddressList?.isEmpty ?? true
        }
    }
    
    func getListSize() -> Int {
        switch state {
        case .shipping:
            return shippingAddressList?.count ?? 0
        case .billing:
            return billingAddressList?.count ?? 0
        }
    }
    
    func getShippingAddress(position: Int) -> UserShippingAddressModel? {
        return shippingAddressList?[position]
    }
    
    func getBillingAddress(position: Int) -> UserBillingAdressModel? {
        return billingAddressList?[position]
    }
    
    func getEmptyModel() -> EmptyModel {
        switch state {
        case .shipping:
            return getShippingEmptyModel()
        case .billing:
            return getBillingEmptyModel()
        }
    }
    
    private func getShippingEmptyModel() -> EmptyModel {
        return EmptyModel(image: .emptyShippingAddresses, title: "e_commerce_address_selection_no_shipping_address_title".localized, description: "e_commerce_address_selection_no_shipping_address_description".localized, button: nil)
    }
    
    private func getBillingEmptyModel() -> EmptyModel {
        return EmptyModel(image: .emptyBillingAddresses, title: "e_commerce_address_selection_no_invoice_address_title".localized, description: "e_commerce_address_selection_no_invoice_address_description".localized, button: nil)
    }
}

enum AddressStateEnum {
    case shipping, billing
}
