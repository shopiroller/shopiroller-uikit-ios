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

enum OrderOptionType: String {
    case noOption = "NoOption"
    case title = "Title"
    case stockCode = "StockCode"
    case price = "Price"
    case currency = "Currency"
    case stock = "Stock"
    case shippingPrice = "ShippingPrice"
    case campaignPrice = "CampaignPrice"
    case maxQuantityPerOrder = "MaxQuantityPerOrder"
    case orderIndex = "OrderIndex"
    case publishmentDate = "PublishmentDate"
    case endDate = "EndDate"
    case statsOrderCount = "Starts.OrderCount"
    
    var title: String {
        switch self {
        case .noOption:
            return "NoOption"
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
        }
    }
    
}

enum OrderOptionOrientation: String {
    case noAssigned = "NoAssigned"
    case ascending = "Ascending"
    case descending = "Descending"
    
    var title: String {
        switch self {
        case .noAssigned:
            return "NoAssigned"
        case .ascending:
            return "ascending"
        case .descending:
            return "descending"
        }
    }

}
