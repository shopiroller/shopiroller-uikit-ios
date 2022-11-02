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
    var nonce: String?
    var paymentType: String?
    var card: OrderCardModel?
    var bankAccount: String?
    var paymentAccount: BankAccountModel?
}
