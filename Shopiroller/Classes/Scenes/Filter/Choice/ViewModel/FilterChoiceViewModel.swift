//
//  FilterSelectionViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 30.11.2021.
//

import Foundation

class FilterChoiceViewModel: BaseViewModel {
    
    let title: String?
    let isMultipleChoice: Bool
    private var tableViewList: [FilterChoiceTableViewModel] = []
    private var selectedItemPositions: [Int] = []
    private var selectionNameLabel = String()
    
    init(dataList: [CategoriesItem]) {
        title = "filter_category".localized
        isMultipleChoice = false
        super.init()
        var temp = dataList
        temp[0].subCategories = dataList
        temp[0].subCategories?[0].subCategories = dataList
        configureDataList(dataList: temp, depth: 1)
    }
    
    init(dataList: [BrandsItem]) {
        title = "filter_brand".localized
        isMultipleChoice = true
        super.init()
        configureDataList(dataList: dataList)
    }
    
    init(dataList: VariationGroupsItem) {
        title = dataList.name
        isMultipleChoice = true
        super.init()
        configureDataList(dataList: dataList.variations ?? [])
    }
    
    func getTableViewListCount() -> Int {
        return tableViewList.count
    }
    
    func getTableViewListItem(position: Int) -> FilterChoiceTableViewModel {
        return tableViewList[position]
    }
    
    func didSelectRow(position: Int) {
        selectedItemPositions.append(position)
    }
    
    func didDeselectRow(position: Int) {
        if let index = selectedItemPositions.firstIndex(of: position) {
            selectedItemPositions.remove(at: index)
        }
    }
    
    func getSelectedIds() -> [String] {
        var idArr: [String] = []
        for (index, item) in selectedItemPositions.enumerated() {
            idArr.append(tableViewList[item].id)
            selectionNameLabel += tableViewList[item].name
            if index != selectedItemPositions.count - 1 {
                selectionNameLabel += ", "
            }
        }
        return idArr
    }
    
    func getSelectionNameLabel() -> String {
        return selectionNameLabel
    }
    
    private func configureDataList(dataList: [CategoriesItem], depth: Int) {
        for item in dataList {
            if let id = item.categoryId, let name = item.name?["en"] {
                tableViewList.append(FilterChoiceTableViewModel(id: id, name: name, depth: depth))
            }
            if let subCategories = item.subCategories, !subCategories.isEmpty {
                configureDataList(dataList: subCategories, depth: depth + 1)
            }
        }
    }
    
    private func configureDataList(dataList: [BrandsItem]) {
        for item in dataList {
            if let id = item.id, let name = item.name {
                tableViewList.append(FilterChoiceTableViewModel(id: id, name: name, depth: 1))
            }
        }
    }
    
    private func configureDataList(dataList: [VariationsItem]) {
        for item in dataList {
            if let id = item.id, let name = item.value {
                tableViewList.append(FilterChoiceTableViewModel(id: id, name: name, depth: 1))
            }
        }
    }
    
}
