//
//  SRFilterOptionsResponseModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation

struct VariationItems: Codable {
    
    var id: String?
    var value: String?
    var isChecked: Bool?
    
}

struct SRFilterOptionsResponseModel: Codable {
    var variationGroups: [VariationGroupItems]?
    var brands: [BrandItems]?
    var categories: [CategoryItems]?
}

struct VariationGroupItems: Codable {
    
    var updatedDate: String?
    var icon: String?
    var name : Dictionary<String,String>?
    var totalProduct: Int?
    var orderIndex: Int?
    var parentCategoryId: Int?
    var isActive: Bool?
    var categoryId: String?
    var subCategories: [CategoryItems]?
    var createdDate: String?
    var isSelected: Bool?
    
    enum CodingKeys: String,CodingKey {
        case updatedDate = "updateDate"
        case createdDate = "createDate"
    }
}

struct CategoryItems: Codable {
    
    var updatedDate: String?
    var icon: String?
    var name: Dictionary<String,String>?
    var totalProduct: Int?
    var orderIndex: Int?
    var parentCategoryId: Int?
    var isActive: Bool?
    var categoryId: String?
    var subCategories: [CategoryItems]?
    var createdDate: String?
    var isSelected: Bool?
    
    enum CodingKeys: String,CodingKey {
        case updatedDate = "updateDate"
        case createdDate = "createDate"
    }
    
}

struct BrandItems: Codable {
    
    var updatedDate: String?
    var createdDate: String?
    var name: Dictionary<String,String>?
    var icon: String?
    var totalProduct: Int?
    var orderIndex: Int?
    var parentCategoryId: String?
    var isActive: Bool?
    var isChecked: Bool?
    
    enum CodingKeys: String,CodingKey  {
        case updatedDate = "updateDate"
        case createdDate = "createDate"
    }
}

struct MultiChoiceItem: Codable {
    var name: String?
    var id: String?
    var isChecked: Bool?
}
