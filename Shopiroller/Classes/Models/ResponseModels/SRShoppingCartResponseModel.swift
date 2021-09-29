//
//  SRShoppingCartResponseModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation


class SRShoppingCartResponseModel: Codable {
    
    var userId: String?
    var appId: String?
    var culture: String?
    var currency: String?
    var items: [ShoppingCartItem]?
    var invalidItems: [ShoppingCartItem]?
    var messages: [ShoppingCartMessage]?
    var subTotalPrice: Double?
    var totalPrice: Double?
    var shippingPrice: Double?
    var updatedDate: String?
    var createdDate: String?

    enum CodingKeys: String,CodingKey {
        case userId = "userId"
        case appId = "appId"
        case culture = "culture"
        case currency = "currency"
        case items = "items"
        case invalidItems = "invalidItems"
        case messages = "messages"
        case subTotalPrice = "subTotalPrice"
        case totalPrice = "totalPrice"
        case shippingPrice = "shippingPrice"
        case updatedDate = "updateDate"
        case createdDate = "createDate"
    }
}

struct ShoppingCartMessage: Codable {
    var key: String?
    var message: String?
    var type: String?
    
    enum CodingKeys: String,CodingKey {
        case key = "key"
        case message = "message"
        case type = "type"
    }
}

struct ShoppingCartItem: Codable {
    
    var id: String?
    var productId: String?
    var product: ProductDetailResponseModel?
    var quantity: Int?
    var price: Double?
    var isValid: Bool?
    var createdDate: String?
    var updatedDate: String?
    
    enum CodingKeys: String,CodingKey {
        case createdDate = "createDate"
        case updatedDate = "updateDate"
    }
}
