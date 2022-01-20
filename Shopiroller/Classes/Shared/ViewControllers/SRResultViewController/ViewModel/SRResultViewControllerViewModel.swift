//
//  SRResultViewControllerViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 22.11.2021.
//

import Foundation

class SRResultViewControllerViewModel : BaseViewModel {
    
    private let orderResponse: SROrderResponseInnerModel?
    
    private let type: OrderResultType?
    
    private let errorMessage: String?
    
    init (type: OrderResultType? = nil, orderResponse: SROrderResponseInnerModel?,errorMessage: String? = nil) {
        self.type = type
        self.orderResponse = orderResponse
        self.errorMessage = errorMessage
    }
    
    func getType() -> OrderResultType? {
        return type
    }
    
    func getOrderNumber() -> String {
        return orderResponse?.order?.orderCode ?? ""
    }
    
    func getFormattedErrorMesage() -> NSAttributedString {
        var errorMessageAttributedText : NSAttributedString = NSAttributedString()
        if let errorMessage = errorMessage , errorMessage != "" {
            errorMessageAttributedText = String().makeBoldString(boldText: String(format: "checkout-result-info-fail-message".localized, String.NEW_LINE), normalText: String(format: "checkout-result-info-fail-description".localized + "(" + errorMessage.replacingOccurrences(of: "checkout-result-info-fail-detail-description-will-replace".localized, with: "checkout-result-info-fail-detail-description-to-replace".localized) + ")"),isReverse: false)
        } else {
            errorMessageAttributedText = String().makeBoldString(boldText: String(format: "checkout-result-info-fail-message".localized, String.NEW_LINE), normalText: String(format: "checkout-result-info-fail-detail-description".localized),isReverse: false)
        }
        return errorMessageAttributedText
    }
    
}

enum OrderResultType {
    case success
    case fail
}
