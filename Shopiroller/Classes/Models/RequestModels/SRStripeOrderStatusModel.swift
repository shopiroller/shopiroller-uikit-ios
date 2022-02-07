//
//  SRStripeOrderStatusModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 3.02.2022.
//

import Foundation


struct SRStripeOrderStatusModel: Codable {
    
    var paymentId: String? = nil
    var orderId: String? = nil
    
    enum CodingKeys: String,CodingKey {
        case paymentId = "paymentId"
        case orderId = "orderId"
    }
    
}
