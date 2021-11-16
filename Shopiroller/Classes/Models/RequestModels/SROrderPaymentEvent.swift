//
//  SROrderPaymentEvent.swift
//  Shopiroller
//
//  Created by Görkem Gür on 15.11.2021.
//

import Foundation

struct OrderPaymentEvent: Codable {
    
    var paymentType : String?
    var bankAccount : BankAccountModel?
    var orderCard : OrderCardModel = OrderCardModel()
    
}
