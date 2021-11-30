//
//  FilterViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 26.11.2021.
//

import Foundation

class FilterViewModel: BaseViewModel {
    
    private let searchText: String?
    private let categoryId: String?
    private let showcaseId: String?
    
    private var filterOptions: SRFilterOptionsResponseModel?
    private var filterListSelector: [FilterTableViewSelector] = []
    
    var selectedModel: FilterModel = FilterModel()
    
    init(searchText: String? = nil, categoryId: String? = nil, showcaseId: String? = nil) {
        self.searchText = searchText
        self.categoryId = nil
        self.showcaseId = showcaseId
    }
    
    func getFilterOptions(succes: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        var urlQueryItems: [URLQueryItem] = [
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
        if(!isCategoriesNullOrEmpty()) {
            filterListSelector.append(.category)
        }
        if(!isBrandsNullOrEmpty()) {
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
    
    func isCategoriesNullOrEmpty() -> Bool {
        return filterOptions?.categories?.isEmpty ?? true
    }
    
    func isBrandsNullOrEmpty() -> Bool {
        return filterOptions?.brands?.isEmpty ?? true
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
    
    func getFilterChoiceViewModel() -> FilterChoiceViewModel {
        return FilterChoiceViewModel(dataList: filterOptions?.categories ?? [])
    }
    
    func getSelectedCategoryName() -> String {
        var label =  ""
        for (index, item) in selectedModel.categoryIds.enumerated() {
            if let name = item.name {
                label += name
                if (index != selectedModel.categoryIds.count - 1) {
                    label += ","
                }
            }
        }
        return label
    }
    
    
}

enum FilterTableViewSelector {
    case category, brand, variationGroups(position: Int), priceRange, filterSwitch(type: FilterSwitchType)
}
