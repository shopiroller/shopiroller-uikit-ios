//
//  ProductImageModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation

struct ProductImageModel : Codable {
    
    var thumbnail : String?
    var normal : String?
    
    enum CodingKeys : String, CodingKey {
        case thumbnail = "t"
        case normal = "n"
    }
}
