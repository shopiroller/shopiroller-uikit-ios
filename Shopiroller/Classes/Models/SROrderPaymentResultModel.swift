//
//  SROrderPaymentResultModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation


struct SROrderPaymentResultModel: Codable {
    var isSuccess: Bool?
    var id: String?
    var state: String?
    var stateCode: Int?
    var status: String?
    var transactionId: String?
    var conversationId: String?
    var message: String?
    var _3DSecureHtml : String?
    
    //Only PayPal
    var token: String?
    
    enum CodingKeys: String,CodingKey {
        case isSuccess = "isSuccess"
        case id = "id"
        case state = "state"
        case stateCode = "stateCode"
        case status = "status"
        case transactionId = "transactionId"
        case conversationId = "conversationId"
        case message = "message"
        case _3DSecureHtml = "_3DSecureHtml"
        case token = "token"
    }
}
