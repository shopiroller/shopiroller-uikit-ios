//
//  OrderCardModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 19.09.2021.
//

import Foundation

struct OrderCardModel: Codable {
    
    var cardHolderName: String?
    var cardNumber: String?
    var expireMonth: String?
    var expireYear: String?
    var cvc: String?
    
    enum CodingKeys: String,CodingKey {
        case cardHolderName = "cardHolderName"
        case cardNumber = "cardNumber"
        case expireMonth = "expireMonth"
        case expireYear = "expireYear"
        case cvc = "cvc"
    }
}

struct ShoppingCartCount: Codable {
    var cardCount: Int?
}
