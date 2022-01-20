//
//  SRSortEnum.swift
//  Shopiroller
//
//  Created by Görkem Gür on 15.12.2021.
//

import Foundation

struct SRSortModel {
    var orderOption: OrderOptionType?
    var orderOrientation: OrderOptionOrientation?
}

enum OrderOptionType {
    
    case title
    case stockCode
    case price
    case currency
    case stock
    case shippingPrice
    case campaignPrice
    case maxQuantityPerOrder
    case orderIndex
    case publishmentDate
    case endDate
    case statsOrderCount
    case calculatedPrice
    
    var string: String {
        
        switch self {
        case .title:
            return "Title"
        case .stockCode:
            return "StockCode"
        case .price:
            return "Price"
        case .currency:
            return "Currency"
        case .stock:
            return "Stock"
        case .shippingPrice:
            return "ShippingPrice"
        case .campaignPrice:
            return "CampaignPrice"
        case .maxQuantityPerOrder:
            return "MaxQuantityPerOrder"
        case .orderIndex:
            return "OrderIndex"
        case .publishmentDate:
            return "PublishmentDate"
        case .endDate:
            return "EndDate"
        case .statsOrderCount:
            return "Starts.OrderCount"
        case .calculatedPrice:
            return "CalculatedPrice"
        }
    }
    
}

enum OrderOptionOrientation {
    
    case ascending
    case descending
    
    var string: String {
        switch self {
        case .ascending:
            return "Ascending"
        case .descending:
            return "Descending"
        }
    }

}
