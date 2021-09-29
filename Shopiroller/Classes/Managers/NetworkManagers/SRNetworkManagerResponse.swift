//
//  SRNetworkManagerResponse.swift
//  shopiroller
//
//  Created by Görkem Gür on 16.09.2021.
//


struct SRNetworkManagerResponse<T: Decodable>: Decodable {
    
    var data: T?
    var success: Bool?
    var isUserFriendlyMessage: Bool?
    var key: String?
    var message: String?
    var errors: [String]?
    
    //Only For Orders
    var order : SROrderModel?
    var paymentResult: SROrderPaymentResultModel?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case success = "success"
        case isUserFriendlyMessage = "isUserFriendlyMessage"
        case key = "key"
        case message = "message"
        case errors = "errors"
        case order = "order"
        case paymentResult = "paymentResult"
    }
    
}
