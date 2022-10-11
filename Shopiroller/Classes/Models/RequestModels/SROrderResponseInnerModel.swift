//
//  SROrderResponseInnerModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation

struct SROrderResponseInnerModel: Codable {
    
    var order : OrderDetailModel?
    var payment : SROrderPaymentResultModel?
    var key : String?
    var message : String?
    var isUserFriendlyMessage: Bool?
    var errors: [String]?
}
