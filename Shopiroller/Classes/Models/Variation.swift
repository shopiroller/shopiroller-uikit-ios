//
//  Variation.swift
//  Shopiroller
//
//  Created by Görkem Gür on 18.05.2022.
//

import Foundation

struct Variation : Codable {
    var id: String?
    var value: String?
    
    enum CodingKeys: String,CodingKey {
        case id = "id"
        case value = "value"
    }
}
