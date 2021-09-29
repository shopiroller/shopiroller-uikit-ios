//
//  PaymentSettingsResponseModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation


struct PaymentSettingsResponeModel: Codable {
    
    var description : String?
    var deliveryConditions : String?
    var cancellationProcedure : String?
    var distanceSalesContract : String?
    var paymentAccounts : [BankAccountModel]?
    var supportedPaymentTypes : [SupportedPaymentType]?
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case deliveryConditions = "deliveryConditions"
        case cancellationProcedure = "cancellationProcedure"
        case distanceSalesContract = "distanceSalesContract"
        case paymentAccounts = "paymentAccounts"
        case supportedPaymentTypes = "supportedPaymentTypes"
    }
}

struct SupportedPaymentType: Codable {
    
    var paymentType : String?
    var description : String?
    var configuration: PaymentConfiguration?
    
    enum CodingKeys: String,CodingKey {
        case description = "description"
        case paymentType = "paymentType"
    }
}



struct PaymentConfiguration: Codable {
    
    var accessToken : String?
    
    enum CodingKeys: String,CodingKey {
        case accessToken = "accessToken"
    }
}
