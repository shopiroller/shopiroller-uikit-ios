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
    var paidPrice: Double?
    var quantity : Int?
    var currency : CurrencyEnum?
    var campaignPrice: Double?
    
}
