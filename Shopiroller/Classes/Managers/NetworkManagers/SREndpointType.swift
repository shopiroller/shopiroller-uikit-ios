//
//  SREndpointType.swift
//  shopiroller
//
//  Created by Görkem Gür on 16.09.2021.
//

import Foundation

public enum SREndpointType {
    case dev
//    case prod
//    case qas
//    case sandbox
    case custom(url: String, port: Int)

    var baseURL: String {
        switch self {
        case .dev:
            return "api.shopiroller.com"
//        case .dev:
//            return "qaapi.shopiroller.com"
//        case .dev:
//            return "api.shopiroller.com"
//        case .dev:
//            return "sandboxapi.shopiroller.com"
        case .custom(let url, _):
            return url
        }
    }
    
    var userBaseUrl: String {
        switch self {
        case .dev:
            return "mobiroller.api.applyze.com"
        case .custom(let url, _):
            return url
        }
    }
    
    var scheme: String {
        switch self {
//        case .prod:
//            return "https"
        default:
            return "https"
        }
    }
    
    var port: Int? {
        switch self {
        case .custom(_, let port):
            return port
        default:
            return nil
        }
    }
}
