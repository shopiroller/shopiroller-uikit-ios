//
//  SRCategoryResponseModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation


struct SRCategoryResponseModel: Codable {
    
    var categoryId: String?
    var name: String?
    var icon: String?
    var parentCategoryId: String?
    var orderIndex: Int?
    var createdDate: String?
    var updatedDate: String?
    var totalProduct: Int?
    var isActive: Bool?
    var subCategories: [SRCategoryResponseModel]?
    
    
    enum CodingKeys: String,CodingKey {
        case categoryId = "categoryId"
        case name = "name"
        case icon = "icon"
        case parentCategoryId = "parentCategoryId"
        case orderIndex = "orderIndex"
        case totalProduct = "totalProduct"
        case isActive = "isActive"
        case createdDate = "createDate"
        case updatedDate = "updateDate"
        case subCategories = "subCategories"
    }
}
