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
    
    func geterrorMessage() -> String? {
        return errorMessage
    }
    
}

enum OrderResultType {
    case success
    case fail
}
