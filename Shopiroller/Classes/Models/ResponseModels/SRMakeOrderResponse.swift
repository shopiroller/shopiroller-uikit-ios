//
//  SRMakeOrderResponse.swift
//  shopiroller
//
//  Created by Görkem Gür on 19.09.2021.
//

import Foundation

struct SRMakeOrderResponse: Codable {
    
    var userId: String?
    var userNote: String = ""
    var bankAccount: String?
    var paymentAccount: BankAccountModel?
    var paymentType: String?
    var products: [SROrderProductModel]?
    var shippingAddress: MakeOrderAddressModel?
    var billingAddress: MakeOrderAddressModel?
    var buyer: BuyerOrderModel = BuyerOrderModel()
    var creditCard: OrderCardModel = OrderCardModel()
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
        case paymentAccount = "paymentAccount"
        case paymentType = "paymentType"
        case productPriceTotal = "productPriceTotal"
        case shippingPrice = "shippingPrice"
        case buyer = "buyer"
        case creditCard = "creditCard"
        case currency = "currency"
        case orderId = "orderId"
        case tryAgain = "tryAgain"
        case shippingAddress = "shippingAddress"
        case billingAddress = "billingAddress"
    }
    
    func getCompleteOrderModel() -> CompleteOrderModel {
        if (paymentType?.lowercased() == PaymentTypeEnum.Online3DS.rawValue.lowercased() || paymentType?.lowercased() == PaymentTypeEnum.Online.rawValue.lowercased()) {
            return CompleteOrderModel(orderId: SRSessionManager.shared.orderResponseInnerModel?.order?.id, userNote: userNote, paymentType: paymentType, card: creditCard)
        } else if (paymentType?.lowercased() == PaymentTypeEnum.Transfer.rawValue.lowercased()) {
            return CompleteOrderModel(orderId: orderId, userNote: userNote, paymentType: paymentType, bankAccount: bankAccount, paymentAccount: paymentAccount)
        } else {
            return CompleteOrderModel(orderId: orderId, userNote: userNote, paymentType: paymentType)
        }
    }
    
}
