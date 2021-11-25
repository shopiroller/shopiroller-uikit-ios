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
    
    init (type: OrderResultType? = nil, orderResponse: SROrderResponseInnerModel?) {
        self.type = type
        self.orderResponse = orderResponse
    }
    
    func getType() -> OrderResultType? {
        return type
    }
    
}

enum OrderResultType {
    case success
    case fail
}
