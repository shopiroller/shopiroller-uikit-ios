//
//  BuyerOrderModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 19.09.2021.
//

import Foundation

struct BuyerOrderModel: Codable {
    var name : String?
    var surname : String?
    var email : String?
    
    enum CodingKeys: String,CodingKey {
        case name = "name"
        case surname = "surname"
        case email = "email"
    }
}
