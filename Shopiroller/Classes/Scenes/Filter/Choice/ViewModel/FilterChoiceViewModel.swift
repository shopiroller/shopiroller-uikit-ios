//
//  FilterSelectionViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 30.11.2021.
//

import Foundation

class FilterChoiceViewModel: SRBaseViewModel {
    
    let title: String?
    let isMultipleChoice: Bool
    private var originalList: [GenericSelectionModel<FilterChoiceTableModel>] = []
    private var filteredList: [GenericSelectionModel<FilterChoiceTableModel>] = []
    
    init(dataList: [CategoriesItem], selectedIds: [String] = []) {
        title = "e_commerce_filter_category".localized
        isMultipleChoice = false
        super.init()
        configureDataList(dataList: dataList, depth: 1, selectedIds: selectedIds)
    }
    
    init(dataList: [BrandsItem], selectedIds: [String] = []) {
        title = "e_commerce_filter_brand".localized
        isMultipleChoice = true
        super.init()
        configureDataList(dataList: dataList, selectedIds: selectedIds)
    }
    
    init(dataList: VariationGroupsItem, selectedIds: [String] = []) {
        title = dataList.name
        isMultipleChoice = true
        super.init()
        configureDataList(dataList: dataList.variations ?? [], selectedIds: selectedIds)
    }
    
    func getFilteredListCount() -> Int {
        return filteredList.count
    }
    
    func getFilteredListData(position: Int) -> FilterChoiceTableModel {
        return filteredList[position].data
    }
    
    func isFilteredListSelected(position: Int) -> Bool {
        return filteredList[position].isSelected
    }
    
    func didSelectRow(position: Int) {
        filteredList[position].isSelected = !filteredList[position].isSelected
        for (index, item) in originalList.enumerated() {
            if(item.data.id == filteredList[position].data.id) {
                originalList[index].isSelected = !originalList[index].isSelected
                break
            }
        }
    }
    
    func didDeselectRow(position: Int) {
        filteredList[position].isSelected = false
        for (index, item) in originalList.enumerated() {
            if(item.data.id == filteredList[position].data.id) {
                originalList[index].isSelected = false
                break
            }
        }
    }
        
    func getSelectedIds() -> SelectionIds {
        var selectionNameLabel = String()
        var selectedIds: [String] = []
        for item in originalList {
            if(item.isSelected) {
                selectedIds.append(item.data.id)
                selectionNameLabel += item.data.name + ", "
            }
        }
        return SelectionIds(selectedIds: selectedIds, selectionNameLabel: String(selectionNameLabel.dropLast(2)))
    }
    
    func searchList(text: String?) {
        guard let text = text else {
            refreshList()
            return
        }
        filteredList.removeAll()
        for item in originalList {
            if(item.data.name.localizedCaseInsensitiveContains(text)) {
                filteredList.append(item)
            }
        }
    }
    
    func refreshList() {
        filteredList = originalList
    }
    
    private func configureDataList(dataList: [CategoriesItem], depth: Int, selectedIds: [String]) {
        for item in dataList {
            if let id = item.categoryId, let name = item.name?[Locale.current.languageCode ?? "en"] {
                originalList.append(GenericSelectionModel(data: FilterChoiceTableModel(id: id, name: name, depth: depth), isSelected: isSelectedId(id: id, selectedIds: selectedIds)))
            }
            if let subCategories = item.subCategories, !subCategories.isEmpty {
                configureDataList(dataList: subCategories, depth: depth + 1, selectedIds: selectedIds)
            }
        }
        filteredList = originalList
    }
    
    private func configureDataList(dataList: [BrandsItem], selectedIds: [String]) {
        for item in dataList {
            if let id = item.id, let name = item.name {
                
                originalList.append(GenericSelectionModel(data: FilterChoiceTableModel(id: id, name: name, depth: 1), isSelected: isSelectedId(id: id, selectedIds: selectedIds)))
            }
        }
        filteredList = originalList
    }
    
    private func configureDataList(dataList: [VariationsItem], selectedIds: [String]) {
        for item in dataList {
            if let id = item.id, let name = item.value {
                originalList.append(GenericSelectionModel(data: FilterChoiceTableModel(id: id, name: name, depth: 1), isSelected: isSelectedId(id: id, selectedIds: selectedIds)))
            }
        }
        filteredList = originalList
    }
    
    private func isSelectedId(id: String, selectedIds: [String]) -> Bool {
        if(!selectedIds.isEmpty) {
            for item in selectedIds {
                if(id == item) {
                    return true
                }
            }
        }
        return false
    }
    
}
