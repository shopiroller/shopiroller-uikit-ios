//
//  CompleteOrderModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 19.09.2021.
//

import Foundation


struct CompleteOrderModel: Codable {
    
    var orderId: String?
    var userNote: String?
    var paymentType: String?
    var card: OrderCardModel?
    var bankAccount: String?
    var paymentAccount: BankAccountModel?
    
    enum CodingKeys: String,CodingKey {
        case orderId = "orderId"
        case userNote = "userNote"
        case paymentType = "paymentType"
        case card = "card"
        case bankAccount = "bankAccount"
    }
}
