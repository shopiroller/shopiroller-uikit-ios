//
//  FilterSelectionViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 30.11.2021.
//

import Foundation

class FilterChoiceViewModel: BaseViewModel {
    
    private let dataList: [CategoriesItem]
    
    init(dataList: [CategoriesItem]) {
        self.dataList = dataList
    }
    
    func getDataListCount() -> Int {
        return dataList.count
    }
    
    func getCategoriesItem(position: Int) -> CategoriesItem {
        return dataList[position]
    }
}
