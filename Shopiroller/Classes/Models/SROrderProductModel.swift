//
//  SROrderProductModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation

struct SROrderProductModel: Codable {
    
    var id : String?
    var title : String?
    var featuredImage : ProductImageModel?
    var price: Double?
    var quantity : Int?
    var currency : String?
    var campaignPrice: Double?
    
    enum CodingKeys: String,CodingKey {
        case id = "id"
        case title = "title"
        case featuredImage = "featuredImage"
        case price = "price"
        case quantity = "quantity"
        case currency = "currency"
        case campaignPrice = "campaignPrice"
    }
}
