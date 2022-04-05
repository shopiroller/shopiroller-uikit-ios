//
//  SRMobileSettingsResponseModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 4.03.2022.
//

import Foundation


struct SRMobileSettingsResponseModel: Codable {
    
    var categoryDisplayType: CategoryDisplayTypeEnum?
 
    enum CodingKeys: String, CodingKey {
        case categoryDisplayType = "categoryDisplayType"
    }
    
}

enum CategoryDisplayTypeEnum: String, Codable {
    
    case imageAndText = "ImageAndText"
    case textOnly = "TextOnly"
    case imageOnly = "ImageOnly"

}
