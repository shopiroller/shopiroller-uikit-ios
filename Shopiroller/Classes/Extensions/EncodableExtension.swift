//
//  SREncodableExtension.swift
//  shopiroller
//
//  Created by Görkem Gür on 16.09.2021.
//

import Foundation

extension Encodable {
    
    func encoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
}

extension Encodable {
    
    var data: Data? {
        return try? JSONEncoder().encode(self)
    }
    
}
