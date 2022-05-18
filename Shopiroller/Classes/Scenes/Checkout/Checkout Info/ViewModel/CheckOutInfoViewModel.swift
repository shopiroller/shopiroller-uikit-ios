//
//  CheckOutInfoViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import Foundation

class CheckOutInfoViewModel: SRBaseViewModel {
    
    private var shoppingCart: SRShoppingCartResponseModel?
        
    var makeOrder: SRMakeOrderResponse? = SRMakeOrderResponse()
    
    var isOrderNoteChanged: Bool = false
    
    private var _isAgreeTermsButtonChecked : Bool = false
    
    func getShoppingCart(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getShoppingCart(userId: SRAppContext.userId,showProgress: false).response() {
            (result) in
            switch result {
            case .success(let result):
                self.shoppingCart = result.data
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
    
    func getUpdateCardPopUpModel() -> PopUpViewModel {
        return PopUpViewModel(image: UIImage(systemName: "pencil")!, title: "e_commerce_order_summary_update_order_popup_title".localized, description: String(format: "e_commerce_order_summary_update_order_popup_description".localized, String.NEW_LINE), firstButton: PopUpButtonModel(title: "e_commerce_order_summary_update_order_popup_button".localized, type: .darkButton), secondButton: nil)
    }
    
    func getCardDescription() -> String {
        return String(format: "e_commerce_order_summary_cart_description".localized, String(shoppingCart?.items?.count ?? 0) as CVarArg ,
        String.NEW_LINE, String(ECommerceUtil.getFormattedPrice(price: shoppingCart?.totalPrice, currency: shoppingCart?.currency)))
    }
    
    func getBottomPriceModel() -> BottomPriceModel {
        return BottomPriceModel(subTotalPrice: (shoppingCart?.totalPrice ?? 0) - (shoppingCart?.shippingPrice ?? 0), shippingPrice: shoppingCart?.shippingPrice, totalPrice: shoppingCart?.totalPrice, currency: shoppingCart?.currency)
    }
    
    func getTrasnferToBankDescriptonText() -> String {
        return String(format: "e_commerce_order_summary_bank_transfer_description".localized, String.NEW_LINE, SRSessionManager.shared.orderEvent.bankAccount?.accountToString as! CVarArg)
    }
    
    func getCreditCardDescription() -> String {
        return String(format: "e_commerce_order_summary_credit_cart_description".localized, String.NEW_LINE,
            SRSessionManager.shared.orderEvent.orderCard.cardNumber?.substring(fromIndex: 12) as! CVarArg)
    }
    
    func getAgreementCheckPopUpModel() -> PopUpViewModel {
        return PopUpViewModel(image: .validateCart, title: "e_commerce_order_summary_agreement_popup_title".localized, description: "e_commerce_order_summary_agreement_popup_description".localized, firstButton: PopUpButtonModel(title: "e_commerce_order_summary_agreement_popup_button".localized, type: .darkButton), secondButton: nil)
    }
    
    func isInvalidItemsAvailable() -> Bool {
        return shoppingCart?.invalidItems != nil && shoppingCart?.invalidItems?.count != 0
    }
    
    func isPaymentSettingsEmpty() -> Bool {
        return SRSessionManager.shared.paymentSettings == nil
    }
    
    func getPaymentSettings(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getPaymentSettings().response() {
            (result) in
            switch result {
            case .success(let response):
                SRSessionManager.shared.paymentSettings = response.data
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
    
    func getTermsLink() -> String {
        return SRSessionManager.shared.paymentSettings?.distanceSalesContract ?? ""
    }
    
    func sendOrder(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.makeOrder(makeOrder ?? SRMakeOrderResponse(), userId: SRAppContext.userId,showProgress: false).response() {
            (result) in
            switch result {
            case .success(let response):
                SRSessionManager.shared.orderResponseInnerModel = response.data
                SRSessionManager.shared.makeOrder?.orderId = response.data?.order?.id
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
    
    func tryAgainOrder(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.tryAgain(SRSessionManager.shared.makeOrder?.getCompleteOrderModel() ?? CompleteOrderModel()).response() {
            (result) in
            switch result {
            case .success(let response):
                SRSessionManager.shared.orderResponseInnerModel = response.data
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
    
    
    var isAgreeTermsButtonChecked: Bool {
        set {
            _isAgreeTermsButtonChecked = newValue
        } get {
            return _isAgreeTermsButtonChecked
        }
    }
    
    func isValid() -> Bool {
        return isAgreeTermsButtonChecked
    }
    
    func setMakeOrderBuyerModel() {
        let names : [String] = SRSessionManager.shared.userBillingAddress?.contact?.nameSurname?.components(separatedBy: " ") ?? []
        if names.count != 0 {
            makeOrder?.buyer.name = names[0]
            makeOrder?.buyer.surname = ""
            if names.count > 1 {
                for i in 1..<(names.count) {
                    if (i == 1) {
                        makeOrder?.buyer.surname? += names[i]
                    } else {
                        makeOrder?.buyer.surname? += " " + names[i]
                    }
                }
            }
        }
    }
}
