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
    var _3DSecureHtml: String?
    
    //Stripe && PayPal
    var token: String?
    
    //Stripe
    var publishableKey: String?
}
