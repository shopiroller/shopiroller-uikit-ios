//
//  ShoppingCartItem.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 4.11.2021.
//

import Foundation

struct ShoppingCartItem: Codable {
    
    var id: String?
    var productId: String?
    var product: ProductDetailResponseModel?
    var quantity: Int?
    var price: Double?
    var isValid: Bool?
    var createdDate: String?
    var updatedDate: String?
    var messages: [ShoppingCartMessage]?
    
    enum CodingKeys: String,CodingKey {
        case id = "id"
        case productId = "productId"
        case product = "product"
        case quantity = "quantity"
        case price = "price"
        case isValid = "isValid"
        case createdDate = "createDate"
        case updatedDate = "updateDate"
        case messages = "messages"
    }
}
