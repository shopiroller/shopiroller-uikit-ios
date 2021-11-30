//
//  FilterSelectionViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 30.11.2021.
//

import Foundation

class FilterChoiceViewModel: BaseViewModel {
    
    private var tableViewList: [FilterChoiceTableViewModel] = []
    private var _selectedIndexPath: IndexPath?
    
    init(dataList: [CategoriesItem]) {
        super.init()
        var temp = dataList
        temp[0].subCategories = dataList
        temp[0].subCategories?[0].subCategories = dataList
        configureDataList(dataList: temp, depth: 1)
    }
    
    var selectedIndexPath: IndexPath? {
        set { _selectedIndexPath = (_selectedIndexPath == newValue) ? nil : newValue }
        get { return _selectedIndexPath }
    }
    
    func getTableViewListCount() -> Int {
        return tableViewList.count
    }
    
    private func getCategoryName(item: CategoriesItem) -> String? {
        return item.name?["en"]
    }
    
    func getTableViewListItem(position: Int) -> FilterChoiceTableViewModel {
        return tableViewList[position]
    }
    
    private func configureDataList(dataList: [CategoriesItem], depth: Int) {
        for item in dataList {
            tableViewList.append(FilterChoiceTableViewModel(categoryId: item.categoryId, name: getCategoryName(item: item), depth: depth))
            if let subCategories = item.subCategories, !subCategories.isEmpty {
                configureDataList(dataList: subCategories, depth: depth + 1)
            }
        }
    }
    
    func getSelectedFilterChoiceTableViewModel() -> FilterChoiceTableViewModel? {
        guard let _selectedIndexPath = _selectedIndexPath else {
            return nil
        }
        return getTableViewListItem(position: _selectedIndexPath.row)
    }
    
    func isValid() -> Bool {
        return _selectedIndexPath != nil
    }
    
}

