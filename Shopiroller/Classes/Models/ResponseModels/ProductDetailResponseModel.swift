//
//  ProductDetailResponseModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation

struct ProductDetailResponseModel : Codable {
    
    var description : String?
    var images : [ProductImageModel]?
    var maxQuantityPerOrder : Int?
    var code : String?
    var useFixPrice : Bool?
    var brand : ProductDetailBrandModel?
    
    enum CodingKeys: String,CodingKey {
        case description = "description"
        case images = "images"
        case maxQuantityPerOrder = "maxQuantityPerOrder"
        case code = "code"
        case useFixPrice = "useFixPrice"
        case brand = "brand"
    }
}
