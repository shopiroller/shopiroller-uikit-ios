//
//  OrderDetailModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 20.09.2021.
//

import Foundation


class OrderDetailModel: Codable {
    
    var id: String?
    var totalPrice: Double?
    var shippingPrice: Double?
    var currency: String?
    var currentStatus: OrderStatusEnum?
    var orderCode: String?
    var createdDate: String?
    var userNote: String?
    var paymentType: PaymentTypeEnum?
    var cardNumber: String?
    var productList: [SROrderProductModel]?
    var shippingTrackingCode: String?
    var shippingTrackingCompany: String?
    var bankAccount: String?
    var paymentAccount: BankAccountModel?
    var appliedCoupon: AppliedCouponModel?
    var shippingAddress: MakeOrderAddressModel?
    var billingAddress: MakeOrderAddressModel?
    var buyer: BuyerOrderModel?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case totalPrice = "totalPrice"
        case shippingPrice = "shippingPrice"
        case currency = "currency"
        case currentStatus = "currentStatus"
        case orderCode = "orderCode"
        case createdDate = "createDate"
        case userNote = "userNote"
        case paymentType = "paymentType"
        case cardNumber = "cardNumber"
        case productList = "productList"
        case shippingTrackingCode = "shippingTrackingCode"
        case shippingTrackingCompany = "shippingTrackingCompany"
        case bankAccount = "bankAccount"
        case paymentAccount = "paymentAccount"
        case shippingAddress = "shippingAddress"
        case billingAddress = "billingAddress"
        case buyer = "buyer"
        case appliedCoupon = "appliedCoupon"
    }
    
    func getFullName() -> String? {
        return (buyer?.name ?? "") + " " +  (buyer?.surname ?? "")
    }
    
}
