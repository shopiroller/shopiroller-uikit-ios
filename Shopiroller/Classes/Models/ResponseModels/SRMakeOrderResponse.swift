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
    var userShippingAdressModel: userShippingAddressModel?
    var userBillingAdressModel: userBillingAdressModel?
    
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

class userShippingAddressModel: BaseAddressModel {
    func getOrderAdress() -> MakeOrderAddressModel{
        var makeOrderAddress = MakeOrderAddressModel()
        makeOrderAddress.city = city
        makeOrderAddress.state = state
        makeOrderAddress.country = country
        makeOrderAddress.description = description
        makeOrderAddress.id = id
        makeOrderAddress.zipCode = zipCode
        makeOrderAddress.phoneNumber = contact?.phoneNumber
        makeOrderAddress.nameSurname = contact?.nameSurname
        return makeOrderAddress
    }
}

class userBillingAdressModel: BaseAddressModel {
    var type: String?
    var identityNumber: String?
    var companyName: String?
    var taxNumber: String?
    var taxOffice: String?
    
    enum CodingKeys: String,CodingKey {
        case type = "type"
        case identityNumber = "identityNumber"
        case companyName = "companyName"
        case taxNumber = "taxNumber"
        case taxOffice = "taxOffice"
    }
    
    func getOrderAdress() -> MakeOrderAddressModel {
        var makeOrderAddress = MakeOrderAddressModel()
        makeOrderAddress.city = city
        makeOrderAddress.companyName = companyName
        makeOrderAddress.state = state
        makeOrderAddress.country = country
        makeOrderAddress.description = description
        makeOrderAddress.id = id
        makeOrderAddress.identityNumber = identityNumber
        makeOrderAddress.taxOffice = taxOffice
        makeOrderAddress.taxNumber = taxNumber
        makeOrderAddress.zipCode = zipCode
        makeOrderAddress.phoneNumber = contact?.phoneNumber
        makeOrderAddress.nameSurname = contact?.nameSurname
        return makeOrderAddress
    }
}


