//
//  SRNetworkManagerContentType.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation

enum SRNetworkManagerContentType {
    
    case json
    case formEncoded
    case multiPart(boundary: String)
    
    public var value: String {
        switch self {
        case .json:
            return "application/json"
        case .formEncoded:
            return "application/x-www-form-urlencoded"
        case .multiPart(let boundary):
            return "multipart/form-data; boundary=\(boundary)"
        }
    }
}
