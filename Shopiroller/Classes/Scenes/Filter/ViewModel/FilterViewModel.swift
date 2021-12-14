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
    var selectedModel: FilterModel
    
    init(searchText: String? = nil, categoryId: String? = nil, showcaseId: String? = nil, filterModel: FilterModel) {
        self.searchText = searchText
        self.categoryId = categoryId
        self.showcaseId = showcaseId
        self.selectedModel = filterModel
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
        
        // MARK: VariationGroups removed in filter section until next phase
        /*if let arr = filterOptions?.variationGroups?.enumerated() {
            for (index, _) in arr {
                filterListSelector.append(.variationGroups(position: index))
            }
        }*/
        
        filterListSelector.append(.priceRange)
        filterListSelector.append(.filterSwitch(type: .stockSwitch))
        filterListSelector.append(.filterSwitch(type: .discountedProductsSwitch))
        filterListSelector.append(.filterSwitch(type: .freeShippingSwitch))
    }
    
    func getSelectionLabel() -> String {
        switch getFilterListSelector(position: selectedIndexPath.row) {
        case .category:
            return selectedModel.categoryIds.selectionNameLabel
        case .brand:
            return selectedModel.brandIds.selectionNameLabel
        case .variationGroups(position: let position):
            guard let variationGroup = getVariationGroupsItem(position: position), let index = selectedModel.variationGroups.firstIndex(where: {$0.variationGroupsItemId == variationGroup.id}) else {return String()}
            return selectedModel.variationGroups[index].variationIds.selectionNameLabel
        default:
            return String()
        }
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
    
    func getMinPrice() -> Double? {
        return selectedModel.minimumPrice
    }
    
    func getMaxPrice() -> Double? {
        return selectedModel.maximumPrice
    }
    
    func clearFilter() {
        selectedModel.categoryIds = SelectionIds()
        selectedModel.brandIds = SelectionIds()
        selectedModel.variationGroups = []
        selectedModel.maximumPrice = nil
        selectedModel.minimumPrice = nil
        selectedModel.stockSwitch = false
        selectedModel.freeShippingSwitch = false
        selectedModel.discountedProductsSwitch = false
    }
    
    func getSelectedSwitchState(type: FilterSwitchType) -> Bool {
        switch type {
        case .stockSwitch:
            return selectedModel.stockSwitch
        case .discountedProductsSwitch:
            return selectedModel.discountedProductsSwitch
        case .freeShippingSwitch:
            return selectedModel.freeShippingSwitch
        }
    }
    
    func setSelectedSwitchState(type: FilterSwitchType, isOn: Bool) {
        switch type {
        case .stockSwitch:
            selectedModel.stockSwitch = isOn
        case .discountedProductsSwitch:
            selectedModel.discountedProductsSwitch = isOn
        case .freeShippingSwitch:
            selectedModel.freeShippingSwitch = isOn
        }
    }
    
    func getCurrency() -> CurrencyEnum {
        return CurrencyEnum.default
    }
    
    func getFilterChoiceViewModel() -> FilterChoiceViewModel? {
        switch getFilterListSelector(position: selectedIndexPath.row) {
        case .category:
            return FilterChoiceViewModel(dataList: filterOptions?.categories ?? [], selectedIds: selectedModel.categoryIds.selectedIds)
        case .brand:
            return FilterChoiceViewModel(dataList: filterOptions?.brands ?? [], selectedIds: selectedModel.brandIds.selectedIds)
        case .variationGroups(position: let position):
            guard let variationGroup = getVariationGroupsItem(position: position) else {return nil}
            if let index = selectedModel.variationGroups.firstIndex(where: {$0.variationGroupsItemId == variationGroup.id}) {
                return FilterChoiceViewModel(dataList: variationGroup, selectedIds:  selectedModel.variationGroups[index].variationIds.selectedIds)
            } else {
                return FilterChoiceViewModel(dataList: variationGroup)
            }
        default:
            return nil
        }
    }
    
    func choiceConfirmed(selectedIds: SelectionIds) {
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
