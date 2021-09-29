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
    var icon : String?
    var isActive : Bool?
    var createDate : String?
    var updateDate : String?
    
    
    enum CodingKeys: String,CodingKey {
        case id = "id"
        case name = "name"
        case icon = "icon"
        case isActive = "isActive"
        case createDate = "createDate"
        case updateDate = "updateDate"
    }
}
