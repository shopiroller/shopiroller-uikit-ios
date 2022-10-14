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
    
}

struct BrandsItem: Codable {
    
    var updateDate: String?
    var name: String?
    var icon: ProductImageModel?
    var id: String?
    var isActive: Bool?
    var createDate: String?
}

struct CategoriesItem: Codable {
    
    var updateDate: String?
    var name: [String:String]?
    var icon: ProductImageModel?
    var totalProduct: Int?
    var orderIndex: Int?
    var parentCategoryId: String?
    var isActive: Bool?
    var categoryId: String?
    var subCategories: [CategoriesItem]?
    var createDate: String?
    
}

struct MultiChoiceItem: Codable {
    var name: String?
    var id: String?
}
