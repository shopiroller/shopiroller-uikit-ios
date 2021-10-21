//
//  SROrderModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation


struct SROrderModel: Codable {
    
    var id : String?
    var totalPrice : Double?
    var shippingPrice : Double?
    var currency : String?
    var currentStatus : OrderStatusEnum?
    var orderCode : String?
    var createdDate : String?
    var userNote : String?
    var paymentType : String?
    var cardNumber : String?
    var productList : [SROrderProductModel]?
    var shippingTrackingCode : String?
    var shippingTrackingCompany : String?
    
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
    }
}

struct OrderResponse: Codable {
    
    var data : SROrderResponseInnerModel?
    var errors: [String]?
    
    enum CodingKeys: String,CodingKey {
        case data = "data"
        case errors = "errors"
    }
}
