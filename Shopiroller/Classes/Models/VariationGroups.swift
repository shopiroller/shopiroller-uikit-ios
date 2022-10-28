//
//  VariationsGroupModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 18.05.2022.
//

import Foundation


struct VariationGroups : Codable {
    var createdDate: String?
    var id: String?
    var isActive: Bool?
    var name: String?
    var updatedDate: String?
    var variations: [Variation]?
    
    enum CodingKeys: String,CodingKey {
        case createdDate = "createDate"
        case id = "id"
        case isActive = "isActive"
        case name = "name"
        case updatedDate = "updateDate"
        case variations = "variations"
    }
}
