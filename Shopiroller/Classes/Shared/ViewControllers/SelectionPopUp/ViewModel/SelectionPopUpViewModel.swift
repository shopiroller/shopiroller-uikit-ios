//
//  SelectionPopUpViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 7.11.2021.
//

import Foundation


class SelectionPopUpViewModel: SRBaseViewModel {
    
    private var selectionList: [CountryModel]
    private var filteredList: [CountryModel] = []
    
    private var stateModel : CountryModel?
    private var countryModel: CountryModel?
    private var citiesModel: CountryModel?
    
    var searchText: String?
    
    init(selectionList: [CountryModel] = [CountryModel]()){
        self.selectionList = selectionList
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
        if let searchText = searchText , searchText != "" {
            for item in selectionList {
                if(item.name?.lowercased().contains(searchText.lowercased()) ?? false) {
                    filteredList.append(item)
                }
            }
        } else {
            filteredList = selectionList
        }
    }
    
    func clearData() {
        searchText = nil
        filterContentForSearchText()
    }
 
}


