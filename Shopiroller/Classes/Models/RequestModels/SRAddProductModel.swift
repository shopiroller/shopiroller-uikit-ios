//
//  SRAddProductMode.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation

struct SRAddProductModel: Codable {
    
    var productId: String?
    var quantity: Int?
    var displayName: String?
    
    enum CodingKeys: String,CodingKey {
        case productId = "productId"
        case quantity = "quantity"
        case displayName = "displayName"
    }
    
}


