//
//  VariantDataModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 18.05.2022.
//

import Foundation

struct VariantDataModel : Codable, Equatable {
    var value: String?
    var variationGroupId: String?
    var variationId: String?
    
    enum CodingKeys: String,CodingKey {
        case value = "value"
        case variationGroupId = "variationGroupId"
        case variationId = "variationId"
    }
}

func ==(lhs:VariantDataModel, rhs:VariantDataModel) -> Bool { // Implement Equatable
    return lhs.variationId == rhs.variationId && lhs.variationGroupId == rhs.variationGroupId
}
