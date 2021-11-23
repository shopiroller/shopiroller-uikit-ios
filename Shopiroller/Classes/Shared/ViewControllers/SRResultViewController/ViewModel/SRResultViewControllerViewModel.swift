//
//  SRResultViewControllerViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 22.11.2021.
//

import Foundation

class SRResultViewControllerViewModel : BaseViewModel {
    private let type: OrderResultType?
    private let id: String?
    private let message: String?
    
    init (type: OrderResultType? = nil, id: String? = nil, message: String? = nil) {
        self.type = type
        self.id = id
        self.message = message
    }
    
    func getType() -> OrderResultType? {
        return type
    }
    
    func getMessage() -> String {
        return message ?? ""
    }
    
    func getId() -> String {
        return id ?? ""
    }
}

enum OrderResultType {
    case success
    case fail
}
