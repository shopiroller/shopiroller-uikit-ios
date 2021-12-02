//
//  FilterViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 26.11.2021.
//

import Foundation
import UIKit

class FilterViewModel: BaseViewModel {
    
    private let searchText: String?
    private let categoryId: String?
    private let showcaseId: String?
    
    private var filterOptions: SRFilterOptionsResponseModel?
    private var filterListSelector: [FilterTableViewSelector] = []
    
    var selectedIndexPath = IndexPath(row: 0, section: 0)
    private var selectionLabel = String()
    var selectedModel: FilterModel = FilterModel()
    
    init(searchText: String? = nil, categoryId: String? = nil, showcaseId: String? = nil) {
        self.searchText = searchText
        self.categoryId = nil
        self.showcaseId = showcaseId
    }
    
    func getFilterOptions(succes: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        let urlQueryItems: [URLQueryItem] = [
            URLQueryItem(name: SRAppConstants.Query.Keys.searchText, value: searchText),
            URLQueryItem(name: SRAppConstants.Query.Keys.categoryId, value: categoryId),
            URLQueryItem(name: SRAppConstants.Query.Keys.showcaseId, value: showcaseId)]
        
        SRNetworkManagerRequests.getFilterOptions(urlQueryItems: urlQueryItems).response() {
            (result) in
            switch result{
            case .success(let response):
                DispatchQueue.main.async {
                    self.filterOptions = response.data
                    succes?()
                }
            case.failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
        
    }
    
    func configureTableList() {
        if(!(filterOptions?.categories?.isEmpty ?? true)) {
            filterListSelector.append(.category)
        }
        if(!(filterOptions?.brands?.isEmpty ?? true)) {
            filterListSelector.append(.brand)
        }
        
        if let arr = filterOptions?.variationGroups?.enumerated() {
            for (index, _) in arr {
                filterListSelector.append(.variationGroups(position: index))
            }
        }
        
        filterListSelector.append(.priceRange)
        filterListSelector.append(.filterSwitch(type: .stockSwitch))
        filterListSelector.append(.filterSwitch(type: .discountedProductsSwitch))
        filterListSelector.append(.filterSwitch(type: .freeShippingSwitch))
    }
    
    func getSelectionLabel() -> String {
        return selectionLabel
    }
    
    func getFilterListSelectorCount() -> Int {
        return filterListSelector.count
    }
    
    func getFilterListSelector(position: Int) -> FilterTableViewSelector {
        return filterListSelector[position]
    }
    
    func getVariationGroupsItem(position: Int) -> VariationGroupsItem? {
        return filterOptions?.variationGroups?[position]
    }
    
    func getCurrency() -> CurrencyEnum {
        return CurrencyEnum.default
    }
    
    func getFilterChoiceViewModel() -> FilterChoiceViewModel? {
        switch getFilterListSelector(position: selectedIndexPath.row) {
        case .category:
            return FilterChoiceViewModel(dataList: filterOptions?.categories ?? [])
        case .brand:
            return FilterChoiceViewModel(dataList: filterOptions?.brands ?? [])
        case .variationGroups(position: let position):
            guard let variationGroup = getVariationGroupsItem(position: position) else {return nil}
            return FilterChoiceViewModel(dataList: variationGroup)
        default:
            return nil
        }
    }
    
    func choiceConfirmed(selectedIds: [String], selectionLabel: String) {
        self.selectionLabel = selectionLabel
        switch getFilterListSelector(position: selectedIndexPath.row) {
        case .category:
            selectedModel.categoryIds = selectedIds
        case .brand:
            selectedModel.brandIds = selectedIds
        case .variationGroups(position: let position):
            guard let variationGroup = getVariationGroupsItem(position: position) else {return}
            if let index = selectedModel.variationGroups.firstIndex(where: {$0.variationGroupsItemId == variationGroup.id}) {
                selectedModel.variationGroups[index].variationIds = selectedIds
            } else {
                selectedModel.variationGroups.append(VariationIds(variationGroupsItemId: variationGroup.id, variationIds: selectedIds))
            }
        default:
            break
        }
    }
   
}

enum FilterTableViewSelector {
    case category, brand, variationGroups(position: Int), priceRange, filterSwitch(type: FilterSwitchType)
}
