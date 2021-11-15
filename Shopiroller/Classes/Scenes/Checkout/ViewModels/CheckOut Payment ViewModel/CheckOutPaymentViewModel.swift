//
//  CheckOutPaymentViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import Foundation

class CheckOutPaymentViewModel: BaseViewModel {
    
    private var paymentSettings : PaymentSettingsResponeModel?
    
    private var _selectedPayment: PaymentTypeEnum? = nil

    func getPaymentSettings(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getPaymentSettings().response() {
            (result) in
            switch result {
            case .success(let response):
                self.paymentSettings = response.data
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
    
    func getSupportedPaymentList() -> [SupportedPaymentType]? {
        return paymentSettings?.supportedPaymentTypes
    }
    
    func getDefaultPaymentMethod() -> PaymentTypeEnum? {
        if _selectedPayment == nil {
            _selectedPayment = paymentSettings?.supportedPaymentTypes?[0].paymentType
        }
        return _selectedPayment
    }
    
    func arePaymentSettingsEmpty() -> Bool {
        return paymentSettings?.supportedPaymentTypes?.isEmpty ?? true || paymentSettings?.supportedPaymentTypes?.count == 0
    }
    
    func getEmptyViewModel() -> EmptyModel {
        return EmptyModel(image: .emptyPaymentMethod, title:"checkout-payment-empty-view-title".localized, description:  "checkout-payment-empty-view-description".localized, button: nil)
    }
    
    
    var paymentType: PaymentTypeEnum? {
        set {
            _selectedPayment = newValue
        }
        get {
            return _selectedPayment
        }
    }
    

}
