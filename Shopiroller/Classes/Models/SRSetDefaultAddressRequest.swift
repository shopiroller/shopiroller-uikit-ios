//
//  SRSetDefaultAddressRequest.swift
//  Shopiroller
//
//  Created by Görkem Gür on 6.12.2021.
//

import Foundation

struct SRSetDefaultAddressRequest: Codable{
    var appKey: String = SRAppContext.appUserAppKey
    var apiKey: String = SRAppContext.appUserApiKey
    var isDefault: Bool = true
    
    enum CodingKeys: String,CodingKey {
        case appKey = "appKey"
        case apiKey = "apiKey"
        case isDefault = "isDefault"
    }
    
}
