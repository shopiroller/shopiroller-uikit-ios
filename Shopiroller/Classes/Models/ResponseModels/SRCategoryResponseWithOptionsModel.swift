//
//  SRCategoryResponseWithOptionsModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 4.03.2022.
//

import Foundation

class SRCategoryResponseWithOptionsModel: Codable {
    
    var categories: [SRCategoryResponseModel]?
    var mobileSettings: SRMobileSettingsResponseModel?
    
    enum CodingKeys: String, CodingKey {
        case categories = "categories"
        case mobileSettings = "mobileSettings"
    }
}
