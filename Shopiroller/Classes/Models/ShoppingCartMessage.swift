//
//  ShoppingCartMessage.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 4.11.2021.
//

import Foundation

struct ShoppingCartMessage: Codable {
    
    var key: CartMessageKeyEnum?
    var message: String?
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        case key = "key"
        case message = "message"
        case type = "type"
    }
}

enum CartMessageKeyEnum: String, Codable {

    case UpdatedProduct = "UpdatedProduct"
    case NotEnoughStock = "NotEnoughStock"
    case OutOfStock = "OutOfStock"
    case OverPublishmentDate = "OverPublishmentDate"
    case ProductNotFound = "ProductNotFound"
    
    var text: String {
        switch self {
        case .UpdatedProduct:
            return ""
        case .NotEnoughStock:
            return "NotEnoughStock".localized
        case .OutOfStock:
            return "OutOfStock".localized
        case .OverPublishmentDate:
            return "OverPublishmentDate".localized
        case .ProductNotFound:
            return "ProductNotFound".localized
        }
    }
}

