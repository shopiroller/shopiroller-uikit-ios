//
//  ShoppingCartMessage.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 4.11.2021.
//
import Foundation

struct ShoppingCartMessage: Codable {
    
    var key: CartMessageKeyEnum? = nil
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
    case FreeShippingCampaign = "FreeShippingCampaign"
    case unknown = "unknown"
    
    
    public init(rawValue: RawValue) {
        switch rawValue {
        case "NotEnoughStock":
            self = .NotEnoughStock
        case "OutOfStock":
            self = .OutOfStock
        case "OverPublishmentDate":
            self = .OverPublishmentDate
        case "ProductNotFound":
            self = .ProductNotFound
        case "FreeShippingCampaign":
            self = .FreeShippingCampaign
        default:
            self = .unknown
        }
    }
    
    var text: String {
        switch self {
        case .UpdatedProduct:
            return ""
        case .NotEnoughStock:
            return "e_commerce_shopping_cart_invalid_product_left".localized
        case .OutOfStock:
            return "e_commerce_shopping_cart_invalid_out_of_stock".localized
        case .OverPublishmentDate:
            return "e_commerce_shopping_cart_invalid_publishment_end".localized
        case .ProductNotFound:
            return "e_commerce_shopping_cart_invalid_removed_basket".localized
        case .FreeShippingCampaign:
            return "FreeShippingCampaign".localized
        default:
            return "e_commerce_general_error_title".localized
        }
    }
}
