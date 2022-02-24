//
//  CheckOutPaymentViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import Foundation

class CheckOutPaymentViewModel: SRBaseViewModel {
    
    private struct Constants {
        
        static var creditCardNumberErrorText: String { return "credit-card-number-error-text".localized }
        
        static var creditCardHolderErrorText: String { return "credit-card-holder-error-text".localized }
        
        static var creditCardExpireDateErrorText: String { return "credit-card-expire-date-error-text".localized }
        
        static var creditCardCvvText: String { return "credit-card-cvv-error-text".localized }
    }
    
    private var paymentSettings : PaymentSettingsResponeModel?
    
    private var _selectedPayment: PaymentTypeEnum? = nil
        
    var selectedBankIndex: Int?
    
    var isSelected: Bool = false

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
    
    func setDefaultBillingAddress(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.setDefaultBillingAddress(SRAppContext.userId, addressId: SRSessionManager.shared.userBillingAddress?.id ?? "", userBillingAddress: SRSetDefaultAddressRequest()).response() {
            (result) in
            switch result {
            case .success(_):
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
    
    func setDefaultShippingAddress(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.setDefaultShippingaddress(SRAppContext.userId, addressId: SRSessionManager.shared.userDeliveryAddress?.id ?? "", userShippingAddress: SRSetDefaultAddressRequest()).response() {
            (result) in
            switch result {
            case .success(_):
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
    
    func getBankAccountCount() -> Int? {
        return paymentSettings?.paymentAccounts?.count ?? 0
    }
    
    func getBankAccountModel(position: Int) -> BankAccountModel? {
        return paymentSettings?.paymentAccounts?[position]
    }
    
    func getPaymentSettings() -> PaymentSettingsResponeModel? {
        return paymentSettings
    }
    
    
    var paymentType: PaymentTypeEnum? {
        set {
            _selectedPayment = newValue
        }
        get {
            return _selectedPayment
        }
    }
    
    var creditCardHolder: String? {
        set {
            SRSessionManager.shared.orderEvent.orderCard.cardHolderName = newValue
        }
        get {
            return  SRSessionManager.shared.orderEvent.orderCard.cardHolderName
        }
    }
    
    var creditCardNumber: String? {
        set {
            SRSessionManager.shared.orderEvent.orderCard.cardNumber = newValue
        }
        get {
            return SRSessionManager.shared.orderEvent.orderCard.cardNumber
        }
    }
    
    var creditCardExpireYear: String? {
        set {
            SRSessionManager.shared.orderEvent.orderCard.expireYear = newValue
        }
        get {
            return SRSessionManager.shared.orderEvent.orderCard.expireYear
        }
    }
    
    var creditCardExpireMonth: String? {
        set {
            SRSessionManager.shared.orderEvent.orderCard.expireMonth = newValue
        }
        get {
            return SRSessionManager.shared.orderEvent.orderCard.expireMonth
        }
    }
    
    var creditCardCvv: String? {
        set {
            SRSessionManager.shared.orderEvent.orderCard.cvc = newValue
        }
        get {
            return SRSessionManager.shared.orderEvent.orderCard.cvc
        }
    }
    
    //MARK: Validation
    
    func isValid(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        if(isValidCreditCardHolder(error: error) && isValidCreditCardNumber(error: error) &&
            isValidCreditCardExpireDate(error: error) && isValidCreditCardCvv(error: error)) {
            success?()
        }
    }
    
    private func isValidCreditCardHolder(error: ((ErrorViewModel) -> Void)? = nil) -> Bool {
        if let fullName = creditCardHolder, fullName.isValidFullName {
            return true
        }
        error?(ErrorViewModel.validationError(message: Constants.creditCardHolderErrorText))
        return false
    }
    
    private func isValidCreditCardExpireDate(error: ((ErrorViewModel) -> Void)? = nil) -> Bool {
        if let creditCardExpireYear = creditCardExpireYear , creditCardExpireYear.count == 2 {
            return true
        } else if let creditCardExpireMonth = creditCardExpireMonth , creditCardExpireMonth.count == 2 {
            return true
        }
        error?(ErrorViewModel.validationError(message: Constants.creditCardExpireDateErrorText))
        return false
    }
    
    private func isValidCreditCardNumber(error: ((ErrorViewModel) -> Void)? = nil) -> Bool  {
        if let cardNumber = creditCardNumber, cardNumber.isValidCreditCardNumber && (CreditCardHelper.validateCardNumber(str: cardNumber) == true) {
            return true
        }
        error?(ErrorViewModel.validationError(message: Constants.creditCardNumberErrorText))
        return false
    }
    
    private func isValidCreditCardCvv(error: ((ErrorViewModel) -> Void)? = nil) -> Bool  {
        if let cvv = creditCardCvv, cvv.isValidCreditCardCvv {
            return true
        }
        error?(ErrorViewModel.validationError(message: Constants.creditCardCvvText))
        return false
    }

}
