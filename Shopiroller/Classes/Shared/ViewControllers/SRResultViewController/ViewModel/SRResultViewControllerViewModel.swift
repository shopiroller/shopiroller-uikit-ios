//
//  SRResultViewControllerViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 22.11.2021.
//

import Foundation

class SRResultViewControllerViewModel : SRBaseViewModel {
    
    private let orderResponse: SROrderResponseInnerModel?
    
    private let type: OrderResultType?
    
    private let errorMessage: String?
    
    init (type: OrderResultType? = nil, orderResponse: SROrderResponseInnerModel? = nil,errorMessage: String? = nil) {
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
            errorMessageAttributedText = String().makeBoldString(boldText: String(format: "e_commerce_result_credit_card_failed_title".localized, String.NEW_LINE), normalText: String(format: "e_commerce_result_failed_description".localized + "(" + errorMessage.replacingOccurrences(of: "e_commerce_result_fail_detail_description_will_replace".localized, with: "e_commerce_result_fail_detail_description_to_replace".localized) + ")"),isReverse: false)
        } else {
            errorMessageAttributedText = String().makeBoldString(boldText: String(format: "e_commerce_result_credit_card_failed_title".localized, String.NEW_LINE), normalText: String(format: "e_commerce_result_credit_card_failed_title".localized),isReverse: false)
        }
        return errorMessageAttributedText
    }
    
    func isErrorMessageEmpty() -> Bool {
        return errorMessage?.isEmpty ?? true
    }
    
}

enum OrderResultType {
    case success
    case fail
}
