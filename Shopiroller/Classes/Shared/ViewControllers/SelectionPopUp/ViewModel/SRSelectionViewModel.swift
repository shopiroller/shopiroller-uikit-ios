//
//  SelectionPopUpViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 7.11.2021.
//

import Foundation

class SRSelectionViewModel: SRBaseViewModel {
    
    private var selectionPopUpModel: SelectionModel?
    private var filteredList: [CountryModel] = []
    private var selectionList: [CountryModel]?
    
    var searchText: String?
    
    init(selectionPopUpModel: SelectionModel? = nil) {
        self.selectionPopUpModel = selectionPopUpModel
    }
    
    func getItemCount() -> Int {
        return filteredList.count
    }
    
    func getCellModel(position: Int) -> CountryModel {
        return filteredList[position]
    }
    
    func getCountryId(position: Int) -> String {
        return getCellModel(position: position).id ?? ""
    }
    
    func filterContentForSearchText() {
        filteredList.removeAll()
        if let selectionList = selectionPopUpModel?.datalist as? [CountryModel] {
            if let searchText = searchText , searchText != ""  {
                for item in selectionList {
                    if(item.name?.lowercased().contains(searchText.lowercased()) ?? false) {
                        filteredList.append(item)
                    }
                }
            } else {
                filteredList = selectionList
            }
        }
        
    }
    
    func clearData() {
        searchText = nil
        filterContentForSearchText()
    }
    
    func getSelectionType() -> SelectionType? {
        return selectionPopUpModel?.selectionType
    }
 
}


