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
    var variants: [ProductDetailResponseModel]?
    var variationGroups: [VariationGroups]?
    var variantData: [VariantDataModel]?
    var id : String?
    var title : String?
    var stock : Int?
    var price : Double?
    var campaignPrice : Double?
    var shippingPrice: Double?
    var currency: CurrencyEnum?
    var featuredImage: ProductImageModel?
    
    enum CodingKeys: String,CodingKey {
        case description = "description"
        case images = "images"
        case maxQuantityPerOrder = "maxQuantityPerOrder"
        case code = "code"
        case useFixPrice = "useFixPrice"
        case brand = "brand"
        case variants = "variants"
        case variationGroups = "variationGroups"
        case variantData = "variantData"
        case id = "id"
        case title = "title"
        case stock = "stock"
        case price = "price"
        case campaignPrice = "campaignPrice"
        case shippingPrice = "shippingPrice"
        case currency = "currency"
        case featuredImage = "featuredImage"
    }
}
