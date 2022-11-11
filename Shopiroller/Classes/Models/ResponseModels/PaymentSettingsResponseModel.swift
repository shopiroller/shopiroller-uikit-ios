//
//  PaymentSettingsResponseModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation


struct PaymentSettingsResponeModel: Codable {
    
    var description: String?
    var deliveryConditions: String?
    var cancellationProcedure: String?
    var distanceSalesContract: String?
    var paymentAccounts: [BankAccountModel]?
    var supportedPaymentTypes: [SupportedPaymentType]?
    var defaultCurrency: String?
    var deliveryConditionsTitle: String?
    var cancellationProcedureTitle: String?
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case deliveryConditions = "deliveryConditions"
        case cancellationProcedure = "cancellationProcedure"
        case distanceSalesContract = "distanceSalesContract"
        case paymentAccounts = "paymentAccounts"
        case supportedPaymentTypes = "supportedPaymentTypes"
        case deliveryConditionsTitle = "deliveryConditionsTitle"
        case cancellationProcedureTitle = "cancellationProcedureTitle"
        case defaultCurrency = "defaultCurrency"
    }
    
    func getSupportedPaymentTypes() ->  [SupportedPaymentType]? {
        var newList : [SupportedPaymentType] = []
        if let supportedPaymentTypes = supportedPaymentTypes {
            supportedPaymentTypes.forEach { payments in
                if ((payments.paymentType != .PayPal) && (payments.paymentType != .Other)) {
                    newList.append(payments)
                }
            }
        }
        return newList
    }
}

struct SupportedPaymentType: Codable {
    
    var paymentType : PaymentTypeEnum
    var description : String?
    var configuration: PaymentConfiguration?
    
    enum CodingKeys: String,CodingKey {
        case description = "description"
        case paymentType = "paymentType"
        case configuration = "configuration"
    }
}



struct PaymentConfiguration: Codable {
    
    var accessToken : String?
    
    enum CodingKeys: String,CodingKey {
        case accessToken = "accessToken"
    }
}
