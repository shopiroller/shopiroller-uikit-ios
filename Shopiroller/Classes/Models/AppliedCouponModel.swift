//
//  AppliedCouponModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 2.08.2022.
//

import Foundation


struct AppliedCouponModel: Codable {
    
    var id: String?
    var code: String?
    var totalPrice: Double?
    var currency: String?
    var expireDate: String?
    var type: String?
    var discountPrice: Double?
    
    enum CodingKeys: String,CodingKey {
        case id = "id"
        case code = "code"
        case totalPrice = "totalPrice"
        case currency = "currency"
        case expireDate = "expireDate"
        case type = "type"
        case discountPrice = "value"
        
    }
}
