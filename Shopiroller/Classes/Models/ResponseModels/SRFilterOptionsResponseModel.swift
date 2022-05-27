//
//  SRFilterOptionsResponseModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation


struct SRFilterOptionsResponseModel: Codable {
    
    var variationGroups: [VariationGroups]?
    var brands: [BrandsItem]?
    var categories: [CategoriesItem]?
    
    enum CodingKeys: String,CodingKey {
        case variationGroups = "variationGroups"
        case brands = "brands"
        case categories = "categories"
    }
}

struct BrandsItem: Codable {
    
    var updateDate: String?
    var name: String?
    var icon: ProductImageModel?
    var id: String?
    var isActive: Bool?
    var createDate: String?
    
    enum CodingKeys: String,CodingKey  {
        case updateDate = "updateDate"
        case name = "name"
        case icon = "icon"
        case id = "id"
        case isActive = "isActive"
        case createDate = "createDate"
    }
}

struct CategoriesItem: Codable {
    
    var updateDate: String?
    var name: Dictionary<String,String>?
    var icon: ProductImageModel?
    var totalProduct: Int?
    var orderIndex: Int?
    var parentCategoryId: String?
    var isActive: Bool?
    var categoryId: String?
    var subCategories: [CategoriesItem]?
    var createDate: String?
    
    enum CodingKeys: String,CodingKey {
        case updateDate = "updateDate"
        case name = "name"
        case icon = "icon"
        case totalProduct = "totalProduct"
        case orderIndex = "orderIndex"
        case parentCategoryId = "parentCategoryId"
        case isActive = "isActive"
        case categoryId = "categoryId"
        case subCategories = "subCategories"
        case createDate = "createDate"
    }
    
}

struct MultiChoiceItem: Codable {
    var name: String?
    var id: String?
    
    enum CodingKeys: String,CodingKey {
        case name = "name"
        case id = "id"
    }
}
