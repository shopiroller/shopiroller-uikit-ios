//
//  SROrderResponseInnerModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation

struct SROrderResponseInnerModel: Codable {
    
    var order : SROrderModel?
    var payment : SROrderPaymentResultModel?
    var key : String?
    var message : String?
    var isUserFriendlyMessage: Bool?
    var errors: [String]?
        
    enum CodingKeys: String,CodingKey {
        case order = "order"
        case payment = "payment"
        case key = "key"
        case message = "message"
        case isUserFriendlyMessage = "isUserFriendlyMessage"
        case errors = "errors"
    }
}
