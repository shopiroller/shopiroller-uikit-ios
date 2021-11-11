//
//  CheckOutPaymentViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import Foundation

class CheckOutPaymentViewModel: BaseViewModel {
    
    private var paymentSettings : PaymentSettingsResponeModel?

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
    
    func getPaymentSettingsList() -> PaymentSettingsResponeModel? {
        return paymentSettings
    }
    
    func getDefaultPaymentMethod() -> PaymentTypeEnum? {
        return paymentSettings?.supportedPaymentTypes?[0].paymentType
    }
    
    func arePaymentSettingsEmpty() -> Bool {
        return paymentSettings?.supportedPaymentTypes?.isEmpty ?? true || paymentSettings?.supportedPaymentTypes?.count == 0
    }
    
    func getEmptyViewModel() -> EmptyModel {
        return EmptyModel(image: .emptyPaymentMethod, title:"checkout-payment-empty-view-title".localized, description:  "checkout-payment-empty-view-description".localized, button: nil)
    }
    
    

}
