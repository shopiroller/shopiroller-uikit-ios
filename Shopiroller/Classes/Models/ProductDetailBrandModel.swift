//
//  ProductDetailBrandModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation


struct ProductDetailBrandModel : Codable {
    var id : String?
    var name : String?
    var icon : ProductImageModel?
    var isActive : Bool?
    var createdDate : String?
    var updatedDate : String?
    
    
    enum CodingKeys: String,CodingKey {
        case id = "id"
        case name = "name"
        case icon = "icon"
        case isActive = "isActive"
        case createdDate = "createDate"
        case updatedDate = "updateDate"
    }
}
