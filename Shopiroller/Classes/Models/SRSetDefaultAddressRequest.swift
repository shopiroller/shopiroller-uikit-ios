//
//  SRSetDefaultAddressRequest.swift
//  Shopiroller
//
//  Created by Görkem Gür on 6.12.2021.
//

import Foundation

struct SRSetDefaultAddressRequest: Codable{
    var appKey: String = SRNetworkContext.appKey
    var apiKey: String = SRNetworkContext.apiKey
    var isDefault: Bool = true
    
    enum CodingKeys: String,CodingKey {
        case appKey = "appKey"
        case apiKey = "apiKey"
        case isDefault = "isDefault"
    }
    
}
