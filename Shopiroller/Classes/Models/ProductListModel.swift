//
//  ProductListModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation


struct ProductListModel: Codable {
    
    var id: String?
    var title: String?
    var stock: Int?
    var price: Double?
    var campaignPrice: Double?
    var shippingPrice: Double?
    var currency: CurrencyEnum?
    var featuredImage: ProductImageModel?
}
