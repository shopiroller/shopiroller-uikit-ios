//
//  CheckOutPaymentViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import Foundation

class CheckOutPaymentViewModel: SRBaseViewModel {
    
    private struct Constants {
        
        static var creditCardEmptyError: String { return "e_commerce_payment_credit_card_validation_empty".localized }
        
        static var creditCardValidationError: String { return "e_commerce_payment_credit_card_validation_invalid".localized }
        
        static var creditCardNumberText: String { return "e_commerce_payment_credit_card_number".localized }
        
        static var creditCardHolderText: String { return "e_commerce_payment_credit_card_name".localized }
        
        static var creditCardExpireDateText: String { return "e_commerce_payment_credit_card_expire_date".localized }
        
        static var creditCardCVVText: String { return "e_commerce_payment_credit_card_security_code".localized }
        
    }
    
    private var paymentSettings : PaymentSettingsResponeModel?
    
    private var _selectedPayment: PaymentTypeEnum?
    
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
        return EmptyModel(image: .emptyPaymentMethod, title:"e_commerce_payment_method_selection_empty_view_title".localized, description:  "e_commerce_payment_method_selection_empty_view_description".localized, button: nil)
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
    
    func isValidCreditCardHolder(error: ((ErrorViewModel) -> Void)? = nil) -> Bool {
        if let fullName = creditCardHolder, fullName.isValidFullName {
            return true
        } else if (creditCardHolder == nil || creditCardHolder == "")  {
            error?(ErrorViewModel.validationError(message: String(format: Constants.creditCardEmptyError, Constants.creditCardHolderText)))
        } else {
            error?(ErrorViewModel.validationError(message: String(format: Constants.creditCardValidationError, Constants.creditCardHolderText)))
        }
        return false
    }
    
    func isValidCreditCardExpireDate(error: ((ErrorViewModel) -> Void)? = nil) -> Bool {
        if let creditCardExpireYear = creditCardExpireYear , creditCardExpireYear.count == 2 {
            return true
        } else if let creditCardExpireMonth = creditCardExpireMonth ,creditCardExpireMonth.count == 2 {
            return true
        } else if ((creditCardExpireYear == nil || creditCardExpireYear == "") || (creditCardExpireMonth == nil || creditCardExpireMonth == "")) {
            error?(ErrorViewModel.validationError(message: String(format: Constants.creditCardEmptyError, Constants.creditCardExpireDateText)))
        }
        return false
    }
    
    func isValidCreditCardNumber(error: ((ErrorViewModel) -> Void)? = nil) -> Bool  {
        if let cardNumber = creditCardNumber, cardNumber.isValidCreditCardNumber && (CreditCardHelper.validateCardNumber(str: cardNumber) == true) {
            return true
        } else if (creditCardNumber == nil || creditCardNumber == "") {
            error?(ErrorViewModel.validationError(
                message: String(format: Constants.creditCardEmptyError,
                                Constants.creditCardNumberText)))
        } else {
            error?(ErrorViewModel.validationError(
                message: String(format: Constants.creditCardValidationError,
                                Constants.creditCardNumberText)))
        }
        return false
    }
    
    func isValidCreditCardCvv(error: ((ErrorViewModel) -> Void)? = nil) -> Bool  {
        if let cvv = creditCardCvv , cvv.isValidCreditCardCvv {
            return true
        } else if (creditCardCvv == nil || creditCardCvv == "") {
            error?(ErrorViewModel.validationError(
                message: String(format: Constants.creditCardEmptyError,
                                Constants.creditCardCVVText)))
        } else {
            error?(ErrorViewModel.validationError(
                message: String(format: Constants.creditCardValidationError,
                                Constants.creditCardCVVText)))
        }
        return false
    }
    
    func getPaymentDescription() -> String? {
        var description : String? = ""
        if let paymentSettings = paymentSettings {
            paymentSettings.supportedPaymentTypes?.forEach {
                if ($0.paymentType == _selectedPayment) {
                    description = $0.description
                }
            }
        }
        return description
    }
    
}
