//
//  SRMakeOrderResponse.swift
//  shopiroller
//
//  Created by Görkem Gür on 19.09.2021.
//

import Foundation

struct SRMakeOrderResponse: Codable {
    
    var userId: String?
    var userNote: String?
    var bankAccount: String?
    var paymentAccount: BankAccountModel?
    var paymentType: String?
    var products: [SROrderProductModel]?
    var shippingAdress: MakeOrderAddressModel?
    var billingAdress: MakeOrderAddressModel?
    var buyer: BuyerOrderModel?
    var card: OrderCardModel?
    var productPriceTotal:
        Double?
    var shippingPrice: Double?
    var currency: String?
    var orderId: String?
    var tryAgain: Bool?
    var bankAccountModel: BankAccountModel?
    var userShippingAdressModel: UserShippingAddressModel?
    var userBillingAdressModel: UserBillingAdressModel?
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case userNote = "userNote"
        case bankAccount = "bankAccount"
        case paymentType = "paymentType"
        case productPriceTotal = "productPriceTotal"
        case shippingPrice = "shippingPrice"
        case currency = "currency"
        case orderId = "orderId"
        case tryAgain = "tryAgain"
    }
    
}
