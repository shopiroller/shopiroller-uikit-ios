//
//  FilterModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 30.11.2021.
//

import Foundation

struct FilterModel {
    var categoryIds: SelectionIds = SelectionIds()
    var brandIds: SelectionIds = SelectionIds()
    var variationGroups: [VariationIds] = []
    var minimumPrice: Double?
    var maximumPrice: Double?
    var stockSwitch: Bool = false
    var discountedProductsSwitch: Bool = false
    var freeShippingSwitch: Bool = false
    
    func getQueryArray() -> [URLQueryItem] {
        var urlQueryItems: [URLQueryItem] = []
        if(!categoryIds.selectedIds.isEmpty) {
            urlQueryItems.append(contentsOf: categoryIds.selectedIds.map{URLQueryItem(name: SRAppConstants.Query.Keys.categoryId, value: $0) })
        }
        if(!brandIds.selectedIds.isEmpty) {
            urlQueryItems.append(contentsOf: brandIds.selectedIds.map{URLQueryItem(name: SRAppConstants.Query.Keys.brandId, value: $0) })
        }
        if(!variationGroups.isEmpty) {
            var selectionIds = SelectionIds()
            for item in variationGroups {
                selectionIds.selectedIds = item.variationIds.selectedIds
            }
            urlQueryItems.append(contentsOf: selectionIds.selectedIds.map{ URLQueryItem(name: SRAppConstants.Query.Keys.variantData, value: $0 ) })
        }
        if let minimumPrice = minimumPrice {
            urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.priceMin, value: String(minimumPrice)))
        }
        if let maximumPrice = maximumPrice {
            urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.priceMax, value: String(maximumPrice)))
        }
        if(stockSwitch) {
            urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.stockMin, value: String(1)))
        }
        if(discountedProductsSwitch) {
            urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.isThereCampaign, value: String(discountedProductsSwitch)))
        }
        if(freeShippingSwitch) {
            urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.shippingPrice, value: String(true)))
        }
        return urlQueryItems
    }
    
    func hasFilter() -> Bool {
        return !categoryIds.selectedIds.isEmpty || !brandIds.selectedIds.isEmpty || !variationGroups.isEmpty || minimumPrice != nil || maximumPrice != nil || stockSwitch || discountedProductsSwitch || freeShippingSwitch
    }

}

struct VariationIds {
    let variationGroupsItemId: String?
    var variationIds: SelectionIds = SelectionIds()
}

struct SelectionIds {
    var selectedIds: [String]
    let selectionNameLabel: String
    
    init(selectedIds: [String] = [], selectionNameLabel: String = String()) {
        self.selectedIds = selectedIds
        self.selectionNameLabel = selectionNameLabel
    }
}
