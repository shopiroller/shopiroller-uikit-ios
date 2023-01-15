//
//  Variation.swift
//  Shopiroller
//
//  Created by Görkem Gür on 18.05.2022.
//

import Foundation

struct Variation: Codable, Hashable {
    var id: String?
    var value: String?
    
    var isSelected: Bool = false
    var isAvailable: Bool = false
    
    enum CodingKeys: String,CodingKey {
        case id = "id"
        case value = "value"
    }
}
